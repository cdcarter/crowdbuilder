@isTest
public class CB_CampaignHome_TEST {
    @testSetup public static void setup_campaign() {
        Campaign master = new Campaign(Name='Master',ExpectedRevenue=2000,IsActive=true);
        insert master;
        Contact c = new Contact(Firstname='Andy',Lastname='Akimbo');
        insert c;
        Campaign child = new Campaign(Name='Child',ExpectedRevenue=200,isActive=true,ParentId = master.Id, Captain__c=c.Id);
        insert child;
        List<Campaign_Update__c> updates = new List<Campaign_Update__c>();
        for(Integer i=0;i<5;i++) {
            Campaign_Update__c up = new Campaign_Update__c(Campaign__c=child.Id,Title__c=String.valueOf(i),Status__c='Published');
        	updates.add(up);
        }
        insert updates;
    }
    @isTest public static void test_getUpdates() {
        Campaign child = [Select Id From Campaign WHERE Name =: 'Child'][0];
        PageReference pageRef = Page.CB_CampaignHome;
        pageRef.getParameters().put('id',child.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con = new ApexPages.StandardController(child);
    	CB_CampaignHome_EXT ext = new CB_CampaignHome_EXT(con);
        
        Test.startTest();
        List<Campaign_Update__c> updates = ext.getCampaignUpdates();
        Test.stopTest();
        
        System.assertEquals(3,updates.size());
    }
}