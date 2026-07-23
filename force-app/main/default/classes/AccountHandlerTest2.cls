@isTest
public class AccountHandlerTest2 {
@isTest 
    static void contactcountonaccount() {

        Account a = new Account();
        a.Name = 'raj';
        a.Type = 'Prospect';
        insert a;

        Contact con = new Contact();
        con.LastName = 'Test';
        con.AccountId = a.Id;
        
        insert con;
        
          Task t = new Task();

            t.Subject = 'Follow Up';
            t.Priority = 'High';
            t.Status = 'Not Started';
            t.WhatId = a.Id;

        insert t;

        Test.startTest();
        a.Type = 'Customer - Direct';
        a.Status2__c='Approved';
        update a;
        Test.stopTest();

        Account acc = [
            SELECT related_contats_on_account__c
            FROM Account
            WHERE Id = :a.Id
        ];
        
        List<Task> taskList = [
            SELECT Id,
                   Subject,
                   Priority,
                   WhatId
            FROM Task
            WHERE WhatId = :a.Id
        ];

        System.assertEquals(
            2,
            taskList.size()
        );

        System.assertEquals(
            'Follow Up',
            taskList[0].Subject
        );

        System.assertEquals(1, acc.related_contats_on_account__c);
    }
}