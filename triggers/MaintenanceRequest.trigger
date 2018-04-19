trigger MaintenanceRequest on Case (after update) {
    // call MaintenanceRequestHelper.updateWorkOrders  
    MaintenanceRequestHelper helperObject = new MaintenanceRequestHelper();
	helperObject.updateWorkOrders(Trigger.new, Trigger.oldMap);
}