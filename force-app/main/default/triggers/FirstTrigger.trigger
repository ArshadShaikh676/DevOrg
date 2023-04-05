// A) Write a trigger on Account object to make some fields mandatory.  
// B) write a trigger for Account object to prevent the deletion of Active  Account.


trigger FirstTrigger on Account (before insert, before update , before delete) {
    
    // A)
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
        for(Account acc : trigger.new) {
            if(acc.Industry=='' || acc.Industry== null)
            {
                acc.Industry.addError('please select the industry of an Account');
            }
            else if (acc.Rating=='' || acc.Rating== null)
            {
                acc.Rating.addError('please select the Rating of an Account');
            }
            else if (acc.phone=='' || acc.phone== null)
            {
                acc.phone.addError('please proide the phone of an Account');
            }
        }
    if(trigger.isBefore && trigger.isDelete)
        for(Account acc : trigger.old) {
            if(acc.Active__c == 'Yes')
            {
                acc.Active__c.addError('You are not authorized to delete an active Account');
            }
        }
    
}