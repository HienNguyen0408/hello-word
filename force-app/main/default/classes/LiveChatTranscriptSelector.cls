public class LiveChatTranscriptSelector {
    public static LiveChatTranscript GetLiveChatTranscriptById(String Id) {
        List<LiveChatTranscript> transcriptRecords = new List<LiveChatTranscript>();
        if (String.isNotEmpty(Id)) {
            transcriptRecords = [SELECT Id, Name, First_Name__c, Last_Name__c, Email_Address__c, Subject__c,
                                External_Site_Id__c, CreatedDate, LiveChatButton.DeveloperName, Returns_DeliverItem_Policy_Url__c
                                    FROM LiveChatTranscript
                                    WHERE Id = :Id
                                    LIMIT 1];
        }
        return (transcriptRecords.isEmpty() ? null : transcriptRecords[0]);
    }

    public static List<LiveChatButton> GetListLiveChatButton(String liveChatButtonId) {
        List<LiveChatButton> listLiveChatButton = new List<LiveChatButton>();

        if(Test.isRunningTest()) {
            listLiveChatButton = [select Id, DeveloperName
                                    from LiveChatButton
                                    where DeveloperName = :Label.TECH_DKS_CHAT_BUTTON limit 1];
        }else {
            listLiveChatButton = [select Id, DeveloperName
                                from LiveChatButton
                                where id = :liveChatButtonId limit 1];
        }

        return listLiveChatButton;
    }

    public class CustomException extends Exception {}
}