public class cls_CurrencyConverter {
    @AuraEnabled
    public static String calloutCurrency() {
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.apilayer.net/api/live?access_key=01fb75f82151fe34b052b560aec8e245');
           // http://apilayer.net/api/live?access_key=01fb75f82151fe34b052b560aec8e245&currencies=EUR,GBP,CAD,PLN&source=USD&format=1
            req.setMethod('GET'); 
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        return res.getBody();
    }
}