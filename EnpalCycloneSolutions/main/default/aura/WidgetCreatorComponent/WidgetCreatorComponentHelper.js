({
    nestingValidator : function(value){
        
        // key value pair of matching brackets
        var openBracks = {
            "{": "}",
            "(": ")",
            "[": "]"
        }
        //List of closing brackets
        var closedBracks = ["}", ")", "]"]
        
        //Array of chars
        var charStack = [];
        
        //Iterate over the Widget value input
        for (var i =0; i < value.length; i++) {
            if (openBracks.hasOwnProperty(value[i])) {
                charStack.push(value[i])
            } else if (openBracks[charStack[charStack.length -1]] == value[i]) {
                charStack.pop()
            } else if (closedBracks.indexOf(value[i]) !== -1) {
                return false
            }
        }
        console.log(charStack.length);
        // if length is zero then its nested
        if(charStack.length > 0){
            return false;
        } else{
            return true; 
        }
    },
    
    successToast : function(component,helper){
        
        console.log('Helper Success Toast');
        var showToast = $A.get('e.force:showToast');
        showToast.setParams({
            "title":"Record Saved",
            "type":"Success",
            "message":"Widget record has been created successfully"
        });
        showToast.fire();
    },
    
    errorToast : function(component,helper){
        
        console.log('Helper Error Toast');
        var showToast = $A.get('e.force:showToast');
        showToast.setParams({
            "title":"Nesting Error",
            "type":"Error",
            "message":"Widget record cannot be created as the value is not nested"
        });
        showToast.fire();
    }
})