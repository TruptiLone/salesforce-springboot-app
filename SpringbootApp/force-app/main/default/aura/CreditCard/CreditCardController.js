({
    
    submit : function(component, event, helper) {
        var action = component.get("c.processPaymentAndCreateOrder");
        var cardnumber = component.get("v.cardnumber");
        action.setParams({
            "cardNumber": cardnumber
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log("Test CreditCard CMP: "+JSON.stringify(state));
            if(state === "SUCCESS"){
                console.log("Credit card is valid ");
                var orderProcess = response.getReturnValue();
                component.set("v.orderId", response.getReturnValue()); 
                console.log("Check orderProcess: "+JSON.stringify(orderProcess));

                if(orderProcess === "PAYMENT_FAILED")
                {
                    alert("Card Invalid");
                }else{
                    //component.set("v.response", response.getReturnValue()); 
                    //alert("Order Id is:  "+orderProcess);
               
                    // var navService = component.find("navService");
                    // var pageRef = {
                    //     type: "standard__component",
                    //     attributes: {
                    //         "componentName": "c__MyLightningComponent"
                    //     },
                    //     state: {
                    //         "orderId": orderProcess 
                    //     }
                    // }

                    var evt = $A.get("e.force:navigateToComponent");
                    evt.setParams({
                        componentDef : "c:OrderProductDetail",
                        componentAttributes: {
                            orderId : orderProcess,
                            total : component.get("v.total")
                        }
                    });
                    evt.fire();
                }  
            }
        });
        $A.enqueueAction(action);




    }
})