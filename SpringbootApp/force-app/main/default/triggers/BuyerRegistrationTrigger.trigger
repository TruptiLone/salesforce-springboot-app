trigger BuyerRegistrationTrigger on Lead (after insert) {
    
    		BuyerController.leadtoBuyer(Trigger.New);
 }