public with sharing class MapsController {
    
    public List<String> listOfAddresses {get; set;}
    public List<String> listOfContacts {get; set;}
    public Map<Id,List<String>> caseMap{get;set;}
    public List<String> listOfContactIds{get;set;}
    public Integer rowCount{get;set;}
    
    
    public Map<Id,List<Case>> contactsMap{get;set;}
    public Integer offsetCount{get;set;}
    public Integer limitCount{get;set;}
    public List<Id> keyList{get;set;}
    public string locLat{get;set;}
    public string locLon{get;set;}    
    public MapsController() {
       listOfContacts = new List<string>();
       listOfAddresses = new List<String>();
       listOfContactIds = new List<String>();         
       caseMap = new Map<Id,List<String>>();
       Integer count = 0;
       contactsMap = new Map<Id,List<Case>>();
       //get current User Location
       system.debug('===='+[SELECT Id,LoginGeoId,LoginTime FROM LoginHistory Where UserId = :UserInfo.getUserId() order by LoginTime DESC limit 1]);
       system.debug('===='+[SELECT City, PostalCode,Country FROM LoginGeo WHERE Id = '04Fj000004PkAtDEAV']);       
       String locGeoId = [SELECT Id,LoginGeoId,LoginTime FROM LoginHistory Where UserId = :UserInfo.getUserId() order by LoginTime DESC limit 1].LoginGeoId;
       LoginGeo locGeo = [SELECT Latitude, Longitude, City, PostalCode,Country FROM LoginGeo WHERE Id = :locGeoId];
       locLat = ''+locGeo.Latitude;
       locLon = ''+locGeo.Longitude;
       //get the cases data
        for (Case c : [SELECT Id, CaseNumber,Contact.Phone,Contact.MailingAddress,Contact.Name,
                        Contact.MailingStreet,Contact.MailingCity,Contact.MailingState,Contact.MailingCountry,Contact.MailingPostalCode,ContactId
                       FROM Case 
                       WHERE Contact.MailingCity != NULL
                       AND Status != 'Closed'
                       AND Case.OwnerId=: UserInfo.getUserId()]) {
                       
            Address addr = c.Contact.MailingAddress;   
            if (addr != null && !contactsMap.containsKey(c.ContactId)) {
                contactsMap.put(c.ContactId,new List<Case>{c});
            }else{
                contactsMap.get(c.ContactId).add(c);
            
            }   
                       
        }
       if(offsetCount == null) offsetCount = 0;
       if(limitCount == null)   limitCount = 0;
        prepareMapData();
       
       

    }
    
    public void next(){
        if(limitCount < contactsMap.keySet().size())  prepareMapData();  
    }
    public void prepareMapData(){
        listofAddresses.clear();
        listOfContacts.clear();
        listOfContactIds.clear();
        offsetCount = limitCount;
        keyList = new List<Id>(contactsMap.keySet());
        //listOfContactIds = new List<Id>(contactsMap.keySet());
        if(keyList.size() - offsetCount>6)
            rowCount = 6;
        else
            rowCount = keyList.size() - offsetCount;
        Integer dispalyCount = 0, startCount = offsetCount, endCount = 0;
        endCount = startCount + 6;
        endCount = endCount>listOfContactIds.size()?keyList.size():endCount;
        system.debug(''+keyList);
        system.debug(''+contactsMap);
         keyList.sort();
        for (Integer i = startCount; i<endCount;i++) {
            Id  cId = keyList[i];
        //for (Id cId : contactsMap.keySet()) {
            if(dispalyCount>5) break;
            dispalyCount++;
            limitCount++;
            String displayString = '';
            Boolean isFirst = true;
            for(Case c: contactsMap.get(cId)){
                system.debug(cId);
                if(isFirst){
                    system.debug(isFirst);
                    isFirst = false;
                    Address addr = c.Contact.MailingAddress;
                    listOfContactIds.add('\"'+c.ContactId+'\"');
                    // displayString += '\"'+c.ContactId+'! Contact Name: '+c.Contact.Name+'<br/> Case(s):'+c.CaseNumber;
                    
                    String fullAddress = '\"';
                    if (addr.getStreet() != null) {
                        fullAddress = fullAddress + addr.getStreet();
                        system.debug(addr.getStreet());
                    }
                    if (addr.getCity() != null) {
                        fullAddress = fullAddress + ', ' + addr.getCity();
                        system.debug(addr.getCity());                        
                    }
                    if (addr.getCountry() != null) {
                        if (addr.getCountry() == 'US' || addr.getCountry() == 'USA') {
                            fullAddress = fullAddress + ', ' + addr.getState() + '\"';
                        }
                        else {
                            fullAddress = fullAddress + ', ' + addr.getCountry() + '\"';
                        }
                        system.debug(addr.getCountry());    
                    }
                    else {
                        fullAddress = fullAddress + '\"';        
                    }
                    System.debug(fullAddress);
                    listOfAddresses.add(fullAddress);  
                    system.debug(listOfAddresses); 
                    String contactPhone = String.isNotBlank(c.Contact.Phone) ? c.Contact.Phone : 'Not Available';
                    displayString += '{ address:'+fullAddress+', phone:\"'+contactPhone+'\", contactId:\"'+c.ContactId+'\", contactName: \"'+c.Contact.Name+'\", Cases:[ { caseId: \"'+c.Id+'\", caseNumber: \"'+c.CaseNumber+'\"}';                                         
                }else{
                    displayString += ',{caseId:\"'+c.Id+'\",caseNumber: \"'+c.CaseNumber+'\"}';                      
                    //displayString += ' and '+c.CaseNumber;                      
                }    
            }
            displayString += ']}';
            //displayString += ' \"';
            listOfContacts.add(displayString);
        } 
        System.debug(listOfContacts);       
        
    }
    
}