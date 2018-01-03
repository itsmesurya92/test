public class c2{
    
    List<Account> acts = [select Name, Type, Industry, Phone, Fax from Account];
    
    public List<Account> getacts(){
    return acts;
    }

}