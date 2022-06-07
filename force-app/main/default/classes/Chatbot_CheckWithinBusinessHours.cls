public class Chatbot_CheckWithinBusinessHours {
	public class TranscriptInput {
        @InvocableVariable(required=true)
        public ID routableID;
    }
    
    @InvocableMethod(label = 'Within Business Hours Check')
    public static List<Boolean> isWithInBusinessHours(List<TranscriptInput> transcripts) {
        TranscriptInput transcriptInput = transcripts[0];
        LiveChatTranscript transcriptRecord = Chatbot_Helper.getTranscriptRecord(transcriptInput.routableID);
        Map<String, List<BusinessHours>> mBusinessHour = new Map<String, List<BusinessHours>>();
        Datetime targetTime = transcriptRecord.CreatedDate;
        Boolean isWithin = false;
        String transcriptSiteId = String.isNotBlank(transcriptRecord.External_Site_Id__c) ? transcriptRecord.External_Site_Id__c : '';
        mBusinessHour = Chatbot_Helper.getMapBusinessHour(); //Map<SiteId, List<BusinessHours>>

        if(mBusinessHour.containsKey(transcriptSiteId)) {
            for(BusinessHours tmpBH : mBusinessHour.get(transcriptSiteId)) {
                if(tmpBH.Name == Label.TECH_TIMBERLAND_JP_BUSINESS_HOUR_NAME) {
                    isWithin = BusinessHours.isWithin(tmpBH.Id, targetTime);
                }
            }
        }
        
        return new List<Boolean>{isWithin};
    }
}