trigger ApplicationFormTrigger on Application_Form__c (after update) {
    
    
        System.debug('Trigger Invoked');
        LeadAutoConvert.leadConvertBasedOnVerification(Trigger.OldMap, Trigger.NewMap);
        System.debug('Trigger Completed');
        
    


}