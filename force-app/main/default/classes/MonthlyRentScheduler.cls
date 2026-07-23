Global class MonthlyRentScheduler implements Schedulable{
    Global void execute(SchedulableContext sc){
        Database.executeBatch( new MonthlyRentBatch(), 200);
    }

}