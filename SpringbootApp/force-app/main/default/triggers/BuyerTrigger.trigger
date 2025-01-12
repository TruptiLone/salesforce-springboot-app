trigger BuyerTrigger on Buyer__c (after insert) {
    	System.debug('Trigger Invoked');
        CartForBuyer.createCartForBuyer(Trigger.New);
        System.debug('Trigger Completed');

}