public class MaintenanceRequestHelper {
    
	public List<Case> casesToRenew = new List<Case>();
	public List<Case> renewedCasesToInsert = new List<Case>();
	public Set<Id> casesToRenewIdSet = new Set<Id>();
	private Set<String> hwrTypes = new Set<String>{'Repair', 'Routine Maintenance'};

    public void updateWorkOrders(List<Case> newCaseList, Map<Id, Case> oldMap){
        // update workorders
        System.debug('>> newCaseList : ' + newCaseList);
		System.debug('>> oldMap : ' + oldMap);

		for(Case newCase : newCaseList){
			if(	isCorrectRequestType(newCase) && isClosedNow(newCase, oldMap.get(newCase.Id)) ){
				
				casesToRenew.add(newCase);
				casesToRenewIdSet.add(newCase.Id);

			}
		}
		System.debug('>> casesToRenew : ' + casesToRenew);
		System.debug('>> casesToRenewIdSet : ' + casesToRenewIdSet);

		if (!casesToRenew.isEmpty())
			renewRequest();
    }        
    
    public void renewRequest(){
        // update workorders

        List<trail296672__Work_Part__c> workParts = [Select Id, trail296672__Maintenance_Request__c, trail296672__Equipment__c, trail296672__Equipment__r.trail296672__Maintenance_Cycle__c 
    													FROM trail296672__Work_Part__c 
    														WHERE trail296672__Maintenance_Request__c IN: casesToRenewIdSet ORDER BY trail296672__Equipment__r.trail296672__Maintenance_Cycle__c];
    	
		System.debug('>> workParts : ' + workParts);
		System.debug('>> workParts size : ' + workParts.size());

		Map<Id, Integer> newMRCaseDewDateMap = new Map<Id, Integer>();

		for(trail296672__Work_Part__c workPart : workParts){

			System.debug('>> newMRCaseDewDateMap.get(workPart.trail296672__Maintenance_Request__c) : ' + newMRCaseDewDateMap.get(workPart.trail296672__Maintenance_Request__c));
			if(newMRCaseDewDateMap.get(workPart.trail296672__Maintenance_Request__c) == null)
				newMRCaseDewDateMap.put(workPart.trail296672__Maintenance_Request__c, Integer.valueOf(workPart.trail296672__Equipment__r.trail296672__Maintenance_Cycle__c));

			if((newMRCaseDewDateMap.get(workPart.trail296672__Maintenance_Request__c) != null) 
					&& (newMRCaseDewDateMap.get(workPart.trail296672__Maintenance_Request__c) > workPart.trail296672__Equipment__r.trail296672__Maintenance_Cycle__c)) 
				newMRCaseDewDateMap.put(workPart.trail296672__Maintenance_Request__c, Integer.valueOf(workPart.trail296672__Equipment__r.trail296672__Maintenance_Cycle__c));
			
		}
		System.debug('>> newMRCaseDewDateMap : ' + newMRCaseDewDateMap);

        for(Case newCase : casesToRenew){
        	Case newMRCase = createNewMaintenanceRequest(newCase);
        	Date dueDate;
        	if(newMRCaseDewDateMap.get(newMRCase.trail296672__Created_From__c) == null)
        		dueDate = Date.today().addDays(30);
        	else
        		dueDate = Date.today().addDays(newMRCaseDewDateMap.get(newMRCase.trail296672__Created_From__c));	
        	newMRCase.trail296672__Date_Due__c = dueDate;
        	renewedCasesToInsert.add(newMRCase);
    	}
    	System.debug('>> renewedCasesToInsert : ' + renewedCasesToInsert);
    	if (!renewedCasesToInsert.isEmpty())
    		Database.insert(renewedCasesToInsert, false);
    }

    public Case createNewMaintenanceRequest(Case caseTobeRenewed){

    	Case newMRCase = new Case();
    	newMRCase.Status = 'New';
    	newMRCase.trail296672__Created_From__c = caseTobeRenewed.Id;
    	newMRCase.Type = 'Routine Maintenance';
    	newMRCase.trail296672__Date_Reported__c = Date.today();
    	newMRCase.trail296672__Vehicle__c = caseTobeRenewed.trail296672__Vehicle__c;
    	newMRCase.trail296672__Equipment__c = caseTobeRenewed.trail296672__Equipment__c;
    	newMRCase.Subject = 'Routine Maintenance : ' + caseTobeRenewed.CaseNumber;

    	System.debug('>> newMRCase : ' + newMRCase);
    	return newMRCase;
    }

    private boolean isCorrectRequestType(Case newCase){
        return hwrTypes.contains(newCase.Type);
    }

    private boolean isClosedNow(Case newCase, Case oldCase){
        if((oldCase.Status != newCase.Status) && ('Closed' == newCase.Status))
        	return true;
        else
        	return false;	
    }
}