({
    getProductType : function(component) {
        var action = component.get("c.getProductType");
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state === "SUCCESS"){
                component.set("v.ProductType", response.getReturnValue());
                console.log('Test');
            }
        });
        $A.enqueueAction(action);

    

    }
})