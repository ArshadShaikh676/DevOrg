// This line declares a trigger called "OppConAccPhoneField" that runs on the Opportunity object after a record is updated.
trigger UpdatePhoneOnRelatedAccountAndContactRecords on Opportunity (After Update) {
    
    //This creates a new Map to hold the IDs of the related Accounts and their corresponding Phone numbers.
      Map<Id,string> mapOfAccountpHone=new Map<Id,String>();  
      
      //This is a loop that iterates over all the Opportunities in the Trigger.new list (i.e., the updated Opportunities).
      for(Opportunity opp : Trigger.new) {
          
        //This checks whether the Phone field on the current Opportunity record has been updated. If it has been updated, 
        //the block of code inside the if statement will be executed.
        if(opp.Phone__c != Trigger.oldMap.get(opp.Id).Phone__c){
            
            //This is a debug statement that will display the old and new values of the Phone field in the debug log.
            system.debug(Trigger.oldMap.get(opp.Id).Phone__c+'in update '+opp.Phone__c);
            
              //This adds the Account ID and the updated Phone number to the mapOfAccountpHone map.
              mapOfAccountpHone.put(opp.AccountId,opp.Phone__c);
           }
        }
       
              //This query retrieves a list of Account records whose IDs are in the keySet of the mapOfAccountpHone map.  
              List<Account> AccList = [Select Id,name,Phone from Account where Id IN:mapOfAccountpHone.keySet()];
      
            //This creates a new List to hold the updated Account records.  
            List<Account> AccNewList=new List<Account>();
    
        //This checks whether there are any Account records to update.  
        if(AccList.size()>0){
        
    //This loop iterates over the list of Account records and updates their Phone fields with the corresponding value from 
    //the mapOfAccountpHone map. The updated records are then added to the AccNewList and updated in the database.
    for(Account acc:AccList){
        acc.Phone=mapOfAccountpHone.get(acc.id);
        AccNewList.add(acc);
        }
        Update AccNewList;
    }
      
        //This query retrieves a list of Contact records whose Account IDs are in the keySet of the mapOfAccountpHone map.  
        List<contact> conList=[Select id,accountid,phone from Contact where accountid IN: mapOfAccountpHone.keySet()];
      
            //This creates a new List to hold the updated Contact records.  
            List<Contact> oppConNewList=new List<Contact>();
      
              //This loop iterates over the list of Contact records and updates their Phone fields with the corresponding value from the 
              //mapOfAccountpHone map. The updated records are then added to the oppConNewList and updated in the database.  
              if(conList.size()>0){
              for(Contact con:conList){
                 con.Phone=mapOfAccountpHone.get(con.accountid);
                 oppConNewList.add(con);
           }
                 Update oppConNewList;
           }
}