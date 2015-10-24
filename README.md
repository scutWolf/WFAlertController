# WFAlertController

###How to use: 

###You need to save it as property, or it would be auto-release, in which delegate method would not called

```swift 
    var alert:WFAlertController?
```
###Usage:
```swift

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
   
   self.alert = WFAlertController(title: "test title", message: "test message", style: WFAlertStyle.Alert, actions: actions)
   
   self.alert?.show(self)
        
```

###Warning: You can only add one action whose style is WFAlertActionStyle.Cancel.
