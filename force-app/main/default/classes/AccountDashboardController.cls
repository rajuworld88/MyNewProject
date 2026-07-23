public with sharing class AccountDashboardController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(Id accountId) {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
        return [
            SELECT Id, Name, Email, Phone
            FROM Contact
            WHERE AccountId = :accountId
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(Id accountId) {
        return [
            SELECT Id, CaseNumber, Status
            FROM Case
            WHERE AccountId = :accountId
        ];
    }
}