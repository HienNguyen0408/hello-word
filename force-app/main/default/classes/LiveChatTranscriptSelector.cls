public class LiveChatTranscriptSelector {
    public static LiveChatTranscript GetLiveChatTranscriptById(String Id) {
        List<LiveChatTranscript> transcriptRecords = new List<LiveChatTranscript>();
        if (String.isNotEmpty(Id)) {
            transcriptRecords = [SELECT Id, Name, First_Name__c, Last_Name__c, Email_Address__c, Subject__c,
                                External_Site_Id__c, CreatedDate
                                    FROM LiveChatTranscript
                                    WHERE Id = :Id
                                    LIMIT 1];
        }
        return (transcriptRecords.isEmpty() ? null : transcriptRecords[0]);
    }

    public class CustomException extends Exception {}
}