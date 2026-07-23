public class largestnumber {
    public static Integer getlarge (List<Integer> numbers){
        Integer largeone = numbers[0];
        for(Integer num : numbers){
            if( num > largeone){
                largeone = num ;
            }
            
            
        }
        return largeone;
    }

}