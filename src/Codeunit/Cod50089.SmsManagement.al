codeunit 50089 "Sms Management"
{
    // Fuctions
    // 1. Send sms
    // 2. Create event subscriptions
    // 3. Create event responses
    // 4. Retry sms
    // 5. Validate prone number


    trigger OnRun()
    var
        "count": Integer;
    begin

        //SendSmsResponse('+254723214181', 'Tests sms from Nav00000');
    end;

    var
        //JSONTextWriter: DotNet JsonTextWriter;
     //   JSON: DotNet String;
      //  StringWriter: DotNet StringWriter;
      //  StringBuilder: DotNet StringBuilder;
        //lJsonArray: DotNet JArray;
        //lJObject: DotNet JObject;
        lArrayString: Text;
        lJSONString: Text;

    procedure ValidatePhoneNumber(PhoneNumber: Code[20])
    begin
    end;

    procedure AddPhoneNumber(PhoneNumber: Code[20]; Name: Text; Email: Text)
    begin
    end;

    procedure EditPhoneNumber(contactId: Guid; Email: Text; Name: Text; PhoneNumber: Code[20])
    begin
    end;

    procedure SendSmsResponses(phonenumber: Code[20]; sms: Text)
    var
        contacts: Record SMSContacts;
        apilogs: Record ApiLogs;
        smsEntry: Record "Sms Entry 2";
        send: Codeunit "Send sms 2";
    begin

        smsEntry.INIT;
        smsEntry."Phone Number" := phonenumber;
        smsEntry.Message := sms;
        smsEntry.Messageid := CREATEGUID;
        smsEntry."Message Date" := TODAY;
        smsEntry."Message Time" := TIME;
        smsEntry.INSERT(TRUE);

        TASKSCHEDULER.CREATETASK(CODEUNIT::"Send sms 2", CODEUNIT::"Sms Errors 2", true, COMPANYNAME, CURRENTDATETIME, smsEntry.RECORDID);

    end;


    procedure SendSmsWithID(Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL,LOAN_REMINDER,PIGGY_BANK,MEMBER_EXIT,ESS_REFUND,FIXED_DEPOSIT,BOD_HONORARIA,LOAN_RECOVERY,MEMBER_ALLOWANCES,DIVIDEND_PROCESSING; Telephone: Text[200]; Textsms: Text[1900]; Reference: Text[30]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean; RequestApplication: Text[30]; RequestCorrelationID: Text[50]; SourceApplication: Text[30]) Inserted: Boolean
    var
        EntryNo: Integer;
        SMSGuid: Guid;
        Category: Code[100];
        chargeSMS: Codeunit "Charge SMS";
        AUSMS: Record "AU SMS Messages";
        GeneralLedgerSetup: Record "Sacco General Set-Up";
        proceed: Boolean;
    begin
        if Chargeable then begin
            proceed := chargeSMS.FnCheckAccBal(AccNo, Telephone);
            if proceed then exit;
        end;
        
        EntryNo := EntryNo + 1;

        IF STRLEN(Telephone) = 13 THEN BEGIN
            Telephone := COPYSTR(Telephone, 2, 12);
        END;

        IF STRLEN(Telephone) = 10 THEN BEGIN
            IF COPYSTR(Telephone, 1, 1) = '0' THEN
                Telephone := '254' + COPYSTR(Telephone, 2, 9);
        END;

        IF STRLEN(Telephone) = 9 THEN BEGIN
            IF COPYSTR(Telephone, 1, 1) = '7' THEN
                Telephone := '254' + Telephone
        END;


        Category := FORMAT(Source);
        Priority := GetSMSPriority(Category);
        IF Priority = 0 THEN
            Priority := 250;

        Inserted := FALSE;

        GeneralLedgerSetup.GET;

        GeneralLedgerSetup.TESTFIELD("SMS Sender ID");
        GeneralLedgerSetup.TESTFIELD("SMS Sender Name");
        Inserted := FALSE;
        IF STRLEN(Telephone) = 12 THEN BEGIN


            AUSMS.INIT;
            AUSMS.originator_id := CREATEGUID;
            AUSMS.msg_id := 0;
            AUSMS.msg_product_id := 0;
            AUSMS.msg_provider_code := '0';
            AUSMS.msg_charge := '';
            AUSMS.msg_status_code := 10;
            AUSMS.msg_status_description := 'New MSG';
            AUSMS.msg_status_date := CURRENTDATETIME;
            AUSMS.sender := GeneralLedgerSetup."SMS Sender Name";
            AUSMS.receiver := Telephone;
            AUSMS.msg := Textsms;
            AUSMS.msg_type := 'MT';
            AUSMS.msg_source_reference := '';
            AUSMS.msg_destination_reference := '';
            AUSMS.msg_xml_data := '<OTHER_DETAILS/>';
            AUSMS.msg_category := Category;
            AUSMS.msg_priority := Priority;
            AUSMS.msg_product_id := 165;
            AUSMS.sender:='TELEPOST';
            AUSMS.msg_send_count := 0;
            AUSMS.schedule_msg := 'NO';
            AUSMS.date_scheduled := CURRENTDATETIME;
            AUSMS.msg_send_integrity_hash := '';
            //AUSMS.msg_response_date:=CURRENTDATETIME;
            //AUSMS.msg_response_xml_data:='';
            //AUSMS.msg_response_integrity_hash:='';
            AUSMS.transaction_date := CURRENTDATETIME;
            AUSMS.date_created := CURRENTDATETIME;
            AUSMS."SMS Date" := TODAY;
            
            IF Chargeable THEN begin
                if Source <> Source::CRM then begin
                    AUSMS."Account To Charge" := AccNo;
                    AUSMS."Insufficient Balance" := chargeSMS.RunChargeSMS(AccNo, Telephone);
                end;
            end;
            AUSMS.msg_request_application := RequestApplication;
            AUSMS.msg_request_correlation_id := RequestCorrelationID;
            AUSMS.msg_source_application := SourceApplication;

            AUSMS.transaction_id := 0;
            AUSMS.server_id := 0;
            AUSMS.msg_charge_applied := '';
            AUSMS.msg_format := 'TEXT';
            AUSMS.msg_command := 'BulkSMS';
            AUSMS.msg_sensitivity := 'NORMAL';
            AUSMS.msg_response_description := '';
            AUSMS.msg_result_description := '';
            AUSMS.msg_result_xml_data := '';
            AUSMS.msg_result_date := CURRENTDATETIME;
            AUSMS.msg_result_integrity_hash := '';
            AUSMS.msg_result_submit_count := 0;
            AUSMS.msg_result_submit_status := 'PENDING';
            AUSMS.msg_result_submit_description := '';
            AUSMS.msg_result_submit_date := CURRENTDATETIME;
            AUSMS.sender_type := 'SENDER_ID';
            AUSMS.receiver_type := 'MSISDN';
            AUSMS.msg_mode := 'SAF';
            IF Source = Source::MOBILE_PIN THEN BEGIN
                AUSMS.msg_general_flag := 'NOT_MASKED';
            END;
            AUSMS."Charge Member" := ChargeMember;

            AUSMS.INSERT;
            Inserted := TRUE;
        END;
    end;

    local procedure GetSMSPriority(Category: Text) Priority: Integer
    begin
        IF (Category = 'ATM_COLLECTION') THEN
            Priority := 211
        ELSE IF (Category = 'B2B_WITHDRAWAL') THEN
            Priority := 211
        ELSE IF (Category = 'CASH_WITHDRAWAL_CONFIRM') THEN
            Priority := 211
        ELSE IF (Category = 'DEPOSIT_CONFIRMATION') THEN
            Priority := 220
        ELSE IF (Category = 'FIXED_DEPOSIT_MATURITY') THEN
            Priority := 240
        ELSE IF (Category = 'LOAN_APPLICATION') THEN
            Priority := 230
        ELSE IF (Category = 'LOAN_DEFAULTED') THEN
            Priority := 240
        ELSE IF (Category = 'LOAN_GUARANTORS') THEN
            Priority := 240
        ELSE IF (Category = 'LOAN_POSTED') THEN
            Priority := 240
        ELSE IF (Category = 'LOW_FLOAT_ALERT') THEN
            Priority := 203
        ELSE IF (Category = 'LOW_FLOAT_INFO') THEN
            Priority := 202
        ELSE IF (Category = 'LOW_FLOAT_MIN') THEN
            Priority := 200
        ELSE IF (Category = 'LOW_FLOAT_WARNING') THEN
            Priority := 204
        ELSE IF (Category = 'MAPP_ACTIVATION') THEN
            Priority := 200
        ELSE IF (Category = 'MAPP_DEACTIVATION') THEN
            Priority := 205
        ELSE IF (Category = 'MBANKING') THEN
            Priority := 220
        ELSE IF (Category = 'MEMBER_CHANGES') THEN
            Priority := 240
        ELSE IF (Category = 'BULK') THEN
            Priority := 240
        ELSE IF (Category = 'MOBILE_PIN') THEN
            Priority := 208
        ELSE IF (Category = 'NEW_ACCOUNT') THEN
            Priority := 230
        ELSE IF (Category = 'NEW_MEMBER') THEN
            Priority := 230
        ELSE IF (Category = 'ONE_TIME_PASSWORD') THEN
            Priority := 200
        ELSE IF (Category = 'MOBILE_PIN') THEN
            Priority := 200
        ELSE IF (Category = 'SALARY_PROCESSING') THEN
            Priority := 245
        ELSE IF (Category = 'MEMBER_ALLOWANCES') THEN
            Priority := 245
        ELSE IF (Category = 'WITHDRAWAL') THEN
            Priority := 214
        ELSE IF (Category = 'LOAN_ACCOUNT_APPROVAL') THEN
            Priority := 245
        ELSE IF (Category = 'LOAN_APPRAISAL') THEN
            Priority := 230
        ELSE IF (Category = 'LOAN_REJECTED') THEN
            Priority := 225
        ELSE IF (Category = 'TELLER_CASH_DEPOSIT') THEN
            Priority := 215
        ELSE IF (Category = 'TELLER_CAS') THEN
            Priority := 225
        ELSE IF (Category = 'LOAN_REMINDER') THEN
            Priority := 240
        ELSE IF (Category = 'LOAN_RECOVERY') THEN
            Priority := 240
        ELSE IF (Category = 'ESS_REFUND') THEN
            Priority := 240
        ELSE IF (Category = 'BOD_HONORARIA') THEN
            Priority := 225
        ELSE
            Priority := 250;
    end;

    procedure PostRequest(variables: Text; apilink: Text; method: Text) ResponseData: Text
    var
        //  Request: DotNet HttpWebRequest;
        //   WebResponse: DotNet HttpWebResponse;
        //  StreamReader: DotNet StreamReader;
        //  salesshipment: Record "Sales Shipment Header";
       // StreamWriter: DotNet StreamWriter;
        httpWebRequest: Codeunit "Http Web Request Mgt.";
        DimensionValue: Record "Dimension Value";
        url: Text;
        param: Text;
        Rest: Codeunit "REST Helper WLD";

        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        contentHeaders: HttpHeaders;
    begin

        url := apilink;
        IF method = 'POST' then BEGIN
            RequestHeaders := Client.DefaultRequestHeaders();
            RequestContent.WriteFrom(variables);
            RequestContent.GetHeaders(contentHeaders);
            contentHeaders.Clear();
            contentHeaders.Add('Content-type', 'application/json');

            Client.Post(url, RequestContent, ResponseMessage);
        END

        ELSE
            IF method = 'GET' THEN BEGIN

                client.Get(url, ResponseMessage);
            END;
        ResponseMessage.Content().ReadAs(ResponseText);
        ResponseData := ResponseText;

        //END;
        //MESSAGE('Depots added');
    end;

    procedure TestConnection(var smsSetup: Record "Sms Setup 2")
    var
       // JsonOut: DotNet String;
        returnout: Text;
        responseData: Text;

        JO: JsonObject;


    begin

        // Pass email and password to test connection
        // StringBuilder:=StringBuilder.StringBuilder;
        // StringWriter:=StringWriter.StringWriter(StringBuilder);
        // JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);

        // JSONTextWriter.WriteStartObject;
        // JSONTextWriter.WritePropertyName('email'); JSONTextWriter.WriteValue(LOWERCASE(smsSetup.Username));
        // JSONTextWriter.WritePropertyName('password'); JSONTextWriter.WriteValue(smsSetup.Password);

        //  JSONTextWriter.WriteEndObject;

        // JsonOut:=StringBuilder.ToString;
        // returnout:=JsonOut;

        jo.add('email', LOWERCASE(smsSetup.Username));
        jo.add('password', smsSetup.Password);

        //MESSAGE(returnout);
        jo.WriteTo(returnout);

        responseData := PostRequest(returnout, smsSetup."EndPoint link" + '/login', 'POST');

        //MESSAGE(responseData);

        // lJObject := lJObject.Parse(FORMAT(responseData));

        //  EVALUATE(smsSetup."User id", FORMAT(lJObject.GetValue('customerId')));

        smsSetup."User id" := smsSetup."User id";

        MESSAGE('Connection succesful, refresh balance to continue');
    end;

    procedure RefreshBalance(var smsSetup: Record "Sms Setup 2")
    var
        //JsonOut: DotNet String;
        returnout: Text;
        responseData: Text;
    begin
        /*
        // Pass email and password to test connection
        StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        
        JSONTextWriter.WriteStartObject;
        JSONTextWriter.WritePropertyName('email'); JSONTextWriter.WriteValue(LOWERCASE(smsSetup.Username));
        JSONTextWriter.WritePropertyName('password'); JSONTextWriter.WriteValue(smsSetup.Password);
        
        JSONTextWriter.WriteEndObject;
        
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        */
        //MESSAGE(returnout);

        // responseData := GetRequest(smsSetup."User id", smsSetup."EndPoint link" + '/summary', 'GET');

        responseData := PostRequest('', smsSetup."EndPoint link", 'GET');
        //MESSAGE(responseData);

        //lJObject := lJObject.Parse(FORMAT(responseData));



        //  EVALUATE(smsSetup."Sms balance", FORMAT(lJObject.GetValue('smsBalance')));
        //  EVALUATE(smsSetup."Price per sms", FORMAT(lJObject.GetValue('pricePerSms')));
        //  EVALUATE(smsSetup.Package, FORMAT(lJObject.GetValue('package')));
        smsSetup."User id" := smsSetup."User id";

        MESSAGE('Balance refreshed');

    end;

    procedure GetRequest(variables: Guid; apilink: Text; method: Text) ResponseData: Text
    var
        // Request: DotNet HttpWebRequest;
        // WebResponse: DotNet HttpWebResponse;
        // StreamReader: DotNet StreamReader;
        // salesshipment: Record "Sales Shipment Header";
        // StreamWriter: DotNet StreamWriter;
        httpWebRequest: Codeunit "Http Web Request Mgt.";
        DimensionValue: Record "Dimension Value";
        url: Text;
        param: Text;
    begin


        url := apilink;

        // param:=js.fnInsertDriver(code, driver);
        //MESSAGE(param);

        /*         Request := Request.HttpWebRequest.Create(url+'/'+FORMAT(variables));Kitui
                Request.Method := method;
                Request.ContentType := 'application/json';

                WebResponse := Request.GetResponse();

                StreamReader := StreamReader.StreamReader(WebResponse.GetResponseStream);
                ResponseData := StreamReader.ReadToEnd; */


        //END;
        //MESSAGE('Depots added');

    end;

    procedure FnSendsms(var SmsEntry: Record "Sms Entry 2")
    var
       // JsonOut: DotNet String;
        returnout: Text;
        responseData: Text;
        smsSetup: Record "Sms Setup 2";
        jobject: JsonObject;
    begin

        IF smsSetup.GET() THEN BEGIN

            jobject.add('smsId', Format(SmsEntry.Messageid).Replace('{', '').Replace('}', ''));
            jobject.add('sms', SmsEntry.Message);
            jobject.add('phoneNumbers', SmsEntry."Phone Number");
            jobject.add('customerId', Format(smsSetup."User id").Replace('{', '').Replace('}', ''));

            jobject.WriteTo(returnout);

            Message(returnout);
            responseData := PostRequest(returnout, smsSetup."EndPoint link" + '/message', 'POST');
            Message(responseData);

            IF responseData <> '' THEN BEGIN
                SmsEntry.Status := SmsEntry.Status::Success;
                SmsEntry.MODIFY;
            END;
        END;
    end;

    procedure SendSmsResponseTest(phonenumber: Code[20]; sms: Text)
    var
        contacts: Record SMSContacts;
        apilogs: Record ApiLogs;
        smsEntry: Record "Sms Entry 2";
        send: Codeunit "Send sms 2";
    begin

        smsEntry.INIT;
        smsEntry."Phone Number" := phonenumber;
        smsEntry.Message := sms;
        smsEntry.Messageid := CREATEGUID;
        smsEntry."Message Date" := TODAY;
        smsEntry."Message Time" := TIME;
        smsEntry.INSERT(TRUE);
        FnSendsms(smsEntry);
        TASKSCHEDULER.CREATETASK(CODEUNIT::"Send sms 2", CODEUNIT::"Sms Errors 2", TRUE, COMPANYNAME, CURRENTDATETIME, smsEntry.RECORDID);
    end;


}

