public class accountsWithContactsClass {
    
    public String fNameStr{get;set;}
    public String lNameStr{get;set;}
    
    /*@auraEnabled
    public void getSearchContacts(){
        String qryStr = 'select Id, FirstName,LastName,Email,Account.Name from Contact where ';
        Boolean isFirst = true;
        if(String.isNotBlank(fNameStr)){
            qryStr += 'FirstName =:fNameStr ';
            isFirst = false;
        }
        if(String.isNotBlank(lNameStr)){
            if(!isFirst) 
                qryStr += 'AND ';
            else 
                isFirst = false;
            qryStr += 'LastName =:fNameStr ';            
        }
    }*/
    
    @AuraEnabled
    public static List<Contact> findByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT id, name, phone FROM Contact WHERE name LIKE :name];
    }
    
    @auraEnabled
	public static list<account> getAllAccounts()
    {
       list<account> accs =[select id, AccountNumber, Name, Phone,(select FirstName, LastName from contacts) from Account];
       return accs;
    }

}