@isTest
private class AccountRelatedDataCtrl_Test {
    
    static testMethod void testPositiveFlow() {
        Contact c = new Contact(FirstName = 'Test', LastName = 'Test', Email = 'Test@test.com');
        insert c;
        
        Test.startTest();
        AccountRelatedDataCtrl ctrl = new AccountRelatedDataCtrl();
        ctrl.acct.Name = 'Test';
        ctrl.acct.AccountNumber = '9090909';
        ctrl.acct.States__c = 'Arizona';
        System.assertEquals(ctrl.contList.size(), 1);
        ctrl.contList[0] = new Contact(FirstName = 'Fn', LastName = 'Ln', Email = 'fn@ln.com');
        System.assertEquals(ctrl.opptyList.size(), 1);
        ctrl.opptyList[0] = new Opportunity(Name = 'Test', Amount = 90, StageName = 'Prospecting', CloseDate = Date.Today());
        ctrl.evnt.ZTS_US_Name__c = 'Test';
        System.assertEquals(ctrl.evntIntList.size(), 1);
        ctrl.evntIntList[0] = new ZTS_US_Event_Invitee__c(ZTS_US_Contact__c = c.Id,
                ZTS_US_Invitation_Status__c = 'Invited');
        System.assertEquals(ctrl.evntSchedList.size(), 1);
        ctrl.evntSchedList[0] = new Event_Schedule__c(Name = 'Test', Start_Date__c = Date.Today(),
                                                      End_Date__c = Date.Today());
        ctrl.save();
        Opportunity[] oList = [Select Id From Opportunity];
        System.assertEquals(oList.size(), 1);
        ApexPages.currentPage().getParameters().put('rowNum', '0');
        ctrl.removeContactRow();
        ctrl.removeOpptyRow();
        ctrl.removeEvntIntRow();
        ctrl.removeEvntSchedRow();
        ctrl.save();
        System.assertEquals(ctrl.opptyList.size(), 0);
        Test.stopTest();
    }
    
    static testMethod void testCloneMethods() {
        AccountRelatedDataCtrl ctrl = new AccountRelatedDataCtrl();
        ctrl.addContactRow();
        ctrl.addOpptyRow();
        ctrl.addEvntIntRow();
        ctrl.addEvntSchedRow();
        ApexPages.currentPage().getParameters().put('rowNum', '0');
        ctrl.contList[0].FirstName = 'Test';
        ctrl.cloneContactRow();
        System.assertEquals(ctrl.contList[2].FirstName, 'Test');
        ctrl.opptyList[0].Name = 'Test';
        ctrl.cloneOpptyRow();
        System.assertEquals(ctrl.opptyList[2].Name, 'Test');
        ctrl.evntIntList[0].ZTS_US_Invitation_Status__c = 'Invited';
        ctrl.cloneEvntIntRow();
        System.assertEquals(ctrl.evntIntList[2].ZTS_US_Invitation_Status__c, 'Invited');
        ctrl.evntSchedList[0].Name = 'Test';
        ctrl.cloneEvntSchedRow();
        System.assertEquals(ctrl.evntSchedList[2].Name, 'Test');
    }
    
    static testMethod void testSaveFailCase() {
        AccountRelatedDataCtrl ctrl = new AccountRelatedDataCtrl();
        ctrl.save();
        System.assertEquals(ApexPages.getMessages().size(), 1);
        ApexPages.getMessages().clear();
        ctrl.acct = null;
        try {
            ctrl.save();
        } catch (Exception e) {}
        System.assert(!ApexPages.getMessages().isEmpty());
    }
}