public with sharing class opportunitesonaccount {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        System.debug('AccountId received: ' + accountId);
        return [SELECT Id, Name, StageName, Amount FROM Opportunity WHERE AccountId = :accountId];
    }

    @AuraEnabled
    public static void updateOpportunityStage(List<Opportunity> opportunities) {
        update opportunities;
    }
}