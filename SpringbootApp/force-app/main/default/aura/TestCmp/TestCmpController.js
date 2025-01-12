({
	doInit : function(component, event, helper) {
           var action = component.get("c.getContacts");
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("Contacts: " + response.getReturnValue())
                component.set("v.conList", response.getReturnValue()); 
                var conList = component.get("v.conList");
                console.log("Order List : "+JSON.stringify(conList));

            }
        });
        $A.enqueueAction(action);
       
		
	}
})