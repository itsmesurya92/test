global class BatchSchedule implements Schedulable{    
    String strTime; 
    String SelectedApexClass;
    
    public BatchSchedule(){
    
    }
    
    public BatchSchedule(String timeStr,String className){
        strTime = timeStr;  
        SelectedApexClass = className;
        scheduleMe();
    }
    
    global void scheduleMe() {
        BatchSchedule SC = new BatchSchedule(); 
        System.schedule('My batch Job', strTime, SC);
    }

    global void execute(SchedulableContext sc) {
        Type t = Type.forName(SelectedApexClass); 
        DataBase.Batchable<sObject> sch = (Database.Batchable<sObject>)t.newInstance();        
        ID batchprocessid = Database.executeBatch(sch,100);           
    }
}