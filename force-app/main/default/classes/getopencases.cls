public class getopencases {
    @AuraEnabled(cacheable=true)
    public static List<Case> opencases() {
        List<Case> listdata = [
            SELECT Id, CaseNumber, Subject, Status
            FROM Case
            WHERE Status != 'Closed'
        ];
        return listdata;
    }

    @AuraEnabled
    public static void updatecases(String caseId, String newStatus) {
        Case c = [SELECT Id FROM Case WHERE Id = :caseId];
        if (c != null) {
            c.Status = newStatus;
            update c;
        }
    }

}