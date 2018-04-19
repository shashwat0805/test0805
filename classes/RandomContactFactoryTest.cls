@isTest
public class RandomContactFactoryTest {
	
	@isTest
    public static void testing() {
    	List<Contact> conList = RandomContactFactory.generateRandomContacts(1, 'lname');
		//System.assertEquals(1, conList.size());
		//System.assertEquals('lname', conList[0].LastName);
	}
}