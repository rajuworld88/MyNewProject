trigger ContactTrigger on Contact (after insert,after Update,before insert,before update,before delete) {
    
    if (Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)) {
      //  ContactHandler.updaterelatedaccoutmodifydate(Trigger.new, Trigger.oldMap);
    }
    
    if(Trigger.isbefore && Trigger.isdelete){
        ContactHandler.prevention(trigger.new);
    }
    
    if(Trigger.isbefore && Trigger.isinsert){
       // ContactHandler.preventionmorethentwo(trigger.new);
    }
    
    if (Trigger.isBefore && Trigger.isInsert) {
        // Call the method to check for duplicates
        ContactHandler.dublicationcontactsonAccounts(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isInsert){
        ContactHandler.DublicationemailonContacts(trigger.new);
    }
    
    
    
   // if(trigger.isafter && (trigger.isupdate || trigger.isinsert)){
       //ContactHandler.onAfterUpdate(trigger.new,trigger.oldmap);
        // ContactHandler.updaterelatedaccoutmodifydate(trigger.new,trigger.oldmap);
    }
    
   

        // else if (Trigger.isUpdate) {
       //  ContactHandler.updaterelatedaccoutmodifydate(trigger.new,trigger.oldmap);
        //}