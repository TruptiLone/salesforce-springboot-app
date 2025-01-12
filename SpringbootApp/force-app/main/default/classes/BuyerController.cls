public class BuyerController {
    public static void leadtoBuyer(List<Lead> leads) {

        List<Buyer__c> buyerList = new List<Buyer__c>();

        for (Lead lead: leads) {
            if (lead.Spring_Blossom_Customer__c == False) {
                continue;
            }
            
            Buyer__c buyer = new Buyer__c();
            buyer.First_Name__c = lead.FirstName;
            buyer.Last_Name__c = lead.LastName;
            buyer.Contact_No__c = lead.Phone;
            buyer.Email_Address__c = lead.Email;
            buyer.Shipping_Address__c = lead.Street;
            buyer.City__c = lead.City;
            buyer.State__c = lead.State;
            buyer.Postal_Code__c = lead.PostalCode;
            buyer.Country__c = lead.Country;
          	buyerList.add(buyer);
            
        }
        insert buyerList;
        
        //Create a cart Record
        
        System.debug('New Buyer Record Created');
        List<Cart__c> carList = new List<Cart__c>();
        for(Buyer__c buyer: buyerList){
            Cart__c cartRecord = new Cart__c();
         	 cartRecord.Buyer__c = buyer.id;
            carList.add(cartRecord);
        }
       insert carList;
        System.debug('Created Cart Record inseted in list');   
    
    //Create user
       
       Id profId = [SELECT Id FROM Profile WHERE Name = 'Buyer Profile' LIMIT 1].Id;
          System.debug('Profile Id:'+profId);
        
       List<User> userList = new List<User>();

        for (Buyer__c buyer: buyerList ) {
		User u = new User(
                  Alias = buyer.First_Name__c,
                 FirstName = buyer.First_Name__c,
                 LastName = buyer.Last_Name__c,
                 Email = buyer.Email_Address__c,
                 Username = buyer.Email_Address__c,
                 ProfileId = profId,
                 EmailEncodingKey = 'ISO-8859-1',
                 LanguageLocaleKey = 'en_US',
                 LocaleSidKey = 'en_US',
                 TimeZoneSidKey = 'America/New_York');
       
            
      		System.debug('UserName:'+u.Username);
       		System.debug('FirstName:'+u.FirstName);
       		System.debug('LastName:'+u.LastName);
       		System.debug('Email:'+u.Email);
			System.debug('Profile Id:'+u.ProfileId);

        	userList.add(u);
        }
       		
		insert userList;
       
        for (User u: userList ) {
			System.resetPassword(u.Id,True);
	       System.debug('Password Set for userId:'+u.Id);
        }
    }

}