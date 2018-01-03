public class c3{

    Account[] selectedacts;
    Opportunity[] selectedopts;
    
    public Account[] getselectedacts(){
        return selectedacts;
    }
    public Opportunity[] getselectedopts(){
    return selectedopts;
    }
    
    public pagereference showall(){
    selectedacts= [select Name, Type, Industry, Phone, Fax from Account];
    return null;
    }
    public pagereference showfiltered(){
    selectedacts= [select Name, Type, Industry, Phone, Fax from Account where Type='Customer - Channel'];
    return null;
    }
        
    public pagereference oppshowall(){
    selectedopts= [select Name, Amount, Probability, CalculateTime__c,Sub_Stage__c from Opportunity];
    return null;
    }
    public pagereference oppshowfiltered(){
    selectedopts= [select Name, Amount, Probability, CalculateTime__c,Sub_Stage__c from Opportunity where CalculateTime__c > '> 5 days'];
    return null;
    }
}