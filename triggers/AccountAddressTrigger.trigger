trigger AccountAddressTrigger on Account(before insert, before update) {
    
    // Iterate through each account.
    for(Account a : Trigger.New) {
        System.debug(' >> Account : ' + a);
        // Check if the account already has a related opportunity.
        if(a.Match_Billing_Address__c==true && a.BillingPostalCode!=null){
            System.debug(' >> Account Match_Billing_Address__c : ' + a.Match_Billing_Address__c);
            System.debug(' >> Account BillingPostalCode : ' + a.BillingPostalCode);
            a.ShippingPostalCode=a.BillingPostalCode;
        }          
    }
}