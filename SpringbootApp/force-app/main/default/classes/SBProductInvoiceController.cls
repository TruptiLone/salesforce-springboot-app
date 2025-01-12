public with sharing class SBProductInvoiceController {
    public List<OrderProductJunction__c> orderProductList{get;set;}
    public Buyer__c buyer{get;set;}
    public Decimal totalPrice{get;set;}
    public String orderId;
    public String ShippingAddresspPart1{get;set;}
    public String ShippingAddresspPart2{get;set;}
    public String ShippingAddresspPart3{get;set;}
    public String CustomerDetail{get;set;}
    public Datetime OrderDate{get;set;}
    public Date dt{get;set;}

    public SBProductInvoiceController() {
        orderId = 'a053t000010eaLxAAI';

        orderProductList = [Select id, Order__r.id,Order__r.name,
                            Product__r.id,
                            Product__r.Name,Product__r.Product_Name__c,
                            Product__r.Additional_Product_Information__c,
                            Product__r.Price__c from OrderProductJunction__c
                            where Order__r.id =: orderId];

        Order__c order = [Select Id,createdDate, Buyer__r.id from Order__c where id =: orderId];
        
        OrderDate = order.createdDate;
        dt = date.newinstance(OrderDate.year(), OrderDate.month(), OrderDate.day());
          
        totalPrice=0;
        for(OrderProductJunction__c opj:orderProductList){
            totalPrice+=opj.Product__r.Price__c;
        }
        
        buyer = [Select Id, First_Name__c, Last_Name__c, Contact_No__c, Email_Address__c, Shipping_Address__c,
                City__c, State__c, Postal_Code__c, Country__c 
                from Buyer__c where Id=: order.Buyer__r.id];

      
            ShippingAddresspPart1 = buyer.Shipping_Address__c;
            ShippingAddresspPart2 = buyer.City__c+' '+buyer.Postal_Code__c;
            ShippingAddresspPart3 = buyer.State__c+' '+buyer.Country__c;

            CustomerDetail = buyer.First_Name__c+' '+buyer.Last_Name__c;

        


    }
}