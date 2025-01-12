({   doInit: function (component, event, helper) {
    helper.getCartId(component, event, helper,"");

    },
    onProductSelected: function (component, event, helper) {

       
        console.log("handling event for  onProductSelected");
        var product = event.getParam("product");
        console.log("product object "+product);
        console.log("product  Id before if "+product.Id);


        if (product) {
            component.set("v.showTabs", true);
            console.log("product  Id inside if "+product.Id);
            
           
            component.set("v.id", product.Id);
            console.log("product  Id inside if after set "+product.Id);
            console.log("product  Id inside if after set "+product.Product_Name__c);


            //console.debug("Kart tabs detail Kart Id="+kart.Name);
            //console.debug("Kart tabs detail Kart Id="+kart.Id);
            component.find("service").reloadRecord();
            console.log('Done');
            component.find("tabs").set("v.selectedTabId","detailstab");

            var childComponent = component.find("childCmp");
            console.log("Invoking perform do init starting");
           childComponent.performDoInit();
           console.log("Invoking perform do init completed");



    
        }
    },
    handleCartIcon : function (component, event) {
        component.find("tabs").set("v.selectedTabId","carttab");
        
    },

    //addToCartJunction : function (component, event, helper){
        
    //}
})