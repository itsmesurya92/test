public with sharing class CustomSchedulingController{

    public Date myDate { get; set; }
    public Time myTime { get; set; }
    public String jobName { get; set; }
    public String SelectedApexClass { get; set; }
    public DateTime classTime {get; set;}
    public integer apexclassid;
    public integer dateVal1{get;set;}
    public boolean radioSelection{get;set;}    
    public Date strDate { get; set; }
    public Date endDate { get; set; }
    public string SelectedTime {get;set;}
    public string selectedTimeWindow{get;set;}
    public List<String> SelectedFreqValue {get;set;} 
    public boolean byDay{get;set;}
    public boolean byMonth{get;set;}
    public boolean showMonths{get;set;}
    public boolean showWeeks{get;set;}
    public String RadioSel{get;set;}
    
    public CustomSchedulingController(){
        radioSelection = true;
    }
     
    public List<SelectOption> getApexClassList(){      
        List<SelectOption> TempApexClassList = new List<SelectOption>();
        for (ApexClass apexclass : [SELECT Id, Name, Body from ApexClass]){                
            if(apexclass.body.contains('implements') && apexclass.body.contains('Schedulable') && apexclass.Name<>'RetrieveClasses'){                
                TempApexClassList.add(new SelectOption(apexclass.Name, apexclass.Name));
            }
        }             
        return tempApexClassList;       
    }
    
   
    public List<SelectOption> getDayofMonth(){
        List<SelectOption> temp = new List<SelectOption>();
        for(Integer i = 1;i<=31;i++){
            temp.add(new SelectOption(String.valueOf(i),String.valueOf(i)));
        }
        temp.add(new SelectOption('last','last'));
        return temp;
    }
     
     public List<SelectOption> getOppWeekDays(){        
        List<selectoption> temp = new List<selectoption>();        
        temp.add(new selectOption('SUN',Constants.CONST_SUNDAY));
        temp.add(new selectOption('MON',Constants.CONST_MONDAY));
        temp.add(new selectOption('TUES',Constants.CONST_TUESDAY));
        temp.add(new selectOption('WED',Constants.CONST_WEDNESDAY));
        temp.add(new selectOption('THUR',Constants.CONST_THURSDAY));
        temp.add(new selectOption('FRI',Constants.CONST_FRIDAY));
        temp.add(new selectOption('SAT',Constants.CONST_SATURDAY));        
        return temp;
    }
     
     public List<selectOption> getFrequencyTime(){        
        List<selectoption> temp = new List<selectoption>();        
        temp.add(new selectOption('--None--','--None--'));
        temp.add(new selectOption('0',Constants.CONST_TWELVE_AM));
        temp.add(new selectOption('1',Constants.CONST_ONE_AM));
        temp.add(new selectOption('2',Constants.CONST_TWO_AM));
        temp.add(new selectOption('3',Constants.CONST_THREE_AM));
        temp.add(new selectOption('4',Constants.CONST_FOUR_AM));
        temp.add(new selectOption('5',Constants.CONST_FIVE_AM));
        temp.add(new selectOption('6',Constants.CONST_SIX_AM));
        temp.add(new selectOption('7',Constants.CONST_SEVEN_AM));
        temp.add(new selectOption('8',Constants.CONST_EIGHT_AM));
        temp.add(new selectOption('9',Constants.CONST_NINE_AM));
        temp.add(new selectOption('10',Constants.CONST_TEN_AM));
        temp.add(new selectOption('11',Constants.CONST_ELEVEN_AM));
        temp.add(new selectOption('12',Constants.CONST_TWELVE_PM));
        temp.add(new selectOption('13',Constants.CONST_ONE_PM));
        temp.add(new selectOption('14',Constants.CONST_TWO_PM));
        temp.add(new selectOption('15',Constants.CONST_THREE_PM));
        temp.add(new selectOption('16',Constants.CONST_FOUR_PM));
        temp.add(new selectOption('17',Constants.CONST_FIVE_PM));
        temp.add(new selectOption('18',Constants.CONST_SIX_PM));
        temp.add(new selectOption('19',Constants.CONST_SEVEN_PM));
        temp.add(new selectOption('20',Constants.CONST_EIGHT_PM));
        temp.add(new selectOption('21',Constants.CONST_NINE_PM));
        temp.add(new selectOption('22',Constants.CONST_TEN_PM));
        temp.add(new selectOption('23',Constants.CONST_ELEVEN_PM));        
        return temp;
    }
    
    public void controllMonthRadios(){        
        if(radioSel == '1'){            
            byDay = false;
            byMonth = true;    
        }
        if(radioSel == '2'){
            byDay = true;
            byMonth = false;    
        }
    }
    
    public void controllRadios(){
        byDay = false;
        byMonth = false;  
        system.debug('------------------'+selectedTimeWindow);
        if(selectedTimeWindow=='1'){
            showWeeks = true;
            showMonths = false;
        }
        if(selectedTimeWindow=='2'){
            showWeeks = false;
            showMonths = true;
        }
    }
    public void storeWeeks(){
        system.debug('*******'+SelectedFreqValue);
    }
    public string GetCronStringForSchedule(){
        /*
        Integer Schdtime = Integer.valueOf(SelectedTime);
        string sch = '';
        string a = '';
        SelectedFreqValue= SelectedFreqValue.replaceAll( '\\s+', '');
        SelectedFreqValue = SelectedFreqValue.remove(')');
        SelectedFreqValue = SelectedFreqValue.remove('(');
        List<String> ListOfValues = SelectedFreqValue.split('\\,');
        if(ListOfValues.size() >0)
            a = ListOfValues.get(0)+ '-' + ListOfValues.get(ListOfValues.size()- 1);
        else
            a = ListOfValues.get(0);
        sch = '0 0 '+ Schdtime +' ? * '+ a;
        return sch;
        */
        return null;
    }

    public string JobSchedular(){
        String timeStr = GetCronStringForSchedule();
        Type t = Type.forName(SelectedApexClass);          
        Schedulable sch = (Schedulable)t.newInstance();
        String  jobID = system.schedule(jobName, timeStr, sch);
        return jobID;
    }
   
     
    public PageReference CustomSchedule(){
        system.debug('===============');
        try{
           system.debug('------------------'+selectedTimeWindow);
            system.debug(SelectedFreqValue+'=====');
           
        }
        catch(Exception e){}
        //return null;   
        return null;     
    }
   
    
     public PageReference run(){
        String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute()); 
        String ss = String.valueOf(Datetime.now().second());
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        
        Type t = Type.forName(SelectedApexClass);   
        system.debug(nextFireTime+'========'+t);       
        Schedulable sch = (Schedulable)t.newInstance();
        system.debug('========'+sch);
        try{
        System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, sch);
        }catch(Exception e){}
        All_Scheduled_Jobs__c str = new All_Scheduled_Jobs__c ();
        str.Name = jobName;
        str.Scheduled_Date__c  = myDate ;           
        insert str;
        return null;
    }
     
}