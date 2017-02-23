//
//  ViewController.swift
//  ExpandingToolBar
//
//  Created by Nabil K on 2017-01-26.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Pannable {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let frame = CGRect(x: 200, y: 250, width: 200, height: 50)
        let toolbar = ExpandingToolBar(frame: frame, buttonSize: 50)
        
        
        toolbar.addAction(title: "green", font: nil, image: nil, color: UIColor.green, action: makeGreen)
        
        
        toolbar.addAction(title: "blue", font: nil, image: nil, color: UIColor.blue, action: makeBlue)
        
       // toolbar.addAction(title: "red", font: nil, image: nil, color: UIColor.red, action: makeRed)
        
        toolbar.addAction(title: "red", font: nil, image: nil, color: UIColor.red) { 
            self.view.backgroundColor = UIColor.red
        }
        
        
        toolbar.panable = true
        toolbar.panDelegate = self
        self.view.addSubview(toolbar)
        toolbar.layer.cornerRadius = 5
    }
    
    func makeGreen() -> (){
        self.view.backgroundColor = UIColor.green
        print("green")
    }
    
    func makeBlue(){
        self.view.backgroundColor = UIColor.blue
        print("blue")
    }
    
    func makeRed(){
        self.view.backgroundColor = UIColor.red
        print("red")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

