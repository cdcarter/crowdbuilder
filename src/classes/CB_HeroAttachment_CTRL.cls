public class CB_HeroAttachment_CTRL {
    public Campaign cbCampaign {get;set;}
    
    public CB_HeroAttachment_CTRL(ApexPages.StandardController sc) {
        this.cbCampaign = (Campaign)sc.getRecord();
    }
    
    public String getFileId() {
        String fileId = '';
        List<Attachment> attachedFiles = [SELECT Id 
                                          FROM Attachment 
                                          WHERE Id =: cbCampaign.Hero_Attachment_Id__c];
        
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
        }
        return fileId;    
    }
}