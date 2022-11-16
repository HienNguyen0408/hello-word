public class Chatbot_GetSetTranscriptValues {
    public class TranscriptInput {
        @InvocableVariable(required=true)
        public ID routableID;

        @InvocableVariable
        public String userMessage;

        @InvocableVariable
        public string emailAddress;
    }

    @InvocableMethod(label='Get User Information')
    public static void getUserInformation(List<TranscriptInput> transcripts) {
        Map<String, List<BusinessHours>> mBusinessHour = Chatbot_Helper.getMapBusinessHour(); //Map<SiteId, List<BusinessHours>>
        TranscriptInput transcriptInput = transcripts[0];
        System.debug('transcriptInput: ' + transcriptInput);
        Case caseObject = new Case();
        LiveChatTranscript transcriptRecord = LiveChatTranscriptSelector.GetLiveChatTranscriptById(transcriptInput.routableID);


        String transcriptSiteId = String.isNotBlank(transcriptRecord.External_Site_Id__c) ? transcriptRecord.External_Site_Id__c : '';
        String firstName = String.isNotBlank(transcriptRecord.First_Name__c) ? transcriptRecord.First_Name__c : '';
        String lastName = String.isNotBlank(transcriptRecord.Last_Name__c) ? transcriptRecord.Last_Name__c : '';
        String webEmail = String.isNotBlank(transcriptInput.emailAddress) ? transcriptInput.emailAddress : transcriptRecord.Email_Address__c;
        String webName = firstName + ' ' + lastName;
        String subject = String.isNotBlank(transcriptRecord.Subject__c) ? transcriptRecord.Subject__c : '';
        String caseRecordTypeId = '';

        if(transcriptRecord.LiveChatButton.DeveloperName == Label.TECH_DKS_CHAT_BUTTON) {
            transcriptSiteId = Label.DKS_JP_EXTERNAL_SITE_ID;
            caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(Label.TECH_DKS_LIVE_AGENT_RECORD_TYPE).getRecordTypeId();
        }else {
            caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(Label.TECH_LIVE_AGENT_RECORD_TYPE).getRecordTypeId();
        }

        if(mBusinessHour.containsKey(transcriptSiteId)) {
            for(BusinessHours tmpBH : mBusinessHour.get(transcriptSiteId)) {
                if(tmpBH.Name == Label.TECH_TIMBERLAND_JP_BUSINESS_HOUR_NAME || tmpBH.Name == Label.TECH_DKS_JP_BUSINESS_HOUR_NAME) {
                    caseObject.BusinessHoursId = tmpBH.Id;
                }
            }
        }

        caseObject.SuppliedName = webName;
        caseObject.SuppliedEmail = webEmail;
        System.debug('SuppliedEmail: ' + caseObject.SuppliedEmail);
        caseObject.RecordTypeId = caseRecordTypeId;
        caseObject.Description = String.isNotBlank(transcriptInput.userMessage) ? transcriptInput.userMessage : '';
        caseObject.Subject = subject;
        caseObject.Origin = Label.CASE_ORIGIN_WEB;

        insert caseObject;
        transcriptRecord.CaseId = caseObject.ID;
        update transcriptRecord;
    }
}