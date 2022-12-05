/*------------------------------------------------------------
Author:        Duy Huynh
Company:       Merkle
Description:   A utility class for getting data from Case Object
Test Class:    N/A
History
<Date>      <Authors Name>     <Brief Description of Change>
2022/12/02     Duy Huynh        Init
------------------------------------------------------------*/
public without sharing class CaseSelector {
    public static List<Case> getListCaseByIds(List<Id> listCaseId){
        List<Case> listCaseUpdating = new List<Case>();

        listCaseUpdating = [select Last_Modified_By__c, Last_Modified_Date__c
                            from Case 
                            where Id IN :listCaseId];
        if(!listCaseUpdating.isEmpty()) {
            return listCaseUpdating;
        }
        return null;
    }
}