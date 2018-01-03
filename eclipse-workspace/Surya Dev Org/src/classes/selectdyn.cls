public class selectdyn {
    public String[] values { get; set; }
    public SelectOption[] valueList { get; set; }
    public String opText{get;set;}
    public List<String> SelectedFreqValue {get;set;} 

    public selectdyn() {
        valueList = new SelectOption[0];
        values = new String[0];
        SelectedFreqValue  = new List<String>();
    }

    
    public void showOP(){
        opText = String.join(SelectedFreqValue , ',');    
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
 
    
    public PageReference CustomSchedule(){
        system.debug('===============');
        try{
            system.debug(SelectedFreqValue+'=====');
            opText = String.join(SelectedFreqValue , ',');
           
        }
        catch(Exception e){}
        //return null;   
        return null;     
    }
}