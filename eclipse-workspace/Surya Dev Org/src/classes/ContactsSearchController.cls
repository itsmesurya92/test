public class ContactsSearchController{
    
    public List<Contact> conList;
    public List<conWrapper> wrpConList{get;set;} 
    
    //Search Fields
    public String fNameStr{get;set;}
    public String lNameStr{get;set;}
    public String emailStr{get;set;}
    public String phnStr{get;set;}
    
    public Map<String,Contact> conMap;
    public String selectedRec{get;set;}
    public Contact con{get;set;}
    
    public ContactsSearchController(){
        conList = new List<Contact>();
        wrpConList = new List<conWrapper>();
        conMap = new Map<String,Contact>();
        con = new Contact();
        for(Contact c : [select Id, FirstName,LastName,Email,Phone,Account.Name from Contact limit 10]){
            wrpConList.add(new conWrapper(c));    
        }
    }
    
    public void searchContacts(){
        String qryStr = 'select Id, FirstName,LastName,Email,Phone,Account.Name from Contact where ';
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
        if(String.isNotBlank(emailStr)){
            if(!isFirst) 
                qryStr += 'AND ';
            else 
                isFirst = false;
            qryStr += 'AND Email =:emailStr ';
         }
         if(String.isNotBlank(phnStr)){
            if(!isFirst) 
                qryStr += 'AND ';
            else 
                isFirst = false;
            qryStr += 'AND Phone =:phnStr ';
         }
         
         system.debug(qryStr);
         if(!conList.isEmpty()) conList.clear();
         conList = Database.query(qryStr); 
         
         if(!wrpConList.isEmpty()) wrpConList.clear(); 
         if(conMap.size()>0) conMap.clear();
         for(Contact c : conList){
            wrpConList.add(new conWrapper(c));
            conMap.put(c.Id,c);  
        }
        /*  
        if(fNameStr<>null && lNameStr<>null && emailStr<>null && phnStr<>null){
            conList = [select Id, FirstName,LastName,Email,Phone,Account.Name from Contact 
                       Where FirstName =:fNameStr AND 
                             LastName =:lNameStr AND 
                             Email =:emailStr AND
                             Phone =:phnStr                       
                      ];    
        }
        */
    }
    
    public void resteSearchString(){
        fNameStr = lNameStr = emailStr = phnStr = '';
    }
    
    public class conWrapper{
        public Contact con{get;set;}
        public boolean isSelected{get;set;}
        
        public conWrapper(Contact c){
            con = c;
            isSelected = false;
        }
    }
    
    public void copyContactData(){
        //Event Invitation
        con = conMap.get(selectedRec);
        system.debug('========'+con.FirstName);
        //Inv.Contact = 
    }
    
}