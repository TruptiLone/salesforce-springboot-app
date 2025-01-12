({
    doInit : function(component, event, helper) {
        var orderId = component.get("v.orderId")
        var action = component.get("c.OrderProductDetail");
        action.setParams({
            OrderId : orderId

        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("OrdersProductDetails: " + response.getReturnValue())
                component.set("v.orderProductDetails", response.getReturnValue()); 
                
                var orderList = component.get("v.orderProductDetails");
                console.log("Order Product detail List : "+JSON.stringify(orderList));
                
                // var test = component.set("v.test", JSON.parse(orderList)); 
                // console.log("Test Test: "+test);

                for(var i =0;i<orderList.length;i++)
                 {
                 var temp=orderList[i];   

                 console.log("Stringify array: "+JSON.stringify(temp)); 
                 console.log("Entry: "+temp.Order__r.Name)  ;

                 console.log("Entry: "+temp.Order__r.Order_Status__c)  ;
                 console.log("Entry: "+temp.Order__r.Date_of_Order_Placed__c)  ;
                 component.set("v.orderStatus",temp.Order__r.Order_Status__c);
                 component.set("v.orderName",temp.Order__r.Name);
                 component.set("v.orderDate",temp.Order__r.Date_of_Order_Placed__c);
                 break;
                 
                 }

                //for(key in orderList) {
                //    console.log("v.orderName "+orderList[key].Order__r.Name);
                    //console.log("v.orderStatus "+orderList[key].Order__r.Order_Status__c);
                    //console.log("v.orderDate "+orderList[key].Order__r.Date_of_Order_Placed__c);

                    //component.set("v.orderName",orderList[key].Order__r.Name);
                    //component.set("v.orderStatus",orderList[key].Order__r.Order_Status__c);
                    //component.set("v.orderDate",orderList[key].Order__r.Date_of_Order_Placed__c);
                    //break;
   
               // }
                

            }
        });
        $A.enqueueAction(action);
       

    },
    viewmore : function(component, event, helper){
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "https://springblossom-dev-ed.lightning.force.com/lightning/r/WebSite__c/a033t00000U3BaJAAV/view"
        });
        urlEvent.fire();

    }
    
})