public with sharing class AccountRelatedDataCtrl {
    
    public Account acct { get; set; }
    public List<Contact> contList { get; set; }
    public List<Opportunity> opptyList { get; set; }
    public ZTS_Events__c evnt { get; set; }
    public List<ZTS_US_Event_Invitee__c> evntIntList { get; set; }
    public List<Event_Schedule__c> evntSchedList { get; set; }
    public ZTS_US_Event_Account__c aer { get; set; }
    private List<SObject> removeSObjsList;
    
    public AccountRelatedDataCtrl() {
        resetPage();
    }
    
    public void addContactRow() {
        contList.add(new Contact());
    }
    
    public void removeContactRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < contList.size()) {
            if (contList[rowNum].Id != null) {
                removeSObjsList.add(contList[rowNum]);
            }
            contList.remove(rowNum);
        }
    }
    
    public void cloneContactRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < contList.size()) {
            contList.add(contList[rowNum].clone(false, true));
        }
    }
    
    public void addOpptyRow() {
        opptyList.add(new Opportunity());
    }
    
    public void removeOpptyRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < opptyList.size()) {
            if (opptyList[rowNum].Id != null) {
                removeSObjsList.add(opptyList[rowNum]);
            }
            opptyList.remove(rowNum);
        }
    }
    
    public void cloneOpptyRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < opptyList.size()) {
            opptyList.add(opptyList[rowNum].clone(false, true));
        }
    }
    
    public void addEvntIntRow() {
        evntIntList.add(new ZTS_US_Event_Invitee__c());
    }
    
    public void removeEvntIntRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < evntIntList.size()) {
            if (evntIntList[rowNum].Id != null) {
                removeSObjsList.add(evntIntList[rowNum]);
            }
            evntIntList.remove(rowNum);
        }
    }
    
    public void cloneEvntIntRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < evntIntList.size()) {
            evntIntList.add(evntIntList[rowNum].clone(false, true));
        }
    }
    
    public void addEvntSchedRow() {
        evntSchedList.add(new Event_Schedule__c());
    }
    
    public void removeEvntSchedRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < evntSchedList.size()) {
            if (evntSchedList[rowNum].Id != null) {
                removeSObjsList.add(evntSchedList[rowNum]);
            }
            evntSchedList.remove(rowNum);
        }
    }
    
    public void cloneEvntSchedRow() {
        Integer rowNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowNum'));
        if (rowNum >= 0 && rowNum < evntSchedList.size()) {
            evntSchedList.add(evntSchedList[rowNum].clone(false, true));
        }
    }
    
    public void save() {
        
        String errMsg;
        try {
            upsert acct;
            for (Contact c : contList) {
                c.AccountId = acct.Id;
            }
            if (!contList.isEmpty()) {
                upsert contList;
            }
            for (Opportunity o : opptyList) {
                o.AccountId = acct.Id;
            }
            if (!opptyList.isEmpty()) {
                upsert opptyList;
            }
            upsert evnt;
            for (ZTS_US_Event_Invitee__c i : evntIntList) {
                i.ZTS_US_Event__c = evnt.Id;
            }
            if (!evntIntList.isEmpty()) {
                upsert evntIntList;
            }
            for (Event_Schedule__c e : evntSchedList) {
                e.Event__c = evnt.Id;
            }
            if (!evntSchedList.isEmpty()) {
                upsert evntSchedList;
            }
            if (aer == null || aer.Id == null) {
                aer = new ZTS_US_Event_Account__c();
                aer.ZTS_US_Event_Account__c = acct.Id;
                aer.ZTS_US_Events__c = evnt.Id;
                insert aer;
                aer = [Select Id, Name, ZTS_US_Event_Account__c, ZTS_US_Events__c From ZTS_US_Event_Account__c Where Id =: aer.Id];
            }
            if (removeSObjsList != null && !removeSObjsList.isEmpty()) {
                delete removeSObjsList;
                removeSObjsList = new List<SObject>();
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Records saved successfully!'));
        } catch (DmlException de) {
            errMsg = de.getDmlMessage(0);
        } catch (Exception e) {
            errMsg = e.getMessage();
        }
        if (errMsg != null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errMsg));
            acct.Id = null;
            for (Contact c : contList) {
                c.Id = null;
            }
            evnt.Id = null;
            for (ZTS_US_Event_Invitee__c i : evntIntList) {
                i.id = null;
            }
            for (Event_Schedule__c e : evntSchedList) {
                e.Id = null;
            }
        }
    }
    
    public void resetPage() {
        
        acct = new Account();
        contList = new List<Contact>{new Contact()};
        opptyList = new List<Opportunity>{new Opportunity()};
        evnt = new ZTS_Events__c();
        evntIntList = new List<ZTS_US_Event_Invitee__c>{new ZTS_US_Event_Invitee__c()};
        evntschedList = new List<Event_Schedule__c>{new Event_Schedule__c()};
        aer = null;
        removeSObjsList = new List<SObject>();
    }
}