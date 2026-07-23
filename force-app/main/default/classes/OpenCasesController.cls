public with sharing class OpenCasesController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getOpenCases(Id accountId) {

        if(accountId == null){
            return new List<Case>();
        }

        return [
            SELECT Id,
                   CaseNumber,
                   Subject,
                   Status,
                   Priority,
                   Origin,
                   Owner.Name,
                   CreatedDate
            FROM Case
            WHERE AccountId = :accountId
            AND Status != 'Closed'
            ORDER BY CreatedDate DESC
        ];
    }
}