// This class clones an opportunity and all related partner records
public class OppCloneWithPartnerRecsController {
 
    //added an instance varaible for the standard controller
    private ApexPages.StandardController controller {get; set;}
     // add the instance for the variables being passed by id on the url
    private Opportunity opp {get;set;}
 
    // initialize the controller
    public OppCloneWithPartnerRecsController(ApexPages.StandardController controller) { 
        //initialize the stanrdard controller
        this.controller = controller;
        // load the current record
        opp = (Opportunity)controller.getRecord();       
    }
 
    // method called from the VF's action attribute to clone the partners    
    public PageReference oppCloneWithPartners() { 
         // setup the save point for rollback
         Savepoint sp = Database.setSavepoint();
         Opportunity newOpp;
         
         String fmtDate;
         DateTime dt;         

         try {                      
              //Copy the opportunity - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE              
              //WHEN MOVING TO PRODUCTION ADD THESE FIELDS
              // Strenghts__c, Underwriting__c,        

                    opp = [Select o.AccountId, o.Account.Name, 
                                  o.Amount, o.CloseDate,                                                        
                                  o.ExpectedRevenue, o.Fiscal, o.FiscalQuarter, o.FiscalYear, 
                                  o.HasOpportunityLineItem, o.Id, o.IsClosed, o.IsDeleted, 
                                  o.IsPrivate, o.IsWon, o.LeadSource, o.Name, o.StageName                                  
                           from Opportunity o
                           where o.Id = :opp.id];


             opp.CloseDate = opp.CloseDate + 365;
             //opp.Effective_Date__c = opp.Effective_Date__c + 365;
             
             //format the date for appending to the opp name
             //dt = DateTime.newInstance(opp.Effective_Date__c.year(),
             //                          opp.Effective_Date__c.month(), 1, 0, 0, 0);            
             fmtDate = dt.format('MM/yy'); 
            
             opp.Name =  opp.Account.Name + ' ' + fmtDate;
             opp.StageName = 'Proposal';
             //opp.Products_Sold__c = null;            

             newOpp = opp.clone(false);
             insert newOpp;

             // Copy over the partners to clone
             // Behind the SFDC scenes they actually create the second record on the Partner object
             // and they create the records on the OpportunityPartner object when an insert is executed
             // on the Partner object from their Opportunity page.  
             // Notice the code reads the SFDC OpportunityPartner object and insert into the SFDC Partner
             // object.  If you use the Apex Explorer you will see both objects reflect the same records.  
             // SFDC must have triggers behind the scenes handling this action.             
             List<Partner> insertPartners = new List<Partner>();
             List<OpportunityPartner> partners = 
                     new List<OpportunityPartner>([Select IsPrimary,AccountToId,OpportunityId, Role 
                                                   From OpportunityPartner 
                                                   where OpportunityId = :opp.id and 
                                                         AccountToId <>:newOpp.AccountId]);            
            for(Integer i=0;i<partners.size();i++)
            {
                Partner newPartner = new Partner();
                newPartner.AccountToId = partners.get(i).AccountToId;
                newPartner.OpportunityId= newOpp.Id;
                newPartner.IsPrimary=partners.get(i).IsPrimary;
                newPartner.Role=partners.get(i).Role;
                insertPartners.add(newPartner);                
            } 
            insert insertPartners; 
                       
         } catch (Exception e){
             // roll everything back in case of errors
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
         }
 
         return new PageReference('/'+newOpp.id);
         //return new PageReference('/'+newOpp.id+'/e?retURL=%2F'+newOpp.id);
    }
    
}