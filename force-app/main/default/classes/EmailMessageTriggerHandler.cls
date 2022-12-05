/*------------------------------------------------------------
+Author:        Duy Huynh
Company:        Merkle
Description:    
Test Class:     EmailMessageTriggerHandler_Test
History
<Date>          <Authors Name>          <Brief Description of Change>
2022/12/02        Duy Huynh         	    Init
------------------------------------------------------------*/
public without sharing class EmailMessageTriggerHandler extends TriggerHandler{
    public EmailMessageTriggerHandler(){}

    public override void afterInsert() {
        setLastModifiedBy();
    }

    public static void setLastModifiedBy () {
        try {
            List<Id> listCaseId = new List<Id>();
            List<Case> listCaseUpdating = new List<Case>();
            String userId = UserInfo.getUserId();
            List<User> listUser = new List<User>();

            listUser = UserSelector.getListUserByIds(userId);

            for(EmailMessage em : ((List<EmailMessage>)Trigger.New)) {
                if(em.Incoming == true) {
                    CheckRecursive.isUpdatedCase = true;
                }
                listCaseId.Add(em.ParentId);
            }

            listCaseUpdating = CaseSelector.getListCaseByIds(listCaseId);

            if(listCaseUpdating != null) {
                if(!listCaseUpdating.isEmpty()) {
                    for(Case tmpCase: listCaseUpdating) {
                        if(CheckRecursive.isUpdatedCase == false) {
                            tmpCase.Last_Modified_By__c = listUser[0].LastName + ' ' + listUser[0].FirstName;
                        }else{
                            tmpCase.Last_Modified_By__c = Label.CUSTOMER_LABEL; 
                        }
                        tmpCase.Last_Modified_Date__c = System.now();
                    }
                    update listCaseUpdating;
                }
            }
        } catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
}