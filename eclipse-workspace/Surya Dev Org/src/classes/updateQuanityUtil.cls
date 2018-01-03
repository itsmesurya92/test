public class updateQuanityUtil {
    
    public void updateQuantities(set<id> accIds, set<id> prdIds){
        Map<id, Account> accMap = new Map<Id, Account>([SELECT id, Purchased_Products__c FROM Account WHERE Id IN: accIds]);
        Map<id,Product2> prdMap = new map<Id, Product2>([SELECT Id, Sold_Quantity__c FROM Product2 WHERE ID IN: prdIds]);
        
        for(AggregateResult Ar: [SELECT Count(Id), opportunity.AccountId FROM OpportunityLineitem WHERE opportunity.AccountId IN: AcciDs Group By Opportunity.AccountId]){
			//Account ac = accMap.get(Ar.get('opportunity.AccountId')).Id;
           // ac.Purchased_Products__c = integer.ValueOf(String.ValueOf(ar.get('expr0')));
        }
        
    }

}