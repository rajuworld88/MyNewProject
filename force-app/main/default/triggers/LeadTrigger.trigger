trigger LeadTrigger on Lead (before insert,before update) {
    if((trigger.isinsert || trigger.isupdate)&& trigger.isbefore){
        LeadHandler.phonevalidationformat(trigger.new);
    }

}