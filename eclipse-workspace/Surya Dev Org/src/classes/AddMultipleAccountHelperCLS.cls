public class AddMultipleAccountHelperCLS {

    public static List<AddMultipleAccountCLS.WrapperpaAccountList> addNewRowToAccList(List<AddMultipleAccountCLS.WrapperpaAccountList> waAccObjList){
        AddMultipleAccountCLS.WrapperpaAccountList newRecord = new AddMultipleAccountCLS.WrapperpaAccountList();
        Contact newAccountRecord = new Contact();        
        //newRecord.record = newAccountRecord;
        newRecord.index = waAccObjList.size();
        waAccObjList.add(newRecord);
        return waAccObjList;
    }
    public static List<AddMultipleAccountCLS.WrapperOpportunityList> addNewRowToOppList(List<AddMultipleAccountCLS.WrapperOpportunityList> waOppObjList){
        AddMultipleAccountCLS.WrapperOpportunityList newRecord = new AddMultipleAccountCLS.WrapperOpportunityList();
        Opportunity newOpportunityRecord = new Opportunity();        
        //newRecord.record = newAccountRecord;
        newRecord.index = waOppObjList.size();
        waOppObjList.add(newRecord);
        return waOppObjList;
    }
    
    
     public static List<AddMultipleAccountCLS.WrapperpaAccountList> removeRowToAccountList(Integer rowToRemove, List<AddMultipleAccountCLS.WrapperpaAccountList> waAccountList){
        waAccountList.remove(rowToRemove);
        return waAccountList;
    }
    public static List<AddMultipleAccountCLS.WrapperOpportunityList> removeRowToOppList(Integer rowToRemove, List<AddMultipleAccountCLS.WrapperOpportunityList> waOppList){
        waOppList.remove(rowToRemove);
        return waOppList;
    }
    
    public static void save(List<AddMultipleAccountCLS.WrapperpaAccountList> waAccList) {
        system.debug('==waAccList==>'+waAccList.size());
        List<Contact> accountRecordsToBeInserted = new List<Contact>();
        if(waAccList !=null && !waAccList.isEmpty()){
            for(AddMultipleAccountCLS.WrapperpaAccountList eachRecord : waAccList ){
              //  contact accTemp = eachRecord.record;
               // accountRecordsToBeInserted.add(accTemp);
               
            }
            system.debug('==accountRecordsToBeInserted==>'+accountRecordsToBeInserted.size());
            insert accountRecordsToBeInserted;
        }
    }
    public static void save(List<AddMultipleAccountCLS.WrapperOpportunityList> waOppList) {
        system.debug('==waOppList==>'+waOppList.size());
        List<Opportunity> OppRecordsToBeInserted = new List<Opportunity>();
        if(waOppList !=null && !waOppList.isEmpty()){
            for(AddMultipleAccountCLS.WrapperOpportunityList eachRecord : waOppList ){
              //  contact accTemp = eachRecord.record;
               // accountRecordsToBeInserted.add(accTemp);
               
            }
            system.debug('==OppRecordsToBeInserted==>'+OppRecordsToBeInserted.size());
            insert OppRecordsToBeInserted;
        }
    }
}