public with sharing class PaymentController {
    @AuraEnabled
    public static String validateCardNumber(String cardNumber){
        String payment;

        if(cardNumber.isNumeric()){
            payment = 'PAYMENT_SUCCESS';
            system.debug('Valid');
        }else{
            payment = 'PAYMENT_FAILED';
            system.debug('In - Valid');
        }

        return payment;
    }
}