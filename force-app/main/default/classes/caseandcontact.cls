public with sharing class caseandcontact {
    @AuraEnabled
   
    public static Id createcaseandcontact(String firstName, String lastName, String email, String subject, String description){

        Contact con = new Contact();
        con.FirstName=firstName;
        con.LastName=lastName;
        con.Email=email;
        insert con;

        Case cs = new Case();
        cs.ContactId=con.Id;
        cs.Subject=subject;
        cs.Description=description;
        insert cs;
        
        
        return cs.Id;
    }
   

}