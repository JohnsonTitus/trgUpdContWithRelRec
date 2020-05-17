trigger trgUpdContbsdPrnt on Contact (before insert) {

    //Create a Map of State that maps Postal code to Id
    Map<String,Id> mapState = new Map<String,Id>();
  
    for(State__c s : [select Postal__c, id  from State__c]){
        mapState.put(s.Postal__c, s.id);
    }

    List<Contact> ctToUpdate = new List<Contact>();
    //if found then update the Contact's State with that State's id
    for(Contact ct : Trigger.new){
        if(ct.PostalCode__c){
            Id stId = mapState.get(ct.PostalCode__c);
                if(stId != null){
                    ct.State__c= stId;
                    ctToUpdate.add(ct);
                }
        }
    }
    update ctToUpdate;
}