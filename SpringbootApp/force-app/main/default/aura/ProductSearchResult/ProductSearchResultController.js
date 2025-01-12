({
    doSearch: function (component, event, helper) {
        var kartTypeId = '';
        // arguments is the argument passed to the aura:method from KartSearch
        var kartTypeIdEvt = event.getParam('arguments');
        console.log(kartTypeIdEvt); 

        if (kartTypeIdEvt) {
            console.log('kartTypeEventId', kartTypeIdEvt.kartTypeId);
            kartTypeId = kartTypeIdEvt.kartTypeId;
        }

        console.log('id sent to helper: ' + kartTypeId);

        helper.onSearch(component, event, helper, kartTypeId);
    },
    doInit: function (component, event, helper) {
        console.log("Test for 2nd doInit");
        helper.onSearch(component, event, helper, "AllProducts");

    },
    
    handleProductSearch : function(component, event, helper) {
        console.log("I am Handling the event");

        // arguments is the argument passed to the aura:method from KartSearch
        var productTypeId = event.getParam('productTypeId');
        console.log(productTypeId); 

        helper.onSearch(component, event, helper, productTypeId);


    }
})