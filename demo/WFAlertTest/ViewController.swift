//
//  ViewController.swift
//  WFAlertTest
//
//  Created by Wolf on 15/10/3.
//  Copyright © 2015年 Wolf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: AnyObject) {
        
        let cancel = WFAlertAction(title: "cancel", style: WFAlertActionStyle.Cancel, handler:  {
            print("cancel")
        })
        
        let action0 = WFAlertAction(title: "action0", style: WFAlertActionStyle.Default, handler: {
            print("action0")
        })
        
        let action1 = WFAlertAction(title: "action1", style: WFAlertActionStyle.Default, handler: {
            print("action1")
        })

        let actions = [cancel,action0,action1]
        
        let alert = WFAlertController(title: "test title", message: "test message", actions: actions)
        
        alert.show(self)
        
    }

}

