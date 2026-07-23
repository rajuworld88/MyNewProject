public class IntegerDublicationfinding {
    Public static void dublication(List<Integer> numlist){
        set<Integer> doubleseeing = new set<Integer>();
        set<Integer> dublication = new set<Integer>();
        for(Integer num :numlist){
            if(doubleseeing.contains(num)){
                dublication.add(num);
            }
            doubleseeing.add(num);
        }
        
         if (!dublication.isEmpty()) {
            System.debug('Duplicate integers: ' + dublication);
        } else {
            System.debug('No duplicates found.');
        }
    }

}