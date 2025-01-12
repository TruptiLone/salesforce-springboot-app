({
    doInit : function(component, event, helper) {

        if (component.get("v.cadPrice") == 0.00 &&  component.get("v.eurPrice") == 0.00) {
            helper.convert(component, event, helper);
        }
        
        var action = component.get("c.getProductCartData");
        var cartId = component.get("v.cart.Id");
        console.log("cartId "+cartId);
        action.setParams({
            cartId : cartId

        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Success!")
                var temp = response.getReturnValue();
                for(var key in temp){
                    var current = temp[key];
                    console.log("USD price="+current["Product__r"]["Price__c"]);
                    console.log("cad rate="+component.get("v.cadPrice"))

                    current["CadPrice"] = component.get("v.cadPrice") * current["Product__r"]["Price__c"];
                    current["EurPrice"] = component.get("v.eurPrice") * current["Product__r"]["Price__c"];
                    console.log("Key = "+key);
                    console.log("Value = "+JSON.stringify(temp[key]));
                }
                component.set("v.cartItems", temp);
                console.log(JSON.stringify(component.get("v.cartItems")));
                var cartItems = component.get("v.cartItems");
                //helper.convert(component, event, helper);
                var price = 0;
                for(var key in cartItems){
                   price = price + cartItems[key].Product__r.Price__c;
                   helper.convert(component, event, helper,price);
                   console.log(price);
                }
                component.set("v.total", price);
            }
        });
        $A.enqueueAction(action);


    },

       checkout : function(component, event, helper) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:CreditCard",
            componentAttributes: {
                total : component.get("v.total")
            }

           
        });
        evt.fire();
     
    },
    Ondelete : function(component, event, helper){
        console.log("On Adityas Demand"+JSON.stringify(event));
        console.log("Aditya I want cake lets go to PG")
        //alert("You selected: " + event.target.Id);
    },



    delete : function(component, event, helper){
        var action = component.get("c.deleteProductCartData");
        var itemToDelete = component.get("v.cartItems");
        //console.log("On Adityas Demand"+JSON.stringify(event));
        console.log("Aditya I want cake lets go to PB")

        //alert("You selected: " + event.getSource().get("v.value"));
        //alert(event.getSource().getLocalId())
        action.setParams({
            pid : event.getSource().get("v.value")

        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
                console.log(" Delete Success!");
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Deleted",
                    "message": "Item has been Deleted."
            });
            resultsToast.fire();
            
        }
            
        });
        $A.enqueueAction(action);



    },
    convert : function(component, event, helper) {
        let a = window.SpeechRecognition;
        console.log('a',a);
        let state, action, ret, opts = [],
            unformatobj;
        action = component.get('c.calloutCurrency');
        action.setCallback(this, function(response) {
            state = response.getState();
            if (state === "SUCCESS") {
                ret = response.getReturnValue();
                ret = JSON.parse(ret);

                unformatobj = ret['quotes'];
                console.log('unformatobj: '+unformatobj+' JSON Stringify '+JSON.stringify(unformatobj));
                Object.keys(unformatobj).map(val => {
                    opts.push({
                        'label': val.slice(3),
                        'value': unformatobj[val].toFixed(2)
                    });
                    console.log('unformatobj: '+val, unformatobj[val]);
                   
                })
                
            }
            console.log('opts', opts);
            opts.push({
                'label': 'USD',
                'value': 1,
                'selected' : true
            });
            component.set('v.options', opts);
        });
        $A.enqueueAction(action);
    }
})