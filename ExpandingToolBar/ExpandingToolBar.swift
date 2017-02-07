//
//  ExpandingToolBar.swift
//  ExpandingToolBar
//
//  Created by Nabil K on 2017-01-26.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class ExpandingToolBar: UIView {

    var maxSize: CGFloat = 0
    var minSize: CGFloat = 0
    var canExpand: Bool = true
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green]
    var isExpanded = false
    var actions = [ToolbarAction]()
    var numActions: CGFloat = 1
    var buttonSize: CGFloat = 0
    var expandButton: UIButton?
    var direction: Direction = .right
    
    

    
    init(frame: CGRect, buttonSize: CGFloat?) {
        
        //Min size must be symmetrical
        var height: CGFloat
        var width: CGFloat
        
        if frame.height > frame.width{
            self.minSize = frame.width
            self.maxSize = frame.height
            width = minSize
            height = width
        }
        else{
            self.minSize = frame.height
            self.maxSize = frame.width
            height = minSize
            width = height
        }
        
        if let buttonSize = buttonSize{
            self.buttonSize = buttonSize
        }
        else{
            self.buttonSize = minSize
        }
        

        let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: height)
        super.init(frame: newFrame)
        
        
        self.backgroundColor = UIColor.red
        buildExpandButton()
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildExpandButton(){
        let buttonRect = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: minSize, height: minSize)
        expandButton = UIButton(frame: buttonRect)
        if let expandButton = expandButton {

            self.addSubview(expandButton)
            expandButton.backgroundColor = UIColor.green
            expandButton.addTarget(self, action: #selector(expand), for: .touchUpInside)
            expandButton.setTitle("TT", for: .normal)
            
        }
    }
    
    func expand(){
        if self.direction == .right {
            //do as below

        }
   
        
        if !isExpanded {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.maxSize, height: self.frame.height)
            }
            layoutActionButtons()
        }
        else {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.minSize, height: self.minSize)
            }
            contractActionButtons()
        }
        
        isExpanded = !isExpanded
    }
    
    
    func addAction(title:String, action:  @escaping () -> ()){
        self.numActions += 1
        let x = self.bounds.origin.x
        let y = self.bounds.origin.y
        
        let buttonRect = CGRect(x: x, y: y, width: minSize, height: minSize)
        let button = UIButton(frame: buttonRect)
        button.backgroundColor = UIColor.brown
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(triggerAction(sender:)), for: .touchUpInside)
        let toolbarAction = ToolbarAction(button: button, action: action)
        actions.append(toolbarAction)
    }
    
    func layoutActionButtons(){
        UIView.animate(withDuration: 0.5) {
            for i in 1...self.actions.count {
                self.addSubview(self.actions[i - 1].button)
                let thisAction = self.actions[i - 1]
                let x = self.bounds.origin.x + self.minSize*CGFloat(i)
                let y = self.bounds.origin.y
                thisAction.button.frame.origin = CGPoint(x: x, y: y)
                self.exchangeSubview(at: 0, withSubviewAt: self.actions.count)
            }
        }
    }
    
    func contractActionButtons(){
       UIView.animate(withDuration: 0.5, animations: {
        for i in 0..<self.actions.count {
            let thisAction = self.actions[i]
            thisAction.button.frame.origin = self.bounds.origin
        }
       }){ completed in
        
        for a in self.actions{
            a.button.removeFromSuperview()
        }
    }

    }
    
    
    func triggerAction(sender:UIButton){
        for a in actions{
            if sender == a.button{
                a.action()
            }
        }
        
        
    }
}

enum Direction{
    case up
    case down
    case left
    case right
}

struct ToolbarAction {
    var button: UIButton
    var action: () -> ()
}




