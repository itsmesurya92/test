public with sharing class BankingListController {
    @AuraEnabled
    public static List<Account_Info__c> getAccountInfo() {
        return[select id, Name, Account_Name__c, Account_Type__c, Account_Opened_On__c
                					from Account_Info__c
                					ORDER BY createdDate ASC]; 
    }
    @AuraEnabled
    public static List<Transaction_History__c> getTransactionInfo() {
        return[select id, Name, Transaction_Status__c, Transferred_On__c, Transferred_to__c,Transferred_to__r.Name
                					from Transaction_History__c
                					ORDER BY createdDate ASC]; 
    }
    @AuraEnabled
    public static List<Loan__c> getLoanInfo() {
        return[select id, Name, Account_Number__c, Credit_History__c, Loan_Holder_Name__c, Loan_Type__c, Account_Number__r.Name,Credit_History__r.Name
                					from Loan__c
                					ORDER BY createdDate ASC]; 
    }
    @AuraEnabled
    public static List<Credit_History__c> getCreditInfo() {
        return[select id, Name, Account_Info__c, Credit_Score__c, Eligible_for_Loan__c, Account_Info__r.Name
                					from Credit_History__c
                					ORDER BY createdDate ASC]; 
    }
}