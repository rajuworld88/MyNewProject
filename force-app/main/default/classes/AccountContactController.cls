public with sharing class AccountContactController {
       @AuraEnabled
   Public static List<Contact> getContacts(Id accountId){
    List<Contact> contacts = [select Id, Name, Email, Phone from Contact where AccountId = :accountId];
    return contacts;
   }
}