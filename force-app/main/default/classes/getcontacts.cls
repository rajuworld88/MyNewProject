public with sharing class getcontacts {
  @AuraEnabled(cacheable=true)
    public static List<Contact> getAllContacts() {
        return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact];
    }
}