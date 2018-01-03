public class ViewPMDashboard_Ctrl {
public string SearchCriteriaVar{get;set;}
public Purchase_Order__c objPurchseOrder{get;set;}
public date selectdate{get;set;}
public boolean HideShowDate{get;set;}
public boolean HideShowText{get;set;}
public boolean  HideShowPgBlk{get;set;}
public string Selectedtext{get;set;}
public List<Opportunity>ListOfOpp{get;set;}
public List<Opportunity>ListOfOppValidation;
//public List<csord__Order__c>ListOfOrderHoldUnderImplementation;
//public List<csord__Order__c>ListOfOrderOnHold;
//public List<csord__Order__c>Implemented;
//public List<csord__Order__c>ListofBillingCompleted;
//public List<csord__Order__c>ListofOrdersCancelled;
//public List<csord__Order__c>ListofCstmrNeedByDtofOrdr;
public integer count{get;set;}
public integer countOppValidation{get;set;}
public integer countUnderImplementation{get;set;}
public integer countOnHold{get;set;}
public integer countOnImplemented{get;set;}
public integer countBillingCompleted{get;set;}
public integer countOrderCancelled{get;set;}
public integer countCustomerNeedByDate {get;set;}
public decimal countAmount{get;set;}
public decimal countAmount1{get;set;}
    public ViewPMDashboard_Ctrl (){
         objPurchseOrder = new Purchase_Order__c();
          HideShowDate = false;
          HideShowText= false;
          HideShowPgBlk=  false;
          SearchCriteriaVar = 'Customer Name';
          SelectionFields();
    }

    public List<SelectOption> getSearchCriteria()
    {
        List<SelectOption> Searchoptions = new List<SelectOption>();
        //Searchoptions .add(new SelectOption('None','--- None ---')); 
        Searchoptions .add(new SelectOption('Customer Name','Customer Name'));        
        Searchoptions .add(new SelectOption('Cust PO Date','Cust PO Date'));
        Searchoptions .add(new SelectOption('PO Received Date','PO Received Date'));
        return Searchoptions ; 
    }

    public void SelectionFields(){
        if(SearchCriteriaVar == 'Cust PO Date' ||  SearchCriteriaVar == 'PO Received Date'){
            HideShowDate = true;
            HideShowText= false;
        }
        else if(SearchCriteriaVar == 'Customer Name') {
             HideShowDate = false;
             HideShowText= true;
        }
        
        /*else if(SearchCriteriaVar  == '' || SearchCriteriaVar  == 'None'){
             HideShowDate = false;
             HideShowText= false;
        }*/
    }
    
    public void search(){
        countAmount=0;
        countAmount1=0;
        system.debug('Selectedtext::::::::::'+Selectedtext);
        system.debug('dt::::::::::'+objPurchseOrder.Cust_PO_Date__c);
        if(Selectedtext != null || Selectedtext!= ''){
            ListOfOpp = new List<Opportunity>([select id , name , Amount from Opportunity where Account.name =: Selectedtext AND Probability >=70 ]);
            for(Opportunity opp:ListOfOpp){
                    if(opp.Amount != null){
                     countAmount1= countAmount1+opp.Amount; 
                    }
            }
            count=ListOfOpp.size();
            
            
            ListOfOppValidation = new List<Opportunity>([select id , Amount from Opportunity where Account.name =:Selectedtext AND Sub_Stage__c = 'Opportunity Validation Pending']);
            for(Opportunity opp : ListOfOppValidation){
                    if(opp.Amount != null){
                        countAmount= countAmount+opp.Amount;
                    }
            }
            countOppValidation=ListOfOppValidation.size();
            
            
           /* ListOfOrderHoldUnderImplementation= new List<csord__Order__c>([select id from csord__Order__c where csord__Account__r.name =:Selectedtext AND 
                                                                (Sub_Stage__c ='Under Implementation' OR Sub_Stage__c ='Delivery Chalan Generated' 
                                                                OR Sub_Stage__c ='Hardware PO Approval' OR  Sub_Stage__c ='TP PO Approval' OR Sub_Stage__c ='Hardware Delivered' OR Sub_Stage__c ='Provisioning in Progress'
                                                                OR Sub_Stage__c ='Testing in Progress' OR Sub_Stage__c ='IR LOC Pending')]); 
            countUnderImplementation =  ListOfOrderHoldUnderImplementation.size();  
            
            ListOfOrderOnHold=new List<csord__Order__c>([select id from csord__Order__c where csord__Account__r.name =:Selectedtext AND 
                                (Sub_Stage__c ='On Hold - Airtel' OR Sub_Stage__c ='On Hold - Customer') ]);
            countOnHold=ListOfOrderOnHold.size();
            
            Implemented =new List<csord__Order__c>([select id from csord__Order__c where csord__Account__r.name =:Selectedtext AND 
                                        (Sub_Stage__c ='DD Pending' OR Sub_Stage__c ='Manual Billing Task Pending' OR Sub_Stage__c ='Billing trigger initiated')]);
            
            countOnImplemented=Implemented.size();
            
            
            ListofBillingCompleted = new List<csord__Order__c>([select id from csord__Order__c where csord__Account__r.name =:Selectedtext AND (Sub_Stage__c ='Billing Initiated Successfully')]);
            countBillingCompleted= ListofBillingCompleted.size();
            
            ListofOrdersCancelled = new List<csord__Order__c>([select id from csord__Order__c where csord__Account__r.name =:Selectedtext AND (Sub_Stage__c ='Cancelled')]);
            countOrderCancelled= ListofOrdersCancelled.size();
            
            
            ListofCstmrNeedByDtofOrdr = new List<csord__Order__c>([select id from csord__Order__c where csord__Account__r.name =:Selectedtext AND 
                                                                (Sub_Stage__c ='Created' OR Sub_Stage__c ='Submitted from SFDC' 
                                                                OR Sub_Stage__c ='Under Implementation' OR  Sub_Stage__c ='Error' 
                                                                OR Sub_Stage__c ='Delivery Chalan Generated'
                                                                OR Sub_Stage__c ='IR LOC Pending'
                                                                OR Sub_Stage__c ='Hardware PO Approval' OR Sub_Stage__c ='TP PO Approval'
                                                                OR Sub_Stage__c ='Hardware Delivered'
                                                                OR Sub_Stage__c ='Provisioning in Progress'
                                                                OR Sub_Stage__c ='On Hold - Airtel'
                                                                OR Sub_Stage__c ='On Hold - Airtel'
                                                                OR Sub_Stage__c ='Testing in Progress')]); 
            countCustomerNeedByDate =ListofCstmrNeedByDtofOrdr.size(); */
        }
        HideShowPgBlk= true;
    }
    
   
}