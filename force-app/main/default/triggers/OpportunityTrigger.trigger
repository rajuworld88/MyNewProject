trigger OpportunityTrigger on Opportunity (before insert,before Update , after insert, after update,after delete,after undelete) {
   
      if(trigger.isafter && trigger.isupdate ){
        OpportunityHandlerclass.tracklargestopp(trigger.new,trigger.oldmap);
          
          OpportunityHandlerclass.createtakandassigntouser(trigger.new,trigger.oldmap);
    }
    
   
   
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
            OpportunityHandlerclass.sumofopportunity(Trigger.new);
            OpportunityHandlerclass.OpportunityminmaxAmount(Trigger.new);
        }
        if (Trigger.isDelete) {
            OpportunityHandlerclass.sumofopportunity(Trigger.old);
        }
    }
  
    
}