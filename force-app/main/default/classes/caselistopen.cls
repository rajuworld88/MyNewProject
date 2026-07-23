public with sharing class caselistopen {
 @AuraEnabled(Cacheable=True)

 public static List<Case> casedata (){
    List<Case> cs = [select id,CaseNumber,Origin,Status,Account.Name,
    (SELECT description FROM Tasks  ) from Case where Status != 'closed'
   
     ];
     return cs;

 }
}