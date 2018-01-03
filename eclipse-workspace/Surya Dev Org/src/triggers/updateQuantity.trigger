trigger updateQuantity on OpportunityLineItem (after insert, after update, after Delete, after undelete) {
    set<id>accs = new set<id>();
    set<id>prods = new set<id>();
    List<OpportunityLineItem> items = !trigger.isdelete ? trigger.new : trigger.old;
   
    for(OpportunityLineItem li: [SELECT Id, Opportunity.AccountId, Product2Id FROM OpportunitylineItem WHERE ID IN: items]){
        accs.add(li.Opportunity.AccountId);
        prods.add(li.Product2Id);
    }
        
  

}