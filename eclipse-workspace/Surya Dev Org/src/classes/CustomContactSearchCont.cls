public with sharing class CustomContactSearchCont 
{
    public List<Contact> cons{get;set;}
    public String strQuery;
    public String bv='';
    public String selectedacc{get;set;}
    
    public CustomContactSearchCont()    
    {    
        initstrQuery();
        cons=Database.Query(strQuery);
    }    
        
    public void initstrQuery()
    {
        if(bv==''||bv=='withwithout')
            strQuery='SELECT Name, FirstName, LastName, Account.Name, Email, Phone from Contact WHERE Id!=null';
        if(bv=='with')
            strQuery='SELECT Name, FirstName, LastName, Account.Name, Email, Phone from Contact WHERE Account.Name!=null';
        if(bv=='without')
            strQuery='SELECT Name, FirstName, LastName, Account.Name, Email, Phone from Contact WHERE Account.Name=null';
    }    
    

    public PageReference runSearch()
    {

        String fn=ApexPages.currentPage().getParameters().get('firstName');        
        String ln=ApexPages.currentPage().getParameters().get('lastName');
        String ls=ApexPages.currentPage().getParameters().get('leadSource');
        String pn=ApexPages.currentPage().getParameters().get('phone'); 
        String em=ApexPages.currentPage().getParameters().get('email');     
        bv=ApexPages.currentPage().getParameters().get('butVal');    
        initstrQuery();       
        if(!fn.equals(''))
                strQuery+=' AND FirstName LIKE \''+fn+'%\'';
        if(!ln.equals(''))        
                strQuery+=' AND LastName LIKE \''+ln+'%\'';
        if(!ls.equals(''))
                strQuery+=' AND LeadSource=:ls';
        if(!pn.equals(''))
                strQuery+=' AND Phone LIKE \''+pn+'%\'';
        if(!pn.equals(''))
                strQuery+=' AND Email LIKE \''+em+'%\'';
        

        try 
        {
            cons = Database.query(strQuery);
        }
        catch (Exception e) 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }             
        return null;
    }
    
    public PageReference delTheAccount()
    {
        if(selectedacc!=null)
        {
            Contact ct= Database.Query('SELECT Id, Name, FirstName from Contact WHERE Id=:selectedacc');
            Delete ct;  
            PageReference testPage = Page.CustomContactSearchPage;
            testPage.setRedirect(true);
            return testPage;           
        }
        return null;
    }
    
    /*Getting Field Labels and Picklist Values*/
    public string FullNameLabel
    {
        get
        {
            Schema.DescribeFieldResult f=Contact.Name.getDescribe();
            return (string) f.getLabel();
        }
        set;
    }
    
    public string FirstNameLabel
    {
        get
        {
            Schema.DescribeFieldResult f=Contact.FirstName.getDescribe();
            return (string) f.getLabel();
        }
        set;
    }
    
    public string LastNameLabel
    {
        get
        {
            Schema.DescribeFieldResult f=Contact.LastName.getDescribe();
            return (string) f.getLabel();
        }
    }
    
    public string LeadSourceLabel
    {
        get
        {
            Schema.DescribeFieldResult f=Contact.LeadSource.getDescribe();
            return (string) f.getLabel();
        }
        set;
    }
    
    public string PhoneLabel
    {
        get
        {
            Schema.DescribeFieldResult f=Contact.Phone.getDescribe();
            return (string) f.getLabel();
        }
        set;
    }
    
    public string EmailLabel
    {
        get
        {
            Schema.DescribeFieldResult f=Contact.Email.getDescribe();
            return (string) f.getLabel();
        }
        set;
    }


    
    public List<String> LeadSourceVal    
    {        
        get
        {
            if (LeadSourceVal  == null)
            { 
                LeadSourceVal= new List<String>();
                Schema.DescribeFieldResult field = Contact.LeadSource.getDescribe();
                for (Schema.PicklistEntry f : field.getPicklistValues())                  
                LeadSourceVal.add(f.getLabel());          
            }          
            return LeadSourceVal;                  
        }        
         set;    
    }      
}