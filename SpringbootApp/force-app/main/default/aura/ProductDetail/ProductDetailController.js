({
    myAction : function(component, event, helper) {

    },

    addToCart : function (component, event, helper) {
            //alert("You clicked: " + event.getSource().get("v.label"));



            component.set("v.inputNewProductCartJunction.Cart__c",component.get("v.cart.Id"));

            component.set("v.inputNewProductCartJunction.Product__c",component.get("v.product.Id"));

            var setValue = component.get("v.inputNewProductCartJunction");

            console.log("Junction record: "+JSON.stringify(setValue));

            //Save record
            component.find("ProductCartJunctionRecordCreator").saveRecord(function(saveResult) {
                console.log("state for product cart junction="+JSON.stringify(saveResult));
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "Added to Cart."
                    });
                    resultsToast.fire();

                     //Get the event using event name. 
                    var appEvent = $A.get("e.c:AddToCart"); 
                   
                    appEvent.fire();

                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    console.log('Problem saving contact, error: ' +
                                 JSON.stringify(saveResult.error));
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state +
                                ', error: ' + JSON.stringify(saveResult.error));
                }
            });


            //Get the event using registerEvent name. 
            //var addToCartEvent = component.getEvent("AddToCart"); 
            //Set event attribute value
           // addToCartEvent.fire(); 
    },
    doInit: function(component, event, helper) {
        // Prepare a new record from template
        console.log("Performing init for product detail component");
        component.find("ProductCartJunctionRecordCreator").getNewRecord(
            "ProductCartJunction__c", // sObject type (entityAPIName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newProductCartJunction");
                var error = component.get("v.newProductCartJunctionError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else {
                    console.log("Record template initialized: " + JSON.stringify(rec));
                }
            })
        );
    },
    
})