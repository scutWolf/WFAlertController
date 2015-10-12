# WFAlertController

###How to use: 

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
   
   let alert = WFAlertController(title: "test title", message: "test message", style: WFAlertStyle.ActionSheet, actions: actions)
   
   alert.show(self)
        
```

###Warning: You can only add one action whose style is WFAlertActionStyle.Cancel.
