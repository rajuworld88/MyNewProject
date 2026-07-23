@RestResource(urlMapping='/createLead/')
global class practicintegrationchat {
    
     @HttpPost
    global static String createLead(String firstName, String lastName, String company) {
        Lead newLead = new Lead(FirstName = firstName, LastName = lastName, Company = company);
        insert newLead;
        return 'Lead Created with Id: ' + newLead.Id;
    }
    

}