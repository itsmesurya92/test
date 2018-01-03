public with sharing class RetrieveClasses {

    public Date myDate { get; set; }
    public Time myTime { get; set; }
    public String jobName { get; set; }
    public String SelectedApexClass { get; set; }
    public DateTime classTime {get; set;}
    public string SelectedMinutes {get; set;}
    public string SelectedSchFre{get; set;}
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
    public String selectedDay{get;set;}
    public String selectedDayOfWeek{get;set;}
    public String selectedWeekOfMonth{get;set;}
    
    //Batch Class Schedule 
    public String selH{get;set;}
    public String selM{get;set;}
    public String selS{get;set;}
    //Batch Class Schedule 
    public RetrieveClasses(){
        radioSelection = true;
        SelectedFreqValue = new List<String>();
    }
     
    public List<SelectOption> getApexClassList(){      
        List<SelectOption> TempApexClassList = new List<SelectOption>();
        for (ApexClass apexclass : [SELECT Id, Name, Body from ApexClass]){                
            if(apexclass.body.contains('implements') && apexclass.body.contains('Batchable')&& apexclass.Name<>'RetrieveClasses'){                
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
    
    public List<SelectOption> getMinutes() {
        List<SelectOption> min = new List<SelectOption>();
        min.add(new SelectOption('','--None--'));
        min.add(new SelectOption('1','Now'));
        min.add(new SelectOption('2','Later'));
        return min;
    }
    
    
     
     public List<SelectOption> getOppWeekDays(){        
        List<selectoption> temp = new List<selectoption>();        
        temp.add(new selectOption('SUN',Constants.CONST_SUNDAY));
        temp.add(new selectOption('MON',Constants.CONST_MONDAY));
        temp.add(new selectOption('TUE',Constants.CONST_TUESDAY));
        temp.add(new selectOption('WED',Constants.CONST_WEDNESDAY));
        temp.add(new selectOption('THU',Constants.CONST_THURSDAY));
        temp.add(new selectOption('FRI',Constants.CONST_FRIDAY));
        temp.add(new selectOption('SAT',Constants.CONST_SATURDAY));        
        return temp;
    }
    
     public List<SelectOption> getWeekDays(){        
        List<selectoption> temp = new List<selectoption>();        
        temp.add(new selectOption('1',Constants.CONST_SUNDAY));
        temp.add(new selectOption('2',Constants.CONST_MONDAY));
        temp.add(new selectOption('3',Constants.CONST_TUESDAY));
        temp.add(new selectOption('4',Constants.CONST_WEDNESDAY));
        temp.add(new selectOption('5',Constants.CONST_THURSDAY));
        temp.add(new selectOption('6',Constants.CONST_FRIDAY));
        temp.add(new selectOption('7',Constants.CONST_SATURDAY));        
        return temp;
    }
    
     
     public List<selectOption> getFrequencyTime(){        
        List<selectoption> temp = new List<selectoption>();        
        temp.add(new selectOption('--None--','Hrs'));
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
    
    public List<selectOption> getFrequencyMinTime(){        
        List<selectoption> temp = new List<selectoption>();        
        temp.add(new selectOption('--None--','Min'));
        temp.add(new selectOption('ZERO','0'));
        temp.add(new selectOption('ONE','1'));
        temp.add(new selectOption('TWO','2'));
        temp.add(new selectOption('THREE','3'));
        temp.add(new selectOption('FOUR','4'));
        temp.add(new selectOption('THREE','3'));
        temp.add(new selectOption('FIVE','5'));
        temp.add(new selectOption('SIX','6'));
        temp.add(new selectOption('SEVEN','7'));
        temp.add(new selectOption('EIGHT','8'));
        temp.add(new selectOption('NINE','9'));
        temp.add(new selectOption('TEN','10'));
        temp.add(new selectOption('ELEVEN','11'));
        temp.add(new selectOption('TWELVE','12'));
        temp.add(new selectOption('THIRTEEN','13'));
        temp.add(new selectOption('FOURTEEN','14'));
        temp.add(new selectOption('FIFTEEN','15'));
        temp.add(new selectOption('SIXTEEN','16'));
        temp.add(new selectOption('SEVENTEEN','17'));
        temp.add(new selectOption('EIGHTEEN','18'));
        temp.add(new selectOption('NINETEEN','19'));
        temp.add(new selectOption('TWENTY','20'));
        temp.add(new selectOption('TWENTYONE','21'));
        temp.add(new selectOption('TWENTYTWO','22'));
        temp.add(new selectOption('TWENTYTHREE','23'));
        temp.add(new selectOption('TWENTYFOUR','24'));
        temp.add(new selectOption('TWENTYFIVE','25'));
        temp.add(new selectOption('TWENTYSIX','26'));
        temp.add(new selectOption('TWENTYSEVEN','27'));
        temp.add(new selectOption('TWENTYEIGHT','28'));
        temp.add(new selectOption('TWENTYNINE','29'));
        temp.add(new selectOption('THIRTY','30'));
        temp.add(new selectOption('THIRTY','31'));
        temp.add(new selectOption('THIRTY','32'));
        temp.add(new selectOption('THIRTY','33'));
        temp.add(new selectOption('THIRTY','34'));
        temp.add(new selectOption('THIRTY','35'));
        temp.add(new selectOption('THIRTY','36'));
        temp.add(new selectOption('THIRTY','37'));
        temp.add(new selectOption('THIRTY','38'));
        temp.add(new selectOption('THIRTY','39'));
        temp.add(new selectOption('THIRTY','40'));
        temp.add(new selectOption('THIRTY','41'));
        temp.add(new selectOption('THIRTY','42'));
        temp.add(new selectOption('THIRTY','43'));
        temp.add(new selectOption('THIRTY','44'));
        temp.add(new selectOption('THIRTY','45'));
        temp.add(new selectOption('THIRTY','46'));
        temp.add(new selectOption('THIRTY','47'));
        temp.add(new selectOption('THIRTY','48'));
        temp.add(new selectOption('THIRTY','49'));
        temp.add(new selectOption('THIRTY','50'));
        temp.add(new selectOption('THIRTY','51'));
        temp.add(new selectOption('THIRTY','52'));
        temp.add(new selectOption('THIRTY','53'));
        temp.add(new selectOption('THIRTY','54'));
        temp.add(new selectOption('THIRTY','55'));
        temp.add(new selectOption('THIRTY','56'));
        temp.add(new selectOption('THIRTY','57'));
        temp.add(new selectOption('THIRTY','58'));
        temp.add(new selectOption('THIRTY','59'));
        
        
        /*temp.add(new selectOption('4',Constants.CONST_FOUR));
        temp.add(new selectOption('5',Constants.CONST_FIVE));
        temp.add(new selectOption('6',Constants.CONST_SIX));
        temp.add(new selectOption('7',Constants.CONST_SEVEN));
        temp.add(new selectOption('8',Constants.CONST_EIGHT));
        temp.add(new selectOption('9',Constants.CONST_NINE));
        temp.add(new selectOption('10',Constants.CONST_TEN));
        temp.add(new selectOption('11',Constants.CONST_ELEVEN));
        temp.add(new selectOption('12',Constants.CONST_TWELVE));
        temp.add(new selectOption('13',Constants.CONST_THIRTEEN));
        temp.add(new selectOption('14',Constants.CONST_FOURTEEN));
        temp.add(new selectOption('15',Constants.CONST_FIFTEEN));
        temp.add(new selectOption('16',Constants.CONST_SIXTEEN));
        temp.add(new selectOption('17',Constants.CONST_SEVENTEEN));
        temp.add(new selectOption('18',Constants.CONST_EIGHTEEN));
        temp.add(new selectOption('19',Constants.CONST_NINETEEN));
        temp.add(new selectOption('20',Constants.CONST_TWENTY));
        temp.add(new selectOption('21',Constants.CONST_TWENTYONE));
        temp.add(new selectOption('22',Constants.CONST_TWENTYTWO));
        temp.add(new selectOption('23',Constants.CONST_TWENTYTHREE));
        temp.add(new selectOption('24',Constants.CONST_TWENTYFOUR));
        temp.add(new selectOption('25',Constants.CONST_TWENTYFIVE));
        temp.add(new selectOption('26',Constants.CONST_TWENTYSIX));
        temp.add(new selectOption('27',Constants.CONST_TWENTYSEVEN));
        temp.add(new selectOption('28',Constants.CONST_TWENTYEIGHT));
        temp.add(new selectOption('29',Constants.CONST_TWENTYNINE));
        temp.add(new selectOption('30',Constants.CONST_THIRTY));
        temp.add(new selectOption('31',Constants.CONST_THIRTYONE));
        temp.add(new selectOption('32',Constants.CONST_THIRTYTWO));
        temp.add(new selectOption('33',Constants.CONST_THIRTYTHREE));
        temp.add(new selectOption('34',Constants.CONST_THIRTYFOUR));
        temp.add(new selectOption('35',Constants.CONST_THIRTYFIVE));
        temp.add(new selectOption('36',Constants.CONST_THIRTYSIX));
        temp.add(new selectOption('37',Constants.CONST_THIRTYSEVEN));
        temp.add(new selectOption('38',Constants.CONST_THIRTYEIGHT));
        temp.add(new selectOption('39',Constants.CONST_THIRTYNINE));
        temp.add(new selectOption('40',Constants.CONST_FORTY));*/
        
        
        return temp;
    }
    
    public List<selectOption> getFrequencySecTime(){        
        List<selectoption> temp = new List<selectoption>();        
        /*temp.add(new selectOption('--None--','--None--'));*/
        temp.add(new selectOption('--None--','Sec'));
        //temp.add(new selectOption('ONE','AM'));
        //temp.add(new selectOption('TWO','PM'));
        temp.add(new selectOption('ZERO','0'));
        temp.add(new selectOption('ONE','1'));
        temp.add(new selectOption('TWO','2'));
        temp.add(new selectOption('THREE','3'));
        temp.add(new selectOption('FOUR','4'));
        temp.add(new selectOption('THREE','3'));
        temp.add(new selectOption('FIVE','5'));
        temp.add(new selectOption('SIX','6'));
        temp.add(new selectOption('SEVEN','7'));
        temp.add(new selectOption('EIGHT','8'));
        temp.add(new selectOption('NINE','9'));
        temp.add(new selectOption('TEN','10'));
        temp.add(new selectOption('ELEVEN','11'));
        temp.add(new selectOption('TWELVE','12'));
        temp.add(new selectOption('THIRTEEN','13'));
        temp.add(new selectOption('FOURTEEN','14'));
        temp.add(new selectOption('FIFTEEN','15'));
        temp.add(new selectOption('SIXTEEN','16'));
        temp.add(new selectOption('SEVENTEEN','17'));
        temp.add(new selectOption('EIGHTEEN','18'));
        temp.add(new selectOption('NINETEEN','19'));
        temp.add(new selectOption('TWENTY','20'));
        temp.add(new selectOption('TWENTYONE','21'));
        temp.add(new selectOption('TWENTYTWO','22'));
        temp.add(new selectOption('TWENTYTHREE','23'));
        temp.add(new selectOption('TWENTYFOUR','24'));
        temp.add(new selectOption('TWENTYFIVE','25'));
        temp.add(new selectOption('TWENTYSIX','26'));
        temp.add(new selectOption('TWENTYSEVEN','27'));
        temp.add(new selectOption('TWENTYEIGHT','28'));
        temp.add(new selectOption('TWENTYNINE','29'));
        temp.add(new selectOption('THIRTY','30'));
        temp.add(new selectOption('THIRTY','31'));
        temp.add(new selectOption('THIRTY','32'));
        temp.add(new selectOption('THIRTY','33'));
        temp.add(new selectOption('THIRTY','34'));
        temp.add(new selectOption('THIRTY','35'));
        temp.add(new selectOption('THIRTY','36'));
        temp.add(new selectOption('THIRTY','37'));
        temp.add(new selectOption('THIRTY','38'));
        temp.add(new selectOption('THIRTY','39'));
        temp.add(new selectOption('THIRTY','40'));
        temp.add(new selectOption('THIRTY','41'));
        temp.add(new selectOption('THIRTY','42'));
        temp.add(new selectOption('THIRTY','43'));
        temp.add(new selectOption('THIRTY','44'));
        temp.add(new selectOption('THIRTY','45'));
        temp.add(new selectOption('THIRTY','46'));
        temp.add(new selectOption('THIRTY','47'));
        temp.add(new selectOption('THIRTY','48'));
        temp.add(new selectOption('THIRTY','49'));
        temp.add(new selectOption('THIRTY','50'));
        temp.add(new selectOption('THIRTY','51'));
        temp.add(new selectOption('THIRTY','52'));
        temp.add(new selectOption('THIRTY','53'));
        temp.add(new selectOption('THIRTY','54'));
        temp.add(new selectOption('THIRTY','55'));
        temp.add(new selectOption('THIRTY','56'));
        temp.add(new selectOption('THIRTY','57'));
        temp.add(new selectOption('THIRTY','58'));
        temp.add(new selectOption('THIRTY','59'));
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
        
        if(selectedTimeWindow=='1'){
            showWeeks = true;
            showMonths = false;
        }
        if(selectedTimeWindow=='2'){
            showWeeks = false;
            showMonths = true;
        }
    }
    public PageReference CustomSchedule(){        
        try{
            List<All_Scheduled_Jobs__c> schJobs = new List<All_Scheduled_Jobs__c>();        
            Type t = Type.forName(SelectedApexClass);                      
            Schedulable sch = (Schedulable)t.newInstance();
            //if(SelectedSchFre=='2'){
                if(selectedTimeWindow== '1' && strDate<>null && endDate<>null && SelectedTime<>'--None--'){
                    string a = '';
                   
                    if(SelectedFreqValue.size() >0)
                        a = SelectedFreqValue.get(0)+ '-' + SelectedFreqValue.get(SelectedFreqValue.size()- 1);
                    else
                        a = SelectedFreqValue.get(0);
                        
                    Date StartDate  = strDate;
                    Date EndDate = endDate; 
                    
                    Integer daysBetween = startDate.daysBetween(endDate);
                   
                    startDate  = startDate.addDays(-1);
                    //Integer Schdtime = Integer.valueOf(SelectedTime);
                    Integer Schdtime = Integer.valueOf(selH);
                    for(Integer i = 0 ;i < daysBetween ;i++){
                        for(String s : SelectedFreqValue){
                            Date newDate = startDate.addDays(i);
                            Datetime dt = datetime.newInstance(newDate.year(), newDate.month(),newDate.day());
                            String weekName = dt.format('EEEE'); 
                            if(weekName.substring(0,3).equalsIgnoreCase(s)) {
                                String timeStr = '0 0 '+Schdtime+' '+newDate.day() + ' ' + newDate.month()+' ? '+ newDate.year();
                                
                                System.schedule(jobName, timeStr, sch);
                                
                                //Creating Scheduled job records
                                All_Scheduled_Jobs__c str = new All_Scheduled_Jobs__c ();
                                str.Name = jobName+newDate;
                                str.Scheduled_Date__c  = newDate;
                                str.Submitted_By__c = UserInfo.getUserId();  
                                schJobs.add(str);                
                            }
                        }
                    }      
                    insert schJobs;
                }
                else if(selectedTimeWindow== '2' && strDate<>null && endDate<>null && SelectedTime<>'--None--' && (radioSel == '1' ||  radioSel == '2')){
                    String timeStr ='';
                    Integer Schdtime = Integer.valueOf(SelectedTime);  
                    Date StartDate  = strDate;
                    Date EndDate = endDate;               
                    Integer monthsBetween = startDate.monthsBetween(endDate);  
                    startDate  = startDate.addDays(-1); 
                     
                    if(radioSel == '1'){
                        for(Integer i = 0 ;i < monthsBetween ;i++){
                            Date newDate = startDate.addMonths(i);
                            
                            if(selectedDay<>'last'){                           
                                timeStr = '0 0 '+Schdtime+' '+selectedDay+ ' '+newDate.month()+' ? '+ newDate.year();
                            } 
                            else{
                                Date sDate = strDate.toStartOfMonth(); 
                                Date eDate = sDate.addMonths(1).addDays(-1);
                                timeStr = '0 0 '+Schdtime+' '+eDate.day()+ ' '+newDate.month()+' ? '+ newDate.year();    
                            } 
                            
                            All_Scheduled_Jobs__c str = new All_Scheduled_Jobs__c ();
                            str.Name = jobName+newDate;
                            str.Scheduled_Date__c  = newDate;
                            str.Submitted_By__c = UserInfo.getUserId();  
                            schJobs.add(str);   
                            System.schedule(jobName+newDate, timeStr, sch);
                        }                       
                    }
                    else if(radioSel == '2'){                    
                        if(selectedWeekOfMonth<>'last'){                           
                            timeStr = '0 0 '+Schdtime+' ? * '+selectedDayOfWeek+'#'+selectedWeekOfMonth;
                        } 
                        else{                               
                            timeStr = '0 0 '+Schdtime+' ? * '+selectedDayOfWeek+'L';                          
                        } 
                       
                        //System.schedule(jobName+Schdtime, timeStr, sch);
                        BatchSchedule bs = new BatchSchedule(timeStr,SelectedApexClass);
                        All_Scheduled_Jobs__c str = new All_Scheduled_Jobs__c ();
                        str.Name = jobName+Schdtime;
                        str.Scheduled_Date__c  = system.toDay();
                        str.Submitted_By__c = UserInfo.getUserId();  
                        schJobs.add(str);
                     }                    
                     insert schJobs;
                 }
           /*
           }
           else if(SelectedSchFre=='1'){
                String hour = String.valueOf(Datetime.now().hour());                
                Integer nowInMinute = Datetime.now().minute()+Integer.valueOf(SelectedMinutes);                
                String min = String.valueOf(nowInMinute); 
                String ss = String.valueOf(Datetime.now().second());
                String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';              
                try{
                    System.schedule(jobName + String.valueOf(Datetime.now()), nextFireTime, sch);
                    All_Scheduled_Jobs__c str = new All_Scheduled_Jobs__c ();
                    str.Name = jobName;
                    str.Scheduled_Date__c  = myDate ;           
                    insert str;
                }catch(Exception e){
                
                }     
           }
          */
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,e.getMessage()));           
        }
         
        return null;     
    }
   
    
     public PageReference run(){        
        //Id batchJobId = Database.executeBatch(new CopyLoginHistory(), 200);
        Type t = Type.forName(SelectedApexClass); 
        DataBase.Batchable<sObject> sch = (Database.Batchable<sObject>)t.newInstance();
        //sch.execute(null);
        System.debug('...Debug...' + jobName);
        apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'Batch Class has been Queued ');
        apexpages.addmessage(msg);
         
        try{
            //System.scheduleBatch(sch,'job example', 1);
            database.executebatch(sch);
            //System.schedule(jobName + String.valueOf(Datetime.now()), nextFireTime, sch);
            All_Scheduled_Jobs__c str = new All_Scheduled_Jobs__c ();
            str.Name = jobName;
            str.Scheduled_Date__c  = myDate ;           
            insert str;
        }catch(Exception e){
            system.debug(e.getMessage());
        }        
        return null;
    }
     
}