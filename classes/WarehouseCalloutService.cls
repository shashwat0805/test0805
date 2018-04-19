public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.

    @future (callout=true)
	public static void runWarehouseEquipmentSync() {

	    HttpRequest req = new HttpRequest();
	    HttpResponse res = new HttpResponse();
	    Http http = new Http();
	    //req.setHeader('Accept', 'application/x-www-form-urlencoded');
	    req.setEndpoint(WAREHOUSE_URL);
	    req.setMethod('GET');
	    
	    try {
	        res = http.send(req);
	        System.debug('>> res.getBody() : ' + res.getBody());
	        System.debug('>> res.toString() : ' + res.toString());
	        // Parse JSON response to get all the totalPrice field values.
	        JSONParser parser = JSON.createParser(res.getBody());
	        while (parser.nextToken() != null) {
	            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
	                // Get the value.
	                //parser.nextToken();
	                System.debug('>> token : ' + parser.getText());
	                // Compute the grand total price for all invoices.
	            }
	        }
	    } catch(System.CalloutException e) {
	        System.debug('Callout error: '+ e);
	        System.debug(res.toString());
	    }

	}

}