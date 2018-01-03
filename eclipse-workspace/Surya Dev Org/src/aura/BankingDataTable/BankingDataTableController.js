({
    
    myfunc: function(component, event, helper) {      
        // Fetch the account list from the Apex controller   
        var action = component.get('c.getAccountInfo');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.bankAccInfo', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
       },
    myfunc1: function(component, event, helper) {      
        // Fetch the account list from the Apex controller
        console.log('***Check');
        var action = component.get('c.getTransactionInfo');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.bankTransactionInfo', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
       },
    myfunc2: function(component, event, helper) {      
        // Fetch the account list from the Apex controller   
        var action = component.get('c.getLoanInfo');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.bankLoanInfo', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
       } ,   
	myfunc3: function(component, event, helper) {      
        // Fetch the account list from the Apex controller   
        var action = component.get('c.getCreditInfo');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.bankCreditInfo', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
       }
       
    
    
})