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
    var direction: Direction = .west
    var delegate: Panable?
    var panable: Bool = false{
        didSet{
            panStatusChanged()
        }
    }
    

    
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
        print("tapped")
        if !isExpanded {
            let newFrames = rectForDirection(direction: self.direction)
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.frame = newFrames.base
                self.expandButton!.frame = newFrames.sub
            }
            layoutActionButtons()
        }
        else {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                let originalFrame = self.rectForContractionFrom(direction: self.direction)
                self.frame = originalFrame
                self.expandButton!.frame.origin = CGPoint(x: 0, y: 0)
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
        UIView.animate(withDuration: 0.5) { [unowned self] in
            for i in 1...self.actions.count {
                self.addSubview(self.actions[i - 1].button)
                let thisAction = self.actions[i - 1]
                let coordinates = self.coordinatesForDirection(direction: self.direction, position: i)
                
                let x = coordinates.x
                let y = coordinates.y
                thisAction.button.frame.origin = CGPoint(x: x, y: y)
            }
            self.exchangeSubview(at: 0, withSubviewAt: self.actions.count)
        }
    }
    
    func coordinatesForDirection(direction: Direction, position: Int) -> (x: CGFloat, y: CGFloat){
        var x: CGFloat
        var y: CGFloat
        
        switch(direction){
        case .east:
            x = self.bounds.origin.x + self.minSize*CGFloat(position)
            y = self.bounds.origin.y
        case .west:
            x = self.maxSize - minSize*CGFloat(position + 1)
            y = self.bounds.origin.y
        case .south:
            x = self.bounds.origin.x
            y = self.bounds.origin.y + self.minSize*CGFloat(position)
        case .north:
            x = self.bounds.origin.x
            y = self.maxSize - minSize*CGFloat(position + 1)
        }
        return (x,y)
    }
    
    func rectForContractionFrom(direction: Direction) -> CGRect{
        switch direction {
        case .east, .south:
            return CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.minSize, height: self.minSize)
        case .west:
            return CGRect(x: self.frame.origin.x + maxSize - minSize, y: self.frame.origin.y, width: minSize, height: minSize)
        case .north:
            return CGRect(x: self.frame.origin.x, y: self.frame.origin.y + maxSize - minSize, width: minSize, height: minSize)
        }
        
    }
    
    
//    func contractToFrameFrom(direction:Direction) -> CGPoint{
//        switch(direction){
//        case .east, .south:
//            return self.bounds.origin
//        case .west, .north:
//            x = self.bounds.origin
//            
//            
//        }
//    }

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
    
    
    func rectForDirection(direction: Direction) -> (base: CGRect,sub: CGRect ){
        var base: CGRect
        var sub: CGRect
        switch(direction){
        case .east:
             base = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: maxSize, height: minSize)
             sub = expandButton!.bounds
        
        case .west:
             base = CGRect(x: self.frame.origin.x - maxSize + minSize, y: self.frame.origin.y, width: maxSize, height: minSize)
             let x = maxSize - minSize
             sub = CGRect(x: x, y: self.bounds.origin.y, width: minSize, height: minSize)
        
        case .south:
            base = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: minSize, height: maxSize)
            sub = expandButton!.bounds
        
        case .north:
            base = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - maxSize + minSize, width: minSize, height: maxSize)
            let y = maxSize - minSize
            sub =  CGRect(x: self.bounds.origin.y, y: y, width: minSize, height: minSize)
        }
        return (base, sub)
    }
    
    func panStatusChanged(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(callDelegate))
        
        
        if self.panable && self.expandButton!.gestureRecognizers == nil{
            self.expandButton!.addGestureRecognizer(panGesture)
        }
        if !panable{
            self.expandButton!.removeGestureRecognizer(panGesture)
        }
    }
    
    func callDelegate(){
        print("calling delegate")
//        let sender = self.expandButton!.gestureRecognizers![0] as! UIPanGestureRecognizer
        self.delegate?.moveToolbar(sender: self.expandButton!.gestureRecognizers![0] as! UIPanGestureRecognizer, source: self)
    }
    
}





enum Direction{
    case north
    case south
    case east
    case west
}

struct ToolbarAction {
    var button: UIButton
    var action: () -> ()
}


protocol Panable{
    func moveToolbar(sender: UIPanGestureRecognizer, source:UIView)
}

extension Panable where Self: UIViewController{
    func moveToolbar(sender: UIPanGestureRecognizer, source: UIView){
        if sender.state == .began || sender.state == .changed {
            
            let translation = sender.translation(in: self.view)

            source.center = CGPoint(x: source.center.x + translation.x, y: source.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}




