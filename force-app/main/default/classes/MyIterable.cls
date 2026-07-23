public class MyIterable implements Iterable<String> {
    private List<String> strings;
        // constactor that initialize the call given list of string
        public MyIterable(List<String> strings){
            // assign the provided list to the private variable
            this.strings=strings;
            
        }
    // implements of the iterator
    public Iterator<String> Iterator(){
        return strings.Iterator(); 
    }
    
    

}