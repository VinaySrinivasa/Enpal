/* Name : WidgetValidatorBatchScheduler
 * Purpose : Scheduler class to for WidgetValidatorBatch class
 * Author : Vinay Srinivasa
 * Date : 04/07/20201
 * Scope : Enpal - Technical Challenge
 **/

public class WidgetValidatorBatchScheduler implements Schedulable{
    
    public void execute(SchedulableContext sc) {
      WidgetValidatorBatch bc = new WidgetValidatorBatch(); 
      database.executebatch(bc);
   }

}