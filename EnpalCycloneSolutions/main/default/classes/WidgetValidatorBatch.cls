/* Name : WidgetValidatorBatch
 * Purpose : Batch class to check if Widget records are proprly nested
 * Author : Vinay Srinivasa
 * Date : 04/07/20201
 * Scope : Enpal - Technical Challenge
 **/

public class WidgetValidatorBatch implements database.batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        
        // collect all Widgets created in last 1 hour for Nesting validation
        DateTime oneHourAgo = DateTime.Now().addHours(-1);
        return Database.getQueryLocator([SELECT Id, Name, Value__c, is_Properly_Nested__c, OwnerId FROM Widget__c WHERE CreatedDate >= :oneHourAgo]);
    }
     
    public void execute(Database.BatchableContext BC, List<Widget__c> widgList) {
        
        // process each batch of Widgets created - default batch size is 200
        if(widgList.size()>0){
            
            List<Widget__c> widgUpdateList = new List<Widget__c>();
            List < Messaging.SingleEmailMessage > emailList = new List < Messaging.SingleEmailMessage > ();
            Boolean isNested;
            
            //validate each widget if properly nested
            for(Widget__c wid : widgList) {
                //checking is value is properly nested through NestingValidator
                isNested = NestingValidator.isProperlyNested(wid.value__c);
                
                if(isNested!= Null && isNested == True){ //Widget is properly nested
                    if(!wid.is_Properly_Nested__c){
                        wid.is_Properly_Nested__c = True;
                        widgUpdateList.add(wid);
                    }
                } 
                else {									// Widget is not properly nested
                    if(wid.is_Properly_Nested__c){
                        wid.is_Properly_Nested__c = False;
                        widgUpdateList.add(wid);
                    }
                    
                    //fetch the Email template ID
                    EmailTemplate etemp = [SELECT Id from EmailTemplate Where Name = 'UnNestedWidgetOwnerCommunication'];
                    
                    //prepare the email message to be sent to owner
                    Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(etemp.Id, wid.OwnerId, wid.Id);
                    
                    String emailSubject = email.getSubject();
                    String emailTextBody = email.getPlainTextBody();
                    
                    email.setTargetObjectId(wid.OwnerId);
                    email.setSubject(emailSubject);
                    email.setPlainTextBody(emailTextBody);
                    email.saveAsActivity = false;
                    
                    emailList.add(email);
                }
                system.debug('The Widget value is --> '+wid.Value__c);
            }
            try {
                // Update the Widget Record
                if(widgUpdateList.size()>0){
                    system.debug('The no of widgets to update are -'+widgUpdateList.size());
                    update widgUpdateList;
                }
                
                //Send Emails for widgets not nested properly
                if(emailList.size()>0){
                    Messaging.sendEmail(emailList);
                }
                
            } catch(Exception ex) {
                System.debug(ex);
            }
        }
    }   
     
    public void finish(Database.BatchableContext BC) {
    }
}