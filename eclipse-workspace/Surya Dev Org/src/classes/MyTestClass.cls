@isTest

private class MyTestClass {

    static testmethod void test1() {
        
        Set<Id> testGroup = new Set<Id>();
        testGroup.add('00Gj0000002T1sa');
        testGroup.add('00Gj0000002T1NP');
        Map<Id,Set<Id>> setIds = QueryGroup.GetUserIdsFromGroup(testGroup);
            
        System.debug('**** MapIds '+setIds);
        /*
        for (Id user : QueryGroup.GetUserIdsFromGroup(testGroup) ){
            System.debug('The user is  ' + user);
        }
        }*/
    }
}