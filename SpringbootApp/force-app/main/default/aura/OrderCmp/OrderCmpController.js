({
    doInit : function(component, event, helper) {
        var action = component.get("c.orderList");
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("Orders: " + response.getReturnValue())
                component.set("v.orders", response.getReturnValue()); 
                var orderList = component.get("v.orders");
                console.log("Order List : "+JSON.stringify(orderList));

            }
        });
        $A.enqueueAction(action);
       

    }
})