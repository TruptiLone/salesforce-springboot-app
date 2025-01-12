({
    clickCreate: function(component, event, helper) {
        console.log("Create customer: ");
        let validCustomer = component.find('customerform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validCustomer){
            // Create the new expense
            console.log("Create customer: " + JSON.stringify(newCustomer));
            let newCustomer = component.get("v.newCustomer");
            console.log("Create customer: " + JSON.stringify(newCustomer));
            helper.createCustomer(component, newCustomer);
        }
    }
})