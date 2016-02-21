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

        Opportunity childDonation = new Opportunity(Name='ack',StageName='Closed Won',Amount=100,CloseDate=Date.today(),AccountId=c.AccountId,CampaignId=child.Id );
        Opportunity masterDonation = new Opportunity(Name='ack',StageName='Closed Won',Amount=100,CloseDate=Date.today(),AccountId=c.AccountId,CampaignId=master.Id );
        insert new List<Opportunity>{childDonation,masterDonation};
    }
    @isTest public static void test_getUpdates() {
        Campaign child = [Select Id From Campaign WHERE Name =: 'Child'][0];
        PageReference pageRef = Page.CB_CampaignHome;
        pageRef.getParameters().put('id',child.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con = new ApexPages.StandardController(child);
    	  CB_CampaignHome_EXT ext = new CB_CampaignHome_EXT(con);

        Test.startTest();
        List<Campaign_Update__c> updates = ext.getThreeCampaignUpdates();
        List<Campaign_Update__c> allUpdates = ext.getCampaignUpdates();
        Test.stopTest();

        System.assertEquals(3,updates.size());
        System.assertEquals(5,allUpdates.size());
    }

    @isTest public static void test_getAllOpps() {
      Campaign master = [Select Id From Campaign WHERE Name =: 'Master'][0];
      PageReference pageRef = Page.CB_Home;
      pageRef.getParameters().put('id',master.Id);
      Test.setCurrentPage(pageRef);
      ApexPages.StandardController con = new ApexPages.StandardController(master);
      CB_CampaignHome_EXT ext = new CB_CampaignHome_EXT(con);

      Test.startTest();
      List<Opportunity> allopps = ext.getOpportunitiesInHierarchy();
      Test.stopTest();

      System.assertEquals(2,allopps.size());

    }
}