({
    onSearch : function(component, event, helper, productTypeId) {
        console.log('productTypeId in helper: ', +productTypeId);
        var action = component.get("c.getProducts");
        action.setParams({
            productTypeId: productTypeId
        }); 
        console.log("Product Id"+productTypeId)
        action.setCallback(this, function(response){
            var state = response.getState(); 
            console.log("state: " + state); 
            if(state === "SUCCESS"){
                console.log("products: " + response.getReturnValue()); 
                component.set("v.Products", response.getReturnValue()); 
                console.log('Ptoduct att: ' + component.get("v.Products")); 
            }
        });

        $A.enqueueAction(action); 


    }
})