({
    onCarouselClick : function(component, event, helper) {
        console.log("Product has been selected!");
        var product = component.get("v.Product");
        console.log("Products in Product Carousel : "+product);

        console.log("before productSeleted");
        var productSelected = $A.get("e.c:SelectedProduct");
        console.log("after commenting productSeleted");

        console.log("setting parameters for event1");
        productSelected.setParams({
            product: product
        });
        console.log("setting parameters for event2");
       productSelected.fire();
        console.log("SelectedProduct Event fired printing "+productSelected);
       

    }
})