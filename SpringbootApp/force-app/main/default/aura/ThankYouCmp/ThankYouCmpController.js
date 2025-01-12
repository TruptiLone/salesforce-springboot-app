({
    // onPageReferenceChange: function(cmp, evt, helper) {
    //     var myPageRef = cmp.get("v.pageReference");
    //     var id = myPageRef.state.c__id;
    //     cmp.set("v.id", id);
    // }

    
    checkout : function(component, event, helper) {
        var action = component.get("c.OrderProductDetail");
        var orderId = component.get("v.orderId");
        action.setParams({
            OrderId: orderId
        }); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("Response for Order="+ state);
            if (state === "SUCCESS") {

                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Created",
                    "message": "Order has been placed."
                });
                resultsToast.fire();

            }
        });
        $A.enqueueAction(action);
    }

})