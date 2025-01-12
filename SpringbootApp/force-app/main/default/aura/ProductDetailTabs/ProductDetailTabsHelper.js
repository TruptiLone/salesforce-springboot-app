({
        getCartId: function (component, event, helper, cartTypeId) {
            console.log('cartTypeId in helper: ', cartTypeId);
            var action = component.get("c.getCartRecord");
           
            action.setCallback(this, function(response){
                var state = response.getState(); 
                console.log("state: " + state); 
                if(state === "SUCCESS"){
                    console.log("cart: " + response.getReturnValue()); 
                    component.set("v.cart", response.getReturnValue()); 
                    console.log('cart Id: ' + component.get("v.cart").Id); 
                    console.log('cart att: ' + component.get("v.cart")); 
                }
            });
    
            $A.enqueueAction(action); 
        }
})