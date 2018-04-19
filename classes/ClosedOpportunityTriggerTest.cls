@isTest(seeAllData=true)
public class ClosedOpportunityTriggerTest {
	@isTest
    public static void testing() {
        Opportunity opp = [Select Id, Name FROM Opportunity WHERE StageName = 'Closed Won' LIMIT 1];
		update opp;
    }
}