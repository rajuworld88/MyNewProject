public class bOMComparison {
    
    public static void compareBoMAndDisti() {
        
        List<BoM__c> bomList = [SELECT Part_Number__c, Quantity__c FROM BoM__c];
        List<Disti__c> distiList = [SELECT Part_Number__c, Quantity__c FROM Disti__c];


        Map<String, BoM__c> bomMap = new Map<String, BoM__c>();
        Set<String> distiPartNumbers = new Set<String>();
        for (BoM__c bom : bomList) {
            bomMap.put(bom.Part_Number__c, bom);
        }

     
        List<Unified_List__c> unifiedList = new List<Unified_List__c>();
        for (Disti__c disti : distiList) {
            distiPartNumbers.add(disti.Part_Number__c); 
            Unified_List__c unifiedRecord = new Unified_List__c();
            unifiedRecord.BoM_Part_Number__c = disti.Part_Number__c;
            unifiedRecord.Disti_Part_Number__c = disti.Part_Number__c;
            unifiedRecord.Disti_Quantity__c = disti.Quantity__c;

           
            if (bomMap.containsKey(disti.Part_Number__c)) {
                BoM__c bomRecord = bomMap.get(disti.Part_Number__c);
                unifiedRecord.BoM_Quantity__c = bomRecord.Quantity__c;
                if (bomRecord.Quantity__c != disti.Quantity__c) {
                    unifiedRecord.Error_Flag__c = true;
                }
            } else {
                unifiedRecord.Error_Flag__c = true;
            }

            unifiedList.add(unifiedRecord);
        }

        // 4. Handle Parts Missing in Disti
        for (BoM__c bom : bomList) {
            if (!distiPartNumbers.contains(bom.Part_Number__c)) {  
                Unified_List__c unifiedRecord = new Unified_List__c();
                unifiedRecord.BoM_Part_Number__c = bom.Part_Number__c;
                unifiedRecord.BoM_Quantity__c = bom.Quantity__c;
                unifiedRecord.Error_Flag__c = true;
                unifiedList.add(unifiedRecord);
            }
        }

        
        insert unifiedList;
    }

}