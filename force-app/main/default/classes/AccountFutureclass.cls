public class AccountFutureclass {
    @future
    Public static void createFollowupTasks(List<Id> accountIds){
      List<Task> taskList = new List<Task>();
         for(Id accId : accountIds){

            Task t = new Task();

            t.Subject = 'Follow Up';
            t.Priority = 'High';
            t.Status = 'Not Started';
            t.WhatId = accId;

            taskList.add(t);
        }

        if(!taskList.isEmpty()){

            insert taskList;
        }
    }
        
    }