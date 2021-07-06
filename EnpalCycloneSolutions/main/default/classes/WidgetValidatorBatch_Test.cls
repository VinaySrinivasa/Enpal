/* Name : WidgetValidatorBatch_Test
 * Purpose : Test Class for WidgetValidatorBatch
 * Author : Vinay Srinivasa
 * Date : 04/07/20201
 * Scope : Enpal - Technical Challenge
 **/
@isTest
public class WidgetValidatorBatch_Test {
        
    @isTest
    public static void validateNest(){
        List<Widget__c> widgList = new List<Widget__c>();
        Map<Integer,String> openBracsMap = new Map<Integer,String>();
        Map<Integer,String> closeBracsMap = new Map<Integer,String>();
        DateTime oneHourAgo = DateTime.Now().addMinutes(-30);
        
        for(integer i=1;i<=5;i++){
            openBracsMap.put(i,'{'+'('+'[');
            closeBracsMap.put(i,']'+')'+'}');
        }
        for(integer i=1;i<=5;i++){
            Widget__c wid1 = new Widget__c();
            wid1.Value__c = openBracsMap.get(i)+closeBracsMap.get(i);
            
            widgList.add(wid1);
        }
        for(integer i=1;i<=5;i++){
            
            Widget__c wid2 = new Widget__c();
            wid2.Value__c = openBracsMap.get(i)+closeBracsMap.get(i)+openBracsMap.get(i);
            
            widgList.add(wid2);
        }
        for(integer i=1;i<=5;i++){
            Widget__c wid3 = new Widget__c();
            wid3.Value__c = closeBracsMap.get(i)+openBracsMap.get(i);
            wid3.Is_Properly_Nested__c = True;
            
            widgList.add(wid3);
        }
    
        if(widgList.size()>0){
            insert widgList;
        }
        for(Widget__c wid:widgList){
            Test.setCreatedDate(wid.Id, oneHourAgo);
        }
        
        Test.startTest();
        WidgetValidatorBatchScheduler wsc = new WidgetValidatorBatchScheduler();      
        system.schedule('Hourly', '0 0 * * * ?', wsc);
        Test.stopTest();
        
        system.assert(NestingValidator.isProperlyNested(widgList.get(1).Value__c) == True, 'Value is nested');
        system.assert(NestingValidator.isProperlyNested(widgList.get(10).Value__c) == False, 'Value is not nested properly');
        
    }

}