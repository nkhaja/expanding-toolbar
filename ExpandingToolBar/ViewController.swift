//
//  ViewController.swift
//  ExpandingToolBar
//
//  Created by Nabil K on 2017-01-26.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Panable {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = CGRect(x: 200, y: 250, width: 200, height: 50)
        let toolbar = ExpandingToolBar(frame: frame, buttonSize: 500)
        toolbar.addAction(title: "orange", action: makeOrange)
        toolbar.addAction(title: "red", action: makeRed)
        toolbar.addAction(title: "blue", action: makeBlue)
        toolbar.panable = true
        toolbar.delegate = self
        
        self.view.addSubview(toolbar)
    }
    
    func makeOrange() -> (){
        self.view.backgroundColor = UIColor.orange
        print("orange")
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

