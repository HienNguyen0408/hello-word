public class Chatbot_Helper {
    public static Map<String, List<BusinessHours>> getMapBusinessHour() {
        Map<String, List<BusinessHours>> mapBH = new Map<String, List<BusinessHours>>();
        List<String> lstBusinessHourTBLJP = Label.BUSINESS_HOUR_TBL_JP.split(',');
        
        List<BusinessHours> lstBH = [SELECT Id, Name, MondayStartTime, MondayEndTime, IsActive FROM BusinessHours WHERE IsActive = true];

        if(!lstBH.isEmpty()) {
            for(BusinessHours bh : lstBH) {
                if(bh.Name == Label.TECH_TIMBERLAND_JP_BUSINESS_HOUR_NAME) {
                    if(!mapBH.containsKey(Label.TECH_TBL_JP_EXTERNAL_SITE_ID)) {
                        mapBH.put(Label.TECH_TBL_JP_EXTERNAL_SITE_ID, new List<BusinessHours>());
                    }
                    mapBH.get(Label.TECH_TBL_JP_EXTERNAL_SITE_ID).Add(bh);
                } else if (bh.Name == Label.TECH_VNS_JP_BUSINESS_HOUR_NAME) { 
                    if(!mapBH.containsKey(Label.TECH_VNS_JP_EXTERNAL_SITE_ID)) {
                        mapBH.put(Label.TECH_VNS_JP_EXTERNAL_SITE_ID, new List<BusinessHours>());
                    }
                    mapBH.get(Label.TECH_VNS_JP_EXTERNAL_SITE_ID).Add(bh);
                } else {
                    if(!mapBH.containsKey(Label.DKS_JP_EXTERNAL_SITE_ID)) {
                        mapBH.put(Label.DKS_JP_EXTERNAL_SITE_ID, new List<BusinessHours>());
                    }
                    mapBH.get(Label.DKS_JP_EXTERNAL_SITE_ID).Add(bh);
                }
            }
        }

        return mapBH;
    }

    public static LiveChatTranscript getTranscriptRecord(Id routableID) {
        LiveChatTranscript transcriptRecord = LiveChatTranscriptSelector.GetLiveChatTranscriptById(routableID);
        return transcriptRecord;
    }
}