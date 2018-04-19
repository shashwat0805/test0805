@Istest(SeeAllData=true)
public class AccountManagerTest {
    
	@IsTest
    public static void testaccountmanager() {
        RestRequest request = new RestRequest();
        request.requestUri = 'https://playful-raccoon-296672-dev-ed.my.salesforce.com/services/apexrest/Accounts/0010Y00000bOawOQAS/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
		system.debug('test account result = '+ AccountManager.getAccount());


        
    }
    

}