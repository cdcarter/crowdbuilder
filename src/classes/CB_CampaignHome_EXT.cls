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

    public List<Opportunity> getOpportunitiesInHierarchy() {
      List<Opportunity> opps = new List<Opportunity>();
      opps.addAll( [SELECT Id,Amount,Account.Name,Description FROM Opportunity
              WHERE IsWon = true
              AND CampaignId IN (SELECT Id FROM Campaign WHERE ParentId =: cbCampaign.Id)]);
      opps.addAll( [SELECT Id,Amount,Account.Name,Description FROM Opportunity
                    WHERE IsWon = true
                    AND CampaignId =: cbCampaign.Id]);
      return opps;
    }

}