//
//  WFAlertController.swift
//  WFAlertTest
//
//  Created by Wolf on 15/10/7.
//  Copyright © 2015年 Wolf. All rights reserved.
//

import UIKit

enum WFAlertActionStyle{

    case Cancel
    case Default
    case Destructive
    
}


class WFAlertAction{

    var title:String?
    var style:WFAlertActionStyle
    var handler:(() -> Void)?
    
    init(title:String?, style:WFAlertActionStyle, handler:(() -> Void)?){
        
        self.title = title
        self.style = style
        self.handler = handler
        
    }
    

}



class WFAlertController: NSObject,UIAlertViewDelegate {
    
    private var actions:[WFAlertAction]?
    private var handlers:[(() -> Void)?]?
    private var showHandler:((controller:UIViewController)->Void)?
//    private var alertView:UIAlertView?

    init(title:String?,message:String?,actions:[WFAlertAction]){
        
        super.init()
        
        if #available(iOS 8, *){
            
            print("ios 8")
            
            self.actions = actions
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)

            for action in actions{

                var style:UIAlertActionStyle?
                
                switch action.style{
                case .Cancel:
                    style = UIAlertActionStyle.Cancel
                case .Default:
                    style = UIAlertActionStyle.Default
                case .Destructive:
                    style = UIAlertActionStyle.Destructive
                    
                }
                
                
                let alertAction = UIAlertAction(title: action.title, style: style!, handler: { (uiaction:UIAlertAction) -> Void in
                  
                    action.handler?()

                })
                
                alert.addAction(alertAction)
                
                self.showHandler = { (controller:UIViewController) -> Void in
                
                    controller.presentViewController(alert, animated: true, completion: nil)
                
                }
                
            }
            
            
            
            
        }
        else{
            //what's in pre ios 7
//            
            print("ios 7")

            var cancel:WFAlertAction?
            for action in actions{
                if action.style == WFAlertActionStyle.Cancel{
                    cancel = action
                    self.handlers?.append(action.handler)
                }

            }

            let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: cancel?.title)
            
            for action in actions{
                if action.style == WFAlertActionStyle.Cancel{
                    
                }
                else{
                    alertView.addButtonWithTitle(action.title)
                    self.handlers?.append(action.handler)
                }
            }
            
            self.showHandler = { (controller:UIViewController) -> Void in
                
//                controller.presentViewController(alert, animated: true, completion: nil)
                alertView.show()
                
            }
            
        }
    
    }
    
    func show(controller:UIViewController){
    
        self.showHandler?(controller: controller)
    
    }
    
    
}










