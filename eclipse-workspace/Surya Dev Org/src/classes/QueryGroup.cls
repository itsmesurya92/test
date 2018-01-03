public class QueryGroup{
public static Map<ID,Set<ID>> GetUserIdsFromGroup(Set<Id> groupIds )
{
    // store the results in a Set we don't get duplicates
    Map<Id,Set<Id>> result=new Map<ID,Set<Id>>();
    String userType = Schema.SObjectType.User.getKeyPrefix();
    String groupType = Schema.SObjectType.Group.getKeyPrefix();
    Set<Id> groupIdProxys = new Set<Id>();
    // Loop through all group members in a group
    for(GroupMember m : [Select Id, UserOrGroupId, GroupID From GroupMember Where GroupId in :groupIds])
    {
        // If the user or group id is a user
        if(((String)m.UserOrGroupId).startsWith(userType))
        {
           // result.add(m.UserOrGroupId));
           if(result.containskey(m.GroupID))
           {
               Set<Id> tempId= result.get(m.GroupID);
               tempId.add(m.UserOrGroupId);
               result.put(m.GroupID,tempId);
           }
            else
            {
                 Set<Id> tempId= new Set<Id> ();
               tempId.add(m.UserOrGroupId);
               result.put(m.GroupID,tempId);
            }
           
        }
        // If the user or group id is a group
        // Note: there may be a problem with governor limits if this is called too many times
        else if (((String)m.UserOrGroupId).startsWith(groupType))
        {
            // Call this function again but pass in the group found within this group
            groupIdProxys.add(m.UserOrGroupId);
        }
    }
    if(groupIdProxys.size() > 0)
    {
        //result(GetUSerIdsFromGroup(groupIdProxys));
    }
    System.debug('**** result '+ result);
    return result;  
}
}