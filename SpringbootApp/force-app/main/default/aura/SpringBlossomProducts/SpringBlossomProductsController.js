({
    doInit : function(component, event, helper) {
        helper.getProductType(component, event, helper);

        var productSearchEvt = $A.get("e.c:ProductSearch");
        productSearchEvt.setParams({
            productTypeId : "AllProducts"
        });
        productSearchEvt.fire();
        console.log("Event has been fired from doInit");


    },
    searchProducts : function (component, event, helper) {
        var selectedProductType = component.find("selectedProductType");
        var productTypeId = selectedProductType.get("v.value");
        //var kartKey = selectedKartType.get("v.key");
        console.log('selectedProductType = '+selectedProductType);
        console.log('productTypeId: ' + productTypeId);
        //console.log('Key from form: ' + kartKey); 
 
  
        var productSearchEvt = $A.get("e.c:ProductSearch");
        productSearchEvt.setParams({
            productTypeId : productTypeId
        });
        productSearchEvt.fire();
        console.log("Event has been fired");
     }
})