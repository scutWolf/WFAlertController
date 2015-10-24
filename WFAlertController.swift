//
//  WFAlertController.swift
//  WFAlertTest
//
//  Created by Wolf on 15/10/7.
//  Copyright © 2015年 Wolf. All rights reserved.
//

import UIKit

enum WFAlertStyle{
    
    case Alert
    case ActionSheet

}

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



class WFAlertController: NSObject,UIAlertViewDelegate,UIActionSheetDelegate {
    
    private var actions:[WFAlertAction]?
//    private var handlers:[(() -> Void)?]?
    private var showHandler:((controller:UIViewController)->Void)?
//    private var alertView:UIAlertView?
    
    private var orderedActions:[WFAlertAction]?

    init(title:String?,message:String?,style:WFAlertStyle,actions:[WFAlertAction]){
        
        super.init()
        
        self.actions = actions
        
        if #available(iOS 8, *){
            
            print("ios 8")
            

            var alertStyle:UIAlertControllerStyle = UIAlertControllerStyle.Alert
            
            switch style{
            case .Alert:
                alertStyle = UIAlertControllerStyle.Alert
            case .ActionSheet:
                alertStyle = UIAlertControllerStyle.ActionSheet
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
            
            for action in actions{

                var actionStyle:UIAlertActionStyle?
                
                switch action.style{
                case .Cancel:
                    actionStyle = UIAlertActionStyle.Cancel
                case .Default:
                    actionStyle = UIAlertActionStyle.Default
                case .Destructive:
                    actionStyle = UIAlertActionStyle.Destructive
                    
                }
                
                
                let alertAction = UIAlertAction(title: action.title, style: actionStyle!, handler: { (uiaction:UIAlertAction) -> Void in
                  
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
            
            if style == WFAlertStyle.Alert{
            
                self.orderedActions = []
                
                var cancel:WFAlertAction?

                for index in 0..<actions.count {
                    let action = actions[index]
                    if action.style == WFAlertActionStyle.Cancel{
                        cancel = action
//                        self.handlers?.append(cancel!.handler)
//                        self.orderedActions?.removeAtIndex(index)
                        self.orderedActions?.insert(action, atIndex: 0)
                        
                    }
                
                }

                let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: cancel?.title)
                

                
                for index in 0..<actions.count {
                
                    let action = actions[index]
                    
                    if action.style == WFAlertActionStyle.Cancel{

                        
                    }
                    else{
                        alertView.addButtonWithTitle(action.title)
//                        self.orderedActions?.insert(action, atIndex: 0)
                        self.orderedActions?.append(action)
                    }
                    
                    
                }
                
                self.showHandler = { (controller:UIViewController) -> Void in
                    
                    alertView.show()
                    
                }
            }
                
            else if style == WFAlertStyle.ActionSheet{

                var cancelIndex = -1
                var descructiveIndex = -1
                
                var cancel:WFAlertAction?
                var destructive:WFAlertAction?

                for index in 0..<actions.count {
                    let action = actions[index]
                    if action.style == WFAlertActionStyle.Cancel{
                        cancel = action
//                        //                        self.handlers?.append(cancel!.handler)
//                        self.orderedActions?.removeAtIndex(index)
//                        self.orderedActions?.insert(action, atIndex: 0)

                        cancelIndex = index
                    }
                    
                    if action.style == WFAlertActionStyle.Destructive{
                        destructive = action
                        //                        self.handlers?.append(destructive!.handler)
                        //                        break;
                        descructiveIndex = index
                    }
                    
                }
                
                self.orderedActions = []
                
                if(cancelIndex>=0){
                
                    self.orderedActions!.append(self.actions![cancelIndex])
                    
                }
                
                if(descructiveIndex>=0){
                    
                    self.orderedActions!.append(self.actions![descructiveIndex])
                    
                }

                
                let actionSheet = UIActionSheet(title: title, delegate: self, cancelButtonTitle: cancel?.title, destructiveButtonTitle: destructive?.title)
            
                for action in actions{
                    if action.style == WFAlertActionStyle.Cancel || action.style == WFAlertActionStyle.Destructive{
                        
                    }
                    else{
                        actionSheet.addButtonWithTitle(action.title)
//                        self.handlers?.append(action.handler)
                        self.orderedActions?.append(action)
                        
                    }
                }
                
                self.showHandler = { (controller:UIViewController) -> Void in
                    
                    actionSheet.showInView(controller.view)
                    
                }
            }
            
        }
    
    }
    
    func show(controller:UIViewController){
    
        self.showHandler?(controller: controller)
    
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if let actions = self.orderedActions{
        
            if buttonIndex < actions.count {
                let action = actions[buttonIndex]
                action.handler?()
            }
        
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if let actions = self.orderedActions{
            
            if buttonIndex < actions.count {
                let action = actions[buttonIndex]
                action.handler?()
            }
            
        }
    }
    
}










