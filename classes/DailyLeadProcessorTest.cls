@isTest
public class DailyLeadProcessorTest {
    
    @isTest
    public static void testing() {
        
        List<lead> l_lst = new List<lead>();
        for(Integer i=0;i<200;i++) {
            lead l = new lead();
            l.lastname = 'lastname'+i;
            l.Company = 'company'+i;
            l_lst.add(l);
        }
        insert l_lst;
        
        Test.startTest();
        DailyLeadProcessor dlp = new DailyLeadProcessor ();
        /*
        String jobId = System.Schedule('dailyleadprocessing','0 01 19 14 11 ? 2017',dlp);
        Test.stopTest();
        
        List<lead> l_lst_chk = new List<lead>([select id,leadsource from lead where leadsource != 'Dreamforce']);
        System.assertequals(0,l_lst_chk.size());
        */

        // This test runs a scheduled job at midnight Sept. 3rd. 2022
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        // Schedule the test job
         String jobId = System.schedule('dailyleadprocessing', CRON_EXP, dlp);
        // Get the information from the CronTrigger API object 
         CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId]; 
         // Verify the expressions are the same System.assertEquals(CRON_EXP, ct.CronExpression); 
        // Verify the job has not run 
        System.assertEquals(0, ct.TimesTriggered); 
        // Verify the next time the job will run 
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));   
        Test.stopTest(); 

    }

}