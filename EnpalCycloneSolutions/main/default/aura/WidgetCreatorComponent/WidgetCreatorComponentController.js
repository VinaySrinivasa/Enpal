({
    doInit: function(component, event, helper) {
        component.find("recLoader").set("v.recordId","{!$SObjectType.CurrentUser.Id}");
        // Prepare a new record from template
        component.find("recCreator").getNewRecord(
            "Widget__c", 
            null,      
            false,     
            $A.getCallback(function() {
                var rec = component.get("v.record");
                var error = component.get("v.recordError");
                if(error || (rec === null)) {
                    component.set("v.recordError",'There is an error.');
                    console.log("Error initializing " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.apiName);
            })
        );
    },
    
    handleSave: function (component, event, helper) {
        
        // Check if value is properly Nested
        var value = component.get("{!v.recordFields.Value__c}");
        var isNested = helper.nestingValidator(value);
        
        //Get User Profile Info
        var userProf = component.get("{!v.userRecFields.Profile.Name}");
        console.log('The User Profile is -->'+userProf);
        
        //If User is System admin or Widget Master --> Create Widget without validation
        if(userProf === 'System Administrator' || userProf === 'Widget Masters'){
            if(helper.nestingValidator(value)){
                component.set("v.recordFields.Is_Properly_Nested__c",true);
            }
            var creatWid = component.get('c.createWidget');
            $A.enqueueAction(creatWid);
            
        } //If other user --> check if value is nested and created Widget
        else{
            if(helper.nestingValidator(value)){
                component.set("v.recordFields.Is_Properly_Nested__c",true);
                
                var creatWid = component.get('c.createWidget');
                $A.enqueueAction(creatWid);
                
            //Show Error Toast message for Un-Nested Widget value
            }else {
                helper.errorToast(component,helper);
            }
        }
    },
    
    createWidget: function (component, event, helper){
        
        component.find("recCreator").saveRecord(function(saveResult){
            if(saveResult.state === 'SUCCESS' || saveResult.state === 'DRAFT'){
                
                console.log('The RecordId is --> '+saveResult.recordId);
                //Show success toast
                helper.successToast(component,helper);
                
                //Navigate to Record detail page
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": saveResult.recordId,
                    "slideDevName": "detail"
                });
                navEvt.fire();
            }else{
                component.set("v.recordError",'There is an Error.');
            }
        });
    }
})