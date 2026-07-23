public class getaccountrecods {
    @AuraEnabled(cacheable = true)
    public static List<Account> displayaccrecords() {
        // Query Account records with required fields
        List<Account> acclist = [SELECT Id, Name, Phone, Active__c FROM Account];
        return acclist;
    }
}