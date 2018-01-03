global class CopyLoginHistory implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<LoginHistory> loginHistories = [SELECT ApiType,
                                                    ApiVersion,
                                                    Application,
                                                    Browser,
                                                    ClientVersion,
                                                    Id,
                                                    LoginTime,
                                                    LoginType,
                                                    LoginUrl,
                                                    Platform,
                                                    SourceIp,
                                                    Status,
                                                    UserId
                                            FROM LoginHistory
                                            WHERE LoginTime <: System.now()
                                            ];
        if ( !loginHistories.isEmpty()) {
            List<LoginHistoryCopy__c> lhc = new List<LoginHistoryCopy__c>();
            for (LoginHistory a: loginHistories) {
                lhc.add(new LoginHistoryCopy__c(
                                               //ApiType__c       = ApiType ,
                                                //ApiVersion__c    = ApiVersion ,
                                                //Application__c   = Application ,
                                                //Browser__c       = Browser ,
                                                //ClientVersion__c = ClientVersion ,
                                                 Id__c            = a.Id,
                                                LoginTime__c     = a.LoginTime,
                                                //LoginType__c     = LoginType ,
                                                LoginUrl__c      = a.LoginUrl
                                                //Platform__c      = Platform ,
                                                //SourceIp__c      = SourceIp ,
                                                //Status__c        = Status ,
                                             //   UserId__c        = 134
                ));
            }
            insert lhc;
        }
   }
}