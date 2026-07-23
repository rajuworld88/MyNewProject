public class LeadHandler {
    public static void phonevalidationformat (List<Lead> leadlist){
        string phonevalidation = '^[0-9]{10}$';
        for(Lead ld : leadlist)
            if(ld.Phone!= null && !Pattern.matches(phonevalidation ,ld.Phone)){
                ld.addError(' iam nune rajkumar you have to check  the phone number format');
            }
        }
    }