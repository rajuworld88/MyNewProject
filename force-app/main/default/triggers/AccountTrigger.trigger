trigger AccountTrigger on Account (after insert,after update,before update,before insert,before delete) {
    if(trigger.isafter && trigger.isinsert){
        //AccountHandlerclass.contactcreationbasedonLocations(trigger.new);
        
    
    }
    if(trigger.isbefore && trigger.isupdate){
       // AccountHandlerclass.adderror(trigger.new);
    }
    
  if(trigger.isbefore && trigger.isinsert){
     //   AccountHandlerclass.preventdublication(trigger.new);
    }
    
      if(trigger.isAfter && trigger.isupdate){
       AccountHandler.contactscountonacc(trigger.new,trigger.oldmap);
          AccountHandler.processApprovedAccounts(trigger.new,trigger.oldmap);
    }

     if(trigger.isbefore && trigger.isdelete){
        AccountHandler.preventionofaccdeletion(trigger.old);
    }
      if(trigger.isAfter && trigger.isupdate){
        AccountHandler.updatephoneallcontacts(trigger.new,trigger.oldmap);
    }
    

}