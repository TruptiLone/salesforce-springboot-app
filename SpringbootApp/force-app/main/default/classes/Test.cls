public class Test {
    
    public void test() {
        boolean result = false;
        String o = 'onions';
        String l = 'lettuce';
        String ca = 'carrots';
        String cu = 'cucumbers';
        String t = 'cucumbers';
     //onions,carrots,lettuce,cucumbers, tomatoes
     // Create a list
     List<String> onionsCompanionList = new List<String>{ca,t,l};
     List<String> lettuceCompanionList = new List<String>{o,ca};
     List<String> tomatoesCompanionList = new List<String>{o};
     List<String> cucumbersCompanionList = new List<String>{l};
     List<String> carrotCompanionList = new List<String>{l};
     System.debug('Value of List'+ onionsCompanionList);

     Map<String, List<String>> companionMap = new Map<String, List<String>>();
    companionMap.put(o,onionsCompanionList);
    companionMap.put(l,lettuceCompanionList);
    companionMap.put(t,tomatoesCompanionList);
    companionMap.put(ca,carrotCompanionList);
    companionMap.put(cu,cucumbersCompanionList);
        
 //to see the map
System.debug('The current map ='+companionMap);
for (String key: companionMap.keyset()){
    system.debug('The Current Key ='+key);
    
         system.debug('The Current value ='+ companionMap.get(key));
    }

     
     

    }

}