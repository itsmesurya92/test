public with sharing class AddMultipleAccountCLS {

public AddMultipleAccountCLS(ApexPages.StandardController stdController){
 waAccList = new List<WrapperpaAccountList>();
 waOppList = new List<WrapperOpportunityList>();
  //addNewRowToAccList();

}
    public PageReference SaveMultipleAccounts() {
    system.debug('controller save method is calling-->');
     AddMultipleAccountHelperCLS.save(waAccList);
    return null;
    }
    
    public PageReference SaveMultipleOpps() {
    system.debug('controller save method is calling-->');
    // AddMultipleAccountHelperCLS.save(waOppList);
    return null;
    }


 public List<WrapperpaAccountList> waAccList {get;set;}
 public List<WrapperOpportunityList> waOppList {get;set;}
 public Integer rowToRemove {get;set;}

 public AddMultipleAccountCLS(){
 
 }
 public void removeRowFromAccList(){
  waAccList = AddMultipleAccountHelperCLS.removeRowToAccountList(rowToRemove, waAccList);
   
 }
 
  public void removeRowFromOppList(){
  waOppList = AddMultipleAccountHelperCLS.removeRowToOppList(rowToRemove, waOppList);
   
 }


 public void addNewRowToAccList(){
     waAccList = AddMultipleAccountHelperCLS.addNewRowToAccList(waAccList);
    }
    
    public void addNewRowToOppList(){
     waOppList = AddMultipleAccountHelperCLS.addNewRowToOppList(waOppList);
    }
   

 public class WrapperpaAccountList{
        public Integer index {get;set;}
        public Account record {get;set;}
   } 
  public class WrapperOpportunityList{
        public Integer index {get;set;}
        public Account record {get;set;}
   }   
}