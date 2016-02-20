public class CB_CampaignHome_EXT {
    public Campaign cbCampaign {get;set;}
    public CB_CampaignHome_EXT(ApexPages.StandardController controller){
        this.cbCampaign = (Campaign)controller.getRecord();
    }
    
    public List<Campaign_Update__c> getThreeCampaignUpdates() {
        return [SELECT Id,Title__c,Body__c 
                FROM Campaign_Update__c
                WHERE Campaign__c =: cbCampaign.Id
                AND Status__c = 'Published'
                ORDER BY Date__c DESC
                LIMIT 3];
    }
    public List<Campaign_Update__c> getCampaignUpdates() {
        return [SELECT Id,Title__c,Body__c 
                FROM Campaign_Update__c
                WHERE Campaign__c =: cbCampaign.Id
                AND Status__c = 'Published'
                ORDER BY Date__c DESC];
    }

}