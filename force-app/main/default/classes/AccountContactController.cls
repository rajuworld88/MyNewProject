public with sharing class AccountContactController {


     @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name, Phone, Industry
            FROM Account
            ORDER BY Name
            LIMIT 5
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
        return [
            SELECT Id, FirstName, LastName, Email, Phone
            FROM Contact
            WHERE AccountId = :accountId
            ORDER BY LastName
        ];
    }
    
}