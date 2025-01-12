public with sharing class ProductSearchController {
   @AuraEnabled
   public static List<Product_Type__c> getProductType(){
    List<Product_Type__c> productTypeList = new List<Product_Type__c>();
    productTypeList = [Select Id, Name from Product_Type__c];
    for(Product_Type__c type:productTypeList){
        System.debug('This is ProductTypeId: '+type.Id);
        System.debug('This is ProductTypeName: '+type.Name);
    }
    return productTypeList;
       
   }

   @AuraEnabled
    public static List<Product__c> getProducts(String productTypeId){
        if(productTypeId != null){
            System.debug('This is ProductId: '+productTypeId);
        }
        
        List<Product__c> products = new List<Product__c>();
        if(String.isBlank(productTypeId) || productTypeId.equals('AllProducts')){
            System.debug('This is ProductId: '+productTypeId);
            products = [SELECT Id, Name,Product_Name__c,Price__c,Product_Image_1__c, Product_Image_2__c,Additional_Product_Information__c, 
                        Product_Type__c,Product_Type__r.Name, Stock__c FROM Product__c]; 
        }
        else{
            products = [SELECT Id, Name,Product_Name__c,Price__c,Product_Image_1__c, Product_Image_2__c,Additional_Product_Information__c, 
                    Product_Type__c,Product_Type__r.Name, Stock__c FROM Product__c WHERE Product_Type__c =: productTypeId];

            for(Product__c p:products){
            System.debug('This is KartId: '+p.Id);
            System.debug('This is KartId: '+p.Name);
            System.debug('This is KartId: '+p.Product_Name__c);
            System.debug('This is KartId: '+p.Product_Image_1__c);
            System.debug('This is KartId: '+p.Product_Type__c);

            }

            }        
            System.debug(products); 
            return products; 
        }

        @AuraEnabled
        public static Cart__c getCartRecord(){

            List<Buyer__c> buyerRec = [SELECT Id, Name, City__c, Contact_No__c, Country__c, 
                                        (Select id, name from Carts__r),
                                        Email_Address__c, First_Name__c,Last_Name__c,
                                        Postal_Code__c,Shipping_Address__c, 	
                                        State__c from Buyer__c 
                                        where Email_Address__c =: UserInfo.getUserEmail()];
            List<Cart__c> c = buyerRec[0].Carts__r;

            Cart__c cart =  c[0];
                System.debug('Buyer Record: '+buyerRec);
                System.debug('Buyers cart Record: '+c);
                System.debug('Buyers cart Id: '+cart.Id);
               return cart;                      
            
        }

        @AuraEnabled
        public static List<ProductCartJunction__c> getProductCartData(String cartId){
                List<ProductCartJunction__c> productList = [Select Id,  Product__c, Cart__c, Product__r.Product_Name__c,Product__r.Name,Product__r.Price__c,Product__r.Product_Image_1__c, Product__r.Product_Image_2__c,Product__r.Additional_Product_Information__c, 
                        Product__r.Stock__c  from ProductCartJunction__c where Cart__c =: cartId];
                        return productList;

            
        }
        @AuraEnabled
        public static void deleteProductCartData(String pid){
                List<ProductCartJunction__c> productList = [Select Id, Product__c, Cart__c, Product__r.Product_Name__c,Product__r.Name,Product__r.Price__c,Product__r.Product_Image_1__c, Product__r.Product_Image_2__c,Product__r.Additional_Product_Information__c, 
                        Product__r.Stock__c  from ProductCartJunction__c where Id =: pid];
                        delete productList;

            
        }
        


        @AuraEnabled
        public static String createOrder(){
            List<Buyer__c> buyerRec = [SELECT Id, Name, City__c, Contact_No__c, Country__c, 
            (Select id, name from Carts__r),
            Email_Address__c, First_Name__c,Last_Name__c,
            Postal_Code__c,Shipping_Address__c, 	
            State__c from Buyer__c 
            where Email_Address__c =: UserInfo.getUserEmail()];

            List<Cart__c> c = buyerRec[0].Carts__r;

            Cart__c cart =  c[0];

            String buyerId = buyerRec[0].Id;
            Date orderDate = System.today();
            String status= 'Order Placed';

            Order__c order = new Order__c();
            order.Buyer__c = buyerId;
            order.Date_of_Order_Placed__c = orderDate;
            order.Order_Status__c = status;

            insert order;

            String orderId = order.Id;

            List<ProductCartJunction__c> productList = getProductCartData(cart.Id);
            List<OrderProductJunction__c> opj = new List<OrderProductJunction__c>();
            //List<String> prodIdList= new List<String>();
           // system.debug('Product List in order: '+prodIdList);



            for(ProductCartJunction__c product : productList) {
                OrderProductJunction__c junctionRecord = new OrderProductJunction__c();
                junctionRecord.Order__c = orderId;
                junctionRecord.Product__c = product.Product__c;
                system.debug('junctionRecord.Product__c: '+junctionRecord.Product__c );
            
                //prodIdList.add(junctionRecord.Product__c);
                
                
                opj.add(junctionRecord);
                
            }

            insert opj;
            delete productList;
            return orderId;
        }

        @AuraEnabled
        public static List<Order__c> orderList(){
            List<Buyer__c> buyerRec = [SELECT Id, Name from Buyer__c 
            where Email_Address__c =: UserInfo.getUserEmail()];
 
            String buyerId = buyerRec[0].Id;
            System.debug('Buyer Id: '+buyerId);

            List<Order__c> orderList = new List<Order__c>();
            orderList = [Select Buyer__c,Date_of_Order_Placed__c,Name,Order_Status__c
                        from Order__c where Buyer__c=:buyerId ORDER BY Name DESC LIMIT 10];
                        System.debug('Order List : '+orderList);
                return orderList;

            
        }
        @AuraEnabled
        public static List<OrderProductJunction__c> OrderProductDetail(String OrderId){
            List<OrderProductJunction__c> orderProductDetail = [Select Name, Order__c,Order__r.Order_Status__c,
                                                                Order__r.Date_of_Order_Placed__c, Order__r.Name,
                                                                Product__c,
                                                                Product__r.Additional_Product_Information__c,
                                                                Product__r.Price__c,
                                                                Product__r.Product_Image_1__c,
                                                                Product__r.Product_Image_2__c,
                                                                Product__r.Product_Name__c,
                                                                Product__r.Product_Type__c,
                                                                Product__r.Seller__c,
                                                                Product__r.Stock__c from OrderProductJunction__c where Order__c =:OrderId];
                return orderProductDetail;
        }
        @AuraEnabled
        public static String processPaymentAndCreateOrder(String cardNumber){
            String payment;
            if(cardNumber.isNumeric()){
                payment = 'PAYMENT_SUCCESS';
                system.debug('Valid');
            }else{
                payment = 'PAYMENT_FAILED';
                system.debug('In - Valid');
                return payment;
            }
    
            return createOrder();
        }

        @AuraEnabled
        public static String calloutCurrency() {
            
            HttpRequest req = new HttpRequest();
            //req.setEndpoint('http://www.apilayer.net/api/live?access_key=01fb75f82151fe34b052b560aec8e245');
            req.setEndpoint('http://www.apilayer.net/api/live?access_key=01fb75f82151fe34b052b560aec8e245&currencies=EUR,CAD&source=USD&format=1');
            
               // http://apilayer.net/api/live?access_key=01fb75f82151fe34b052b560aec8e245&currencies=EUR,GBP,CAD,PLN&source=USD&format=1
                req.setMethod('GET'); 
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());
            return res.getBody();
        }
}