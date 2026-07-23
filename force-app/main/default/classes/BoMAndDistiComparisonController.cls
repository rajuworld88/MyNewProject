public class BoMAndDistiComparisonController {
   public List<Unified_List__c> unifiedListRecords { get; set; }
    public List<BoM__c> bomList { get; set; }
    public List<Disti__c> distiList { get; set; }

    public BoMAndDistiComparisonController(ApexPages.StandardController controller) {
    
        bomList = [SELECT Part_Number__c, Quantity__c FROM BoM__c];
        distiList = [SELECT Part_Number__c, Quantity__c FROM Disti__c];
    }

    public PageReference compareAndFetchRecords() {

        unifiedListRecords = [SELECT BoM_Part_Number__c, BoM_Quantity__c, Disti_Part_Number__c, Disti_Quantity__c, Error_Flag__c FROM Unified_List__c ORDER BY CreatedDate DESC LIMIT 100];

        return null;
    }

}