@RestResource(urlMapping ='/createcase')

global  class integrationpracticeaccget {
     @HttpPost
    global static String createcase(String Subject, String Descriptin , String Prioryty ){
        Case cs = new Case();
        cs.Subject= Subject;
        cs.Description= Descriptin;
        cs.Priority = Prioryty;
        
        insert cs;
        return 'Case Created with ID: ' + cs.Id;
    }
    
}