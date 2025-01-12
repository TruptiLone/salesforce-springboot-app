public without sharing class LeadAutoConvert {
   

    public static Database.LeadConvertResult LeadAssign(List<Id> LeadIds)
    {
            Database.LeadConvert Leadconvert = new Database.LeadConvert();
            Leadconvert.setLeadId(LeadIds[0]);
            LeadStatus Leads= [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            Leadconvert.setConvertedStatus(Leads.MasterLabel);
            Leadconvert.setDoNotCreateOpportunity(TRUE); //Remove this line if you want to   create an opportunity from Lead Conversion 
            System.debug('Lead Conversion Started');
            Database.LeadConvertResult Leadconverts = Database.convertLead(Leadconvert);
            System.debug('Lead Conversion Completed');
            System.assert(Leadconverts.isSuccess());
            return Leadconverts;
            

   }
   public static void createSeller(Database.LeadConvertResult Leadconverts) {
    System.debug('Creating Seller Record');

    Seller__c sellerRec = new Seller__c();
    System.debug('Acc id'+Leadconverts.getAccountId());
    System.debug('Con Id'+Leadconverts.getContactId());
    List<Contact> contactList = [Select Id, Email,FirstName,LastName  from Contact Where Id = :Leadconverts.getContactId()];
    sellerRec.User_Name__c = contactList[0].Email;
    sellerRec.Account__c = Leadconverts.getAccountId();
    sellerRec.Contact__c = Leadconverts.getContactId();
    insert sellerRec;
    System.debug('Seller inserted');
       
       
       //Create User
      
       Id profId = [SELECT Id FROM Profile WHERE Name = 'Seller Profile' LIMIT 1].Id;
          System.debug('Profile Id:'+profId);
		User u = new User(
                  Alias = contactList[0].FirstName,
                 FirstName = contactList[0].FirstName,
                 LastName = contactList[0].LastName,
                 Email = contactList[0].Email,
                 Username = contactList[0].Email,
                 ProfileId = profId,
                 EmailEncodingKey = 'ISO-8859-1',
                 LanguageLocaleKey = 'en_US',
                 LocaleSidKey = 'en_US',
                 TimeZoneSidKey = 'America/New_York');
       
         	System.debug('UserName:'+u.Username);
       		
			insert u;
       		System.debug('UserId:'+u.Id);
      		System.debug('UserName:'+u.Username);
       		System.debug('UserName:'+u.FirstName);
       		System.debug('UserName:'+u.LastName);
       		System.debug('UserName:'+u.Email);
       
         	System.debug('Profile Id:'+u.ProfileId);
       
			//System.setPassword(u.Id, 'Welcome123');
			System.resetPassword(u.Id,True);
       System.debug('Password Set for userId:'+u.Id);
       

   }

    public static void leadConvertBasedOnVerification(Map<Id,Application_Form__c> oldAppFormMap,Map<Id,Application_Form__c> newAppFormMap){
        for(Id appformId : newAppFormMap.keySet()){
            if(oldAppFormMap.get(appformId).Verified__c != newAppFormMap.get(appformId).Verified__c){
                System.debug('Checking for verified status');
                System.debug('Lead of Application Form: '+oldAppFormMap.get(appformId).Lead_Id__c);

                Id LeadId = oldAppFormMap.get(appformId).Lead_Id__c;
                List<Id> LeadIdForm = new List<Id>();
                LeadIdForm.add(LeadId);
                Database.LeadConvertResult Leadconverts = LeadAssign(LeadIdForm);
                createSeller(Leadconverts);
                
            }
        }

    }
}