@isTest
private class CEEventUpdateAttendeeStatusTest {

    static testMethod void performUpdateTest(){
        //create ZTS_Events__c record, please include if any mandatory fields are missing 
        ZTS_Events__c ztsEvent = new ZTS_Events__c(ZTS_US_Location__c = 'Test Location',
                    //ZTS_US_Type__c is dependent picklist on ZTS_US_Event_Category__c field. So assign the correct values accordingly to these fields.
                                                   ZTS_US_Event_Category__c = 'Test Category', 
                                                   ZTS_US_Type__c = 'Test Category',
                                                   ZTS_US_Name__c   = 'Alex'
                                                   //ZTS_US_Contact__c= 'Test'
                                                );
        insert ztsEvent;
        
        Contact c= new Contact(LastName = 'Test');
        insert c;
        
        //create some ZTS_US_Event_Invitee__c records with ztsEvent as paernt, please include if any mandatory field are missing 
        List<ZTS_US_Event_Invitee__c> inviteeList = new List<ZTS_US_Event_Invitee__c>();
        inviteeList.add(new ZTS_US_Event_Invitee__c(ZTS_US_Event__c=ztsEvent.Id,ZTS_US_Contact__c=c.Id));
        inviteeList.add(new ZTS_US_Event_Invitee__c(ZTS_US_Event__c=ztsEvent.Id,ZTS_US_Contact__c=c.Id));
        inviteeList.add(new ZTS_US_Event_Invitee__c(ZTS_US_Event__c=ztsEvent.Id,ZTS_US_Contact__c=c.Id));
        inviteeList.add(new ZTS_US_Event_Invitee__c(ZTS_US_Event__c=ztsEvent.Id,ZTS_US_Contact__c=c.Id));
        insert inviteeList;
        
        ApexPages.StandardController stdZtsEvent = new ApexPages.StandardController(ztsEvent);          
        CEEventUpdateAttendeeStatus ceUpdateController = new CEEventUpdateAttendeeStatus(stdZtsEvent);
        
        ceUpdateController.wrpConList[0].isSelected = true;
        
        ceUpdateController.selectAllVar = false;

        ceUpdateController.selectAll();
        ceUpdateController.updateStatus();
        
        ceUpdateController.selectAllVar = true;

        ceUpdateController.selectAll();
        ceUpdateController.updateStatus();
        ceUpdateController.cancelAction();
    }
    
   static testMethod void performUpdateTestNegetive(){
        //create ZTS_Events__c record, please include if any mandatory fields are missing 
        ZTS_Events__c ztsEvent = new ZTS_Events__c(ZTS_US_Location__c = 'Test Location',
                    //ZTS_US_Type__c is dependent picklist on ZTS_US_Event_Category__c field. So assign the correct values accordingly to these fields.
                                                   ZTS_US_Event_Category__c = 'Test Category', 
                                                   ZTS_US_Type__c = 'Test Category',
                                                   ZTS_US_Name__c   = 'Alex'
                                                   //ZTS_US_Contact__c= 'Test'
                                                );
        insert ztsEvent;
        
        Contact c= new Contact(LastName = 'Test');
        insert c;
        
        ApexPages.StandardController stdZtsEvent = new ApexPages.StandardController(ztsEvent);          
        CEEventUpdateAttendeeStatus ceUpdateController = new CEEventUpdateAttendeeStatus(stdZtsEvent);
        
        ceUpdateController.selectAll();
        ceUpdateController.updateStatus();
        ceUpdateController.cancelAction();
    }
}