public class CurrencyCallouts {
    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.apilayer.net/api/live?access_key=01fb75f82151fe34b052b560aec8e245');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
         	System.debug(results.get('success'));
     		Map<String, Object> currencyValues = (Map<String, Object>)results.get('quotes');
            
    		Decimal usdcadValue = (Decimal)currencyValues.get('USDCAD');
            Decimal usdeurValue = (Decimal)currencyValues.get('USDEUR');
            System.debug('usdcadValue '+usdcadValue);
            System.debug('usdeurValue '+usdeurValue);
            System.debug('size: '+currencyValues.size());
            
        }
        return response;
    }

}