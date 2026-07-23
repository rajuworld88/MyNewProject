public class ContactHandler {
    public static void onAfterUpdate(List<Contact> newContacts, Map<Id, Contact> oldMap)  {
        set<Id> accountIds = new set<Id> ();
        
          for (Contact newContact : newContacts) {
              if(oldmap.get(newContact.Id).Active__C != newContact.Active__c){
                  
                  accountIds.add(newContact.AccountId);
              }
              
        }
       
        List<Account> accountsWithContacts = [SELECT Id, (SELECT Id, Active__c FROM Contacts) FROM Account WHERE Id IN :accountIds];
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for (Account account : accountsWithContacts) {
            Boolean isAnyContactActive = false;
            
            for (Contact contact : account.Contacts) {
                if (contact.Active__c) {
                    isAnyContactActive = true;
                }
               
            }
            
           for (Contact contact : account.Contacts) {
                if (isAnyContactActive) {
                    if (contact.Active__c == true && !newContacts.contains(contact)) {
                        contactsToUpdate.add(new Contact(Id = contact.Id, Active__c = false));
                    }
                }
                else {
                    if (contact.Active__c == false && !newContacts.contains(contact)) {
                        contactsToUpdate.add(new Contact(Id = contact.Id, Active__c = true));
                    }
                } 
            } 
           }
        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
}
    
    
    // Enforce single Primary Contact on Account
  /*  public static void primarycontact (List<Contact> conlist,Map<Id,Contact> oldmap){
        set<Id> accids = new set<Id>();
        for(Contact con1 : conlist){
            if(oldmap.get(con1.Id).AccountId != con1.AccountId){
                accids.add(con1.AccountId);
            }
            else{
                accids.add(con1.AccountId);
            }
        }
        map<Id,Contact> mapids = new Map<Id,Contact>();
        List<Contact> conlistdata = [select id,Primary_Contact__C from Contact where AccountId in: accids and Primary_Contact__C == True];
        for(Contact c:conlistdata){
             mapids.put(c.AccountId,c);
        }
        
        for(Contact cc :conlist){
            if(cc.Primary_Contact__C){
                contact existingPrimary = mapids.get(cc.AccountId);
                  if (existingPrimary != null && existingPrimary.Id != cc.Id) {
                    existingPrimary.Primary_Contact__C = false;
                    update existingPrimary;
                }
                mapids.put(cc.AccountId, cc);
         
            }
        }
            
    } */
    //   Write an Apex trigger that updates the Last Modified Date field on the Account object
    //    whenever a related Contact is updated.
    
    public static void updaterelatedaccoutmodifydate (List<Contact> conlist2,map<Id,Contact> olddata){
        set<Id> accids = new set<Id>();
       // Map<Id,Contact> condataa = new map<Id,Contact>();
        for(Contact c : conlist2){
            if(c.AccountId != null && olddata.get(c.Id).LastModifiedDate != c.LastModifiedDate){
                accids.add(c.AccountId);
              //  condataa.put(c.AccountId,c);
            }
        }
        List<Account> accupdate = new List<Account>();
        List<Account> acclist =[select id from Account where Id In: accids];
        for(Account a : acclist){
           // Contact ccc = condataa.get(a.Id);
           // a.LastModifiedDate=ccc.LastModifiedDate;
            a.Description = 'Updated due to related contact change';  //+ccc.LastModifietedDa; 
          //a.Description=a.Description;
            
            accupdate.add(a);
            }
        if(!accupdate.isempty()){
            update accupdate;
        }
    }
    //  Write a trigger to prevent deletion of conatct before deleting Account.

    public static void prevention(List<Contact> conprevention){
        for(Contact cp : conprevention){
            if(cp.AccountId != null){
                cp.addError('you cant delete if the contact have a related account');
            }
        }
        
    }
    
    //  10.Write a trigger so that contact should not be inserted more than 2 to the related Account.
    
    public static void preventionmorethentwo (List<Contact> colist){
        
      set<Id> accids = new set<Id>();
        for(Contact con : colist)  {
          accids.add(con.AccountId);
        }
        
        List<Account> acclist = [select id,(select id,AccountId from Contacts where AccountId != null) from Account where Id IN:accids];
        
        for (Account a : acclist){
              Integer count =  a.Contacts.size();
            
            for(Contact c: a.Contacts){
                 
                    count++;
                 if (c.AccountId == a.Id) {
                if(count  > 2 ){
                    c.addError('You can\'t create more than two related contacts for this account.');
             
                }}}
        }     
        
        
    }
    
    
    public static void dublicationcontactsonAccounts(List<Contact> newContacts) {
    Set<Id> accIds = new Set<Id>();
    Set<String> emailIds = new Set<String>();

    // Collect Account IDs and Emails from the new Contacts
    for (Contact c : newContacts) {
        if (c.AccountId != null && c.Email != null) {
            accIds.add(c.AccountId);
            emailIds.add(c.Email);
        }
    }

    // Query for existing Contacts with the same Account IDs and Emails
    List<Contact> existingContacts = [
        SELECT Id, Email, AccountId 
        FROM Contact 
        WHERE AccountId IN :accIds 
        AND Email IN :emailIds
    ];

    // Create a set to track existing Email-AccountId combinations
    Set<String> existingEmailAccountCombinations = new Set<String>();
    for (Contact con : existingContacts) {
        String combo = con.Email + '|' + con.AccountId;
        existingEmailAccountCombinations.add(combo);
    }

    // Check for duplicates in the new Contacts
    for (Contact newCon : newContacts) {
        if (newCon.AccountId != null && newCon.Email != null) {
            String newCombo = newCon.Email + '|' + newCon.AccountId;
            if (existingEmailAccountCombinations.contains(newCombo)) {
                newCon.addError('A Contact with this Email and Account already exists.');
            }
        }
    }
}
    
    public static void DublicationemailonContacts(List<Contact> conlist){
        set<String> emailids = new set<String>();
        for(Contact c :conlist){
            emailids.add(c.Email);
        }
        List<Lead> leads =[select id,Email from Lead where Email IN : emailids];
        for(Lead ld :leads){
            if(ld.Email != null){
                emailids.add(ld.Email);
            }
        }
        
        for(Contact c :conlist){
            if(c.Email != null && emailids.contains(c.Email)){
                c.addError('You have already use this email on lead ');
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}