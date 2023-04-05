// Write a trigger on Case object to show the error , If Case is not associated with Accoun&Contact. 

trigger FirstTriggerOnCase on Case ( before insert , before update) {
    if( trigger.isBefore && ( trigger.isInsert || trigger.isUpdate) )
        for( Case ca : trigger.new ) {
            if( ca.AccountId == '' || ca.AccountId == null)
            {
             ca.AccountId.addError('Please provide the association between Case and Account');   
            }
            else if( ca.ContactId == '' || ca.ContactId == null )
            {
                ca.ContactId.addError('Please provide the association between Case and Contact');
            }
        }

}