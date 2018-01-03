global class batchClassExample implements Database.batchable<sObject>{ 
   global Database.querylocator start(Database.BatchableContext info){ 
       return Database.getQueryLocator('select Id,Name,NumberOfEmployees from Account limit 10');
 
   }     
   global void execute(Database.BatchableContext info, List<Account> scope){
       List<Account> accsToUpdate = new List<Account>();
       for(Account a : scope){ 
           a.Name = 'true'; 
           a.NumberOfEmployees = 70; 
           accsToUpdate.add(a); 
       } 
       //update accsToUpdate; 
   }     
   global void finish(Database.BatchableContext info){     
   } 
}