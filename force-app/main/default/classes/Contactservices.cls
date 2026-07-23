@RestResource(urlMapping='/createrecord/*')

Global class Contactservices {
    @HttpPost
    global static string createrecords(String firstName, String lastName, String email){
        
            Contact con = new Contact();
            con.FirstName = firstName;
            con.LastName = lastName; // Required field
            con.Email = email;
            insert con;
            return 'Contact created successfully with Id: ' + con.Id;

    }
    
    

}