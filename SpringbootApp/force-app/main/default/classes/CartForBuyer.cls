public class CartForBuyer {
    public static void createCartForBuyer(List<Buyer__c> newBuyer){  
        System.debug('New Buyer Record Created');
        List<Cart__c> carList = new List<Cart__c>();
        for(Buyer__c buyer: newBuyer){
            Cart__c cartRecord = new Cart__c();
         	 cartRecord.Buyer__c = buyer.id;
            carList.add(cartRecord);
        }
       insert carList;
        System.debug('Created Cart Record inseted in list');
    }	

}