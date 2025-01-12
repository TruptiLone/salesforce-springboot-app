({
    createCustomer: function(component, customer) {
        let theExpenses = component.get("v.customers");
        // Copy the customer to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        let newCustomer = JSON.parse(JSON.stringify(customer));
        theCustomers.push(newCustomer);
        component.set("v.customer", theCustomers);
    }
})