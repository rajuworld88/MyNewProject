public with sharing class practiceapexflow {
    @AuraEnabled(cacheable=true)
    public static List<Account> getaccounts(){
        return [select id,Name from Account Limit10];
    }
}