/*------------------------------------------------------------
+Author:        Duy Huynh
Company:        Merkle
Description:    
Test Class:     CaseTriggerHandler_Test
History
<Date>          <Authors Name>          <Brief Description of Change>
2022/12/01        Duy Huynh         	    Init
------------------------------------------------------------*/
public class CaseTriggerHandler extends TriggerHandler {
    public CaseTriggerHandler(){}

    public override void beforeUpdate() {
        updateLastModified();
    }

    public static void updateLastModified () {
        System.System.debug('CheckRecusise: ' + CheckRecursive.isUpdatedCase);
        List<User> listUser = new List<User>();
        String caseId = '';
        List<Id> listCaseId = new List<Id>();
        List<Case> listExistingCase = new List<Case>();
        List<EmailMessage> listEmailMessage = new List<EmailMessage>();
        String userId = UserInfo.getUserId();

        for(Case tmpCase : (List<Case>)Trigger.New) {
            listCaseId.Add(tmpCase.Id);
        }
                            
        listUser = UserSelector.getListUserByIds(userId);

        if(listUser != null) {
            for(Case tmpCase : (List<Case>)Trigger.New) {
                if(CheckRecursive.isUpdatedCase == false) {
                    tmpCase.Last_Modified_Date__c = System.now();
                    tmpCase.Last_Modified_By__c = listUser[0].LastName + ' ' + listUser[0].FirstName;
                }
            }
        }
    }
}