codeunit 50085 "ATM Engine"
{

    trigger OnRun()
    begin

    end;

    var
        Title: Label 'title';
        Message: Label 'response_status_description';
        Status: Label 'response_status';
        Data: Label 'data';
        BufferTable: Record "Mpesa Withdawal Buffer";
        MPESATRANS: Record "MOBILE MPESA Trans";
        Bname: Codeunit "Send Birthday SMS";
        LoansRegister: Record "Loans Register";
        PosCommision: Record "POS Commissions";
        VendorAccountNo: code[20];
        Cust: Record Customer;
        ReversalDescription: Text[500];
        SMSCodeunit: codeunit "Sms Management";
        Message2: text[200];
        MessagePresfix: text[200];
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL;

    // ################################################################################################
    // MAIN FUNCTIONS
    // ################################################################################################
    procedure ProcessRequest(Request: Text) Response: Text;
    var
        RequestJson: JsonObject;
        OutputJson: JsonObject;
        RequestDataJson: JsonObject;
        RequestAction: Text;
        RequestId: Text;
        SessionValid: Boolean;
    begin
        if not RequestJson.ReadFrom(Request) then
            Error('Invalid Json Input');

        RequestId := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;

        RequestDataJson := SelectJsonToken(RequestJson, '$.payload').AsObject();

        ValidateRequestHash(RequestJson);

        SessionValid := true;

        if not (RequestAction in ['login']) then begin
            SessionValid := ValidateUserSession(RequestJson);
        end;

        if SessionValid then begin
            case RequestAction of
                'get-member-details':
                    begin
                        OutputJson := GetMemberDetails(RequestDataJson);
                    end;
                'get-accounts':
                    begin
                        OutputJson := GetAccounts(RequestDataJson);
                    end;
                'balance-enquiry':
                    begin
                        OutputJson := BalanceEnquiry(RequestDataJson);
                    end;
                'statement-enquiry':
                    begin
                        OutputJson := StatementEnquiry(RequestDataJson);
                    end;
                'pesa-out-request':
                    begin
                        OutputJson := PESAOUTRequest(RequestDataJson);
                    end;
                'pesa-out-confirmation':
                    begin
                        OutputJson := PESAOUTConfirmation(RequestDataJson);
                    end;
                'internal-funds-transfer':
                    begin
                        OutputJson := InternalFundsTransfer(RequestDataJson);
                    end;
                'pesa-in-confirmation':
                    begin
                        OutputJson := PESAINConfirmation(RequestDataJson);
                    end;
                'get-loan-types':
                    begin
                        OutputJson := GetLoanTypes(RequestDataJson);
                    end;
                'check-loan-limit':
                    begin
                        OutputJson := CheckLoanLimit(RequestDataJson);
                    end;
                'loan-application':
                    begin
                        OutputJson := LoanApplication(RequestDataJson);
                    end;
                'get-outstanding-loans':
                    begin
                        OutputJson := GetOutstandingLoans(RequestDataJson);
                    end;
                'get-transaction-charges':
                    begin
                        OutputJson := GetTransactionCharges(RequestDataJson);
                    end;
                'virtual-member-registration':
                    begin
                        OutputJson := VirtualMemberRegistration(RequestDataJson);
                    end;
                'add-guarantor':
                    begin
                        OutputJson := AddGuarantors(RequestDataJson);
                    end;
                'remove-guarantor':
                    begin
                        OutputJson := RemoveGuarantors(RequestDataJson);
                    end;
                'get-pending-guarantorship-requests':
                    begin
                        OutputJson := GetPendingGuarantorshipRequest(RequestDataJson);
                    end;
                'accept-reject-guarantorship':
                    begin
                        OutputJson := AcceptRejectGuarantorship(RequestDataJson);
                    end;
                'get-loans-guaranteed':
                    begin
                        OutputJson := GetLoansGuaranteedByMember(RequestDataJson);
                    end;
                'get-loans-with-guarantors':
                    begin
                        OutputJson := GetLoanswithGuarantors(RequestDataJson);
                    end;
                'ATM_BALANCE_ENQUIRY':
                    begin
                        OutputJson := BalanceEnquiryATM(RequestDataJson);
                        Response := WrapResponse(RequestJson, OutputJson);
                    end;
                'ATM_FUNDS_TRANSFER':
                    begin
                        OutputJson := FundsTransferATM(RequestDataJson);
                        Response := WrapResponseFundsTransfer(RequestJson, OutputJson);
                    end;
                'ATM_MINI_STATEMENT':
                    begin
                        OutputJson := MiniStatementATM(RequestDataJson);
                        Response := WrapResponseMinistatement(RequestJson, OutputJson);
                    end;

            end;
        end
        else begin
            SetResponseStatus(OutputJson, 'error', '401 Unauthorized', 'Your request could not be processed');
        end;

        // Response := WrapResponse(RequestJson, OutputJson);
    end;


    // ################################################################################################
    // REQUEST PROCESSING PROCEDURES (MATUMBO)
    // ################################################################################################
    local procedure GetMemberDetails(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Found: Boolean;
    begin

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;

        Customer.Reset();
        Customer.SetRange(Customer."Mobile Phone No", UpperCase(Identifier));
        if Customer.FindFirst() then begin

            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
            DataJson.Add('identifier_type', 'CUSTOMER_NO');
            DataJson.Add('identifier', Customer."No.");
            DataJson.Add('primary_identity_type', UpperCase(Format(Customer."Identification Document")));
            DataJson.Add('primary_identity_no', Customer."ID No.");
            DataJson.Add('title', Format(Customer.Title));
            DataJson.Add('full_name', Customer.Name);
            DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
            DataJson.Add('date_of_birth', Customer."Date Of Birth");
            DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
            DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
            DataJson.Add('status', UpperCase(Format(Customer.Status)));
            DataJson.Add('registration_date', Customer."Registration Date");
            DataJson.Add('tax_authority', 'KRA');
            DataJson.Add('tax_authority_pin_number', Customer.Pin);
            DataJson.Add('branch_code', '100');
            DataJson.Add('branch', 'NAIROBI');
            DataJson.Add('main_savings_account_no', Customer."FOSA Account No.");
            Found := true;
        end;

        Customer.Reset();
        Customer.SetRange(Customer."ID No.", UpperCase(Identifier));
        if Customer.FindFirst() then begin

            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
            DataJson.Add('identifier_type', 'CUSTOMER_NO');
            DataJson.Add('identifier', Customer."No.");
            DataJson.Add('primary_identity_type', UpperCase(Format(Customer."Identification Document")));
            DataJson.Add('primary_identity_no', Customer."ID No.");
            DataJson.Add('title', Format(Customer.Title));
            DataJson.Add('full_name', Customer.Name);
            DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
            DataJson.Add('date_of_birth', Customer."Date Of Birth");
            DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
            DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
            DataJson.Add('status', UpperCase(Format(Customer.Status)));
            DataJson.Add('registration_date', Customer."Registration Date");
            DataJson.Add('tax_authority', 'KRA');
            DataJson.Add('tax_authority_pin_number', Customer.Pin);
            DataJson.Add('branch_code', '100');
            DataJson.Add('branch', 'NAIROBI');
            DataJson.Add('main_savings_account_no', Customer."FOSA Account No.");
            Found := true;
        end;

        Customer.Reset();
        Customer.SetRange(Customer."No.", UpperCase(Identifier));
        if Customer.FindFirst() then begin

            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
            DataJson.Add('identifier_type', 'CUSTOMER_NO');
            DataJson.Add('identifier', Customer."No.");
            DataJson.Add('primary_identity_type', UpperCase(Format(Customer."Identification Document")));
            DataJson.Add('primary_identity_no', Customer."ID No.");
            DataJson.Add('title', Format(Customer.Title));
            DataJson.Add('full_name', Customer.Name);
            DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
            DataJson.Add('date_of_birth', Customer."Date Of Birth");
            DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
            DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
            DataJson.Add('status', UpperCase(Format(Customer.Status)));
            DataJson.Add('registration_date', Customer."Registration Date");
            DataJson.Add('tax_authority', 'KRA');
            DataJson.Add('tax_authority_pin_number', Customer.Pin);
            DataJson.Add('branch_code', '100');
            DataJson.Add('branch', 'NAIROBI');
            DataJson.Add('main_savings_account_no', Customer."FOSA Account No.");
            Found := true;
        end;

        Customer.Reset();
        Customer.SetRange(Customer."Payroll No", UpperCase(Identifier));
        if Customer.FindFirst() then begin

            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            DataJson.Add('customer_type', UpperCase(Format(Customer."Account Category")));
            DataJson.Add('identifier_type', 'CUSTOMER_NO');
            DataJson.Add('identifier', Customer."No.");
            DataJson.Add('primary_identity_type', UpperCase(Format(Customer."Identification Document")));
            DataJson.Add('primary_identity_no', Customer."ID No.");
            DataJson.Add('title', Format(Customer.Title));
            DataJson.Add('full_name', Customer.Name);
            DataJson.Add('gender', UpperCase(Format(Customer.Gender)));
            DataJson.Add('date_of_birth', Customer."Date Of Birth");
            DataJson.Add('primary_email_address', Customer."E-Mail (Personal)");
            DataJson.Add('primary_mobile_number', Customer."Mobile Phone No");
            DataJson.Add('status', UpperCase(Format(Customer.Status)));
            DataJson.Add('registration_date', Customer."Registration Date");
            DataJson.Add('tax_authority', 'KRA');
            DataJson.Add('tax_authority_pin_number', Customer.Pin);
            DataJson.Add('branch_code', '100');
            DataJson.Add('branch', 'NAIROBI');
            DataJson.Add('main_savings_account_no', Customer."FOSA Account No.");
            Found := true;
        end;


        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;


        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetAccounts(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        AccountType: Text;
        IdentifierType: Text;
        Identifier: Text;
        AccountsArray: JsonArray;
        AccountObject: JsonObject;
        AccountNumber: Code[200];
        Iterator: Integer;
        Vend: Record Vendor;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        Found: boolean;
        FireLable: Label '+';
        Memb: record Customer;
    begin
        Iterator := 0;

        AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;
        AccountNumber := '';

        if AccountType = 'ALL' THEN BEGIN
            Memb.Reset();
            Memb.SetRange(Memb."Mobile Phone No", UpperCase(Format(Identifier)));
            if Memb.FindFirst() then begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
                if Vendor.FindFirst() then begin
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    repeat
                        AccountNumber := Vendor."BOSA Account No";

                        Vendor.CalcFields(Balance);
                        AccountTypes.Get(Vendor."Account Type");

                        AccountObject.Add('account_name', Vendor."Account Type");
                        AccountObject.Add('account_label', AccountTypes.Description);
                        AccountObject.Add('account_number', Vendor."No.");
                        AccountObject.Add('account_type', Format(AccountTypes."Account Location"));
                        AccountObject.Add('account_balance', Vendor.GetAvailableBalance());
                        AccountObject.Add('account_status', UpperCase(Format(Vend.Status)));
                        AccountObject.Add('can_withdraw', UpperCase(Format(AccountTypes.Withrawable)));
                        AccountObject.Add('max_withdrawable_amount', AccountTypes."Maximum Withdrawal Amount");
                        AccountObject.Add('can_deposit', 'YES');
                        AccountObject.Add('max_deposit_amount', AccountTypes."Maximum Allowable Deposit");
                        AccountsArray.Add(AccountObject);
                        Clear(AccountObject);
                        Iterator := Iterator + 1;

                        Found := true;

                    until Vendor.Next() = 0;
                    DataJson.Add('accounts', AccountsArray);
                end;
            end;


            Memb.Reset();
            Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
            if Memb.FindFirst() then begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
                if Vendor.FindFirst() then begin
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    repeat
                        AccountNumber := Vendor."BOSA Account No";

                        Vendor.CalcFields(Balance);
                        AccountTypes.Get(Vendor."Account Type");

                        AccountObject.Add('account_name', Vendor."Account Type");
                        AccountObject.Add('account_label', AccountTypes.Description);
                        AccountObject.Add('account_number', Vendor."No.");
                        AccountObject.Add('account_type', Format(AccountTypes."Account Location"));
                        AccountObject.Add('account_balance', Vendor.GetAvailableBalance());
                        AccountObject.Add('account_status', UpperCase(Format(Vend.Status)));
                        AccountObject.Add('can_withdraw', UpperCase(Format(AccountTypes.Withrawable)));
                        AccountObject.Add('max_withdrawable_amount', AccountTypes."Maximum Withdrawal Amount");
                        AccountObject.Add('can_deposit', 'YES');
                        AccountObject.Add('max_deposit_amount', AccountTypes."Maximum Allowable Deposit");
                        AccountsArray.Add(AccountObject);
                        Clear(AccountObject);
                        Iterator := Iterator + 1;

                        Found := true;

                    until Vendor.Next() = 0;
                    DataJson.Add('accounts', AccountsArray);
                end;
            end;
        end;

        if AccountType = 'WITHDRAWABLE' THEN BEGIN


            Memb.Reset();
            Memb.SetRange(Memb."Mobile Phone No", UpperCase(Format(Identifier)));
            if Memb.FindFirst() then begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
                if Vendor.FindFirst() then begin
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    repeat
                        AccountNumber := Vendor."BOSA Account No";

                        Vendor.CalcFields(Balance);
                        AccountTypes.Reset();
                        AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                        AccountTypes.SetRange(AccountTypes."Product Type", AccountTypes."Product Type"::Withdrawable);
                        IF AccountTypes.FindFirst() then BEGIN
                            AccountObject.Add('account_name', Vendor."Account Type");
                            AccountObject.Add('account_label', AccountTypes.Description);
                            AccountObject.Add('account_number', Vendor."No.");
                            AccountObject.Add('account_type', Format(AccountTypes."Account Location"));
                            AccountObject.Add('account_balance', Vendor.GetAvailableBalance());
                            AccountObject.Add('account_status', UpperCase(Format(Vend.Status)));
                            AccountObject.Add('can_withdraw', UpperCase(Format(AccountTypes.Withrawable)));
                            AccountObject.Add('max_withdrawable_amount', AccountTypes."Maximum Withdrawal Amount");
                            AccountObject.Add('can_deposit', 'YES');
                            AccountObject.Add('max_deposit_amount', AccountTypes."Maximum Allowable Deposit");
                            AccountsArray.Add(AccountObject);
                            Clear(AccountObject);
                            Iterator := Iterator + 1;

                            Found := true;
                        end;
                    until Vendor.Next() = 0;
                    DataJson.Add('accounts', AccountsArray);
                end;
            end;





            Memb.Reset();
            Memb.SetRange(Memb."No.", UpperCase(Format(Identifier)));
            if Memb.FindFirst() then begin

                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", Memb."No.");
                if Vendor.FindFirst() then begin
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    repeat
                        AccountNumber := Vendor."BOSA Account No";

                        Vendor.CalcFields(Balance);
                        AccountTypes.Reset();
                        AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                        AccountTypes.SetRange(AccountTypes."Product Type", AccountTypes."Product Type"::Withdrawable);
                        IF AccountTypes.FindFirst() then BEGIN
                            AccountObject.Add('account_name', Vendor."Account Type");
                            AccountObject.Add('account_label', AccountTypes.Description);
                            AccountObject.Add('account_number', Vendor."No.");
                            AccountObject.Add('account_type', Format(AccountTypes."Account Location"));
                            AccountObject.Add('account_balance', Vendor.GetAvailableBalance());
                            AccountObject.Add('account_status', UpperCase(Format(Vend.Status)));
                            AccountObject.Add('can_withdraw', UpperCase(Format(AccountTypes.Withrawable)));
                            AccountObject.Add('max_withdrawable_amount', AccountTypes."Maximum Withdrawal Amount");
                            AccountObject.Add('can_deposit', 'YES');
                            AccountObject.Add('max_deposit_amount', AccountTypes."Maximum Allowable Deposit");
                            AccountsArray.Add(AccountObject);
                            Clear(AccountObject);
                            Iterator := Iterator + 1;

                            Found := true;
                        end;
                    until Vendor.Next() = 0;
                    DataJson.Add('accounts', AccountsArray);
                end;
            end;
        end;


        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure BalanceEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        Customer: Record Customer;
        Vend: Record Vendor;
        LoanResgister: Record "Loans Register";
        Found: Boolean;
        FirstString: Text;
        MobilePhoneNumber: Text;
        AccountTypes: Record "Account Types-Saving Products";
    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
        AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
        IF AccountType = 'ACCOUNT' THEN begin
            //MobilePhoneNumber := CheckFirstCharactor(Vend."Mobile Phone No");
            FirstString := '';

            Vend.Reset();
            Vend.SetRange(Vend."Mobile Phone No", UpperCase('+' + Identifier));
            if Vend.FindFirst() then begin
                if Vend.Get(AccountNumber) then begin

                    AccountTypes.Get(Vend."Account Type");
                    Vend.CalcFields(Balance);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                    DataJson.Add('account_name', Vend."Account Type");
                    DataJson.Add('account_label', AccountTypes.Description);
                    DataJson.Add('account_number', Vend."No.");
                    DataJson.Add('account_type', AccountTypes."Account Location");
                    DataJson.Add('account_balance', Vend.GetAvailableBalance());
                    Found := true;
                end;
            end;
            Vend.Reset();
            Vend.SetRange(Vend."BOSA Account No", UpperCase(Identifier));
            //Vend.SetRange(Vend."No.", AccountNumber);//ACCOUNT//LOAN\
            if Vend.FindFirst() then begin
                if Vend.Get(AccountNumber) then begin
                    AccountTypes.Get(Vend."Account Type");
                    Vend.CalcFields(Balance);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                    DataJson.Add('account_name', Vend."Account Type");
                    DataJson.Add('account_label', AccountTypes.Description);
                    DataJson.Add('account_number', Vend."No.");
                    DataJson.Add('account_type', AccountTypes."Account Location");
                    DataJson.Add('account_balance', vend.GetAvailableBalance());
                    Found := true;
                end;
            end;
            Vend.Reset();
            Vend.SetRange(Vend."ID No.", UpperCase(Identifier));
            if Vend.FindFirst() then begin
                // if true then begin
                if Vend.Get(AccountNumber) then begin
                    AccountTypes.Get(Vend."Account Type");
                    Vend.CalcFields(Balance);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                    DataJson.Add('account_name', Vend."Account Type");
                    DataJson.Add('account_label', AccountTypes.Description);
                    DataJson.Add('account_number', Vend."No.");
                    DataJson.Add('account_type', AccountTypes."Account Location");
                    DataJson.Add('account_balance', Vend.GetAvailableBalance());
                    Found := true;
                end
            end
        END ELSE
            IF AccountType = 'LOAN' THEN begin
                Customer.Reset();
                Customer.SetRange("Mobile Phone No", UpperCase(Identifier));
                if Customer.FindFirst() then begin
                    LoanResgister.Reset();
                    LoanResgister.SetRange("Client Code", Customer."No.");
                    LoanResgister.SetRange(LoanResgister."Loan  No.", AccountNumber);//ACCOUNT//LOAN
                    if LoanResgister.FindFirst() then begin
                        LoanResgister.CalcFields("Outstanding Balance");

                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        DataJson.Add('account_name', LoanResgister."Loan Product Type");
                        DataJson.Add('account_label', LoanResgister."Loan Product Type Name");
                        DataJson.Add('account_number', LoanResgister."Loan  No.");
                        DataJson.Add('account_type', 'LOAN');
                        DataJson.Add('account_balance', LoanResgister."Outstanding Balance");
                        Found := true;
                    end;

                end;


                Customer.Reset();
                Customer.SetRange("No.", UpperCase(Identifier));
                if Customer.FindFirst() then begin
                    LoanResgister.Reset();
                    LoanResgister.SetRange("Client Code", Customer."No.");
                    LoanResgister.SetRange(LoanResgister."Loan  No.", AccountNumber);//ACCOUNT//LOAN
                    if LoanResgister.FindFirst() then begin
                        LoanResgister.CalcFields("Outstanding Balance");

                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        DataJson.Add('account_name', LoanResgister."Loan Product Type");
                        DataJson.Add('account_label', LoanResgister."Loan Product Type Name");
                        DataJson.Add('account_number', LoanResgister."Loan  No.");
                        DataJson.Add('account_type', 'LOAN');
                        DataJson.Add('account_balance', LoanResgister."Outstanding Balance");
                        Found := true;
                    end;

                end;

                Customer.Reset();
                Customer.SetRange("ID No.", UpperCase(Identifier));
                if Customer.FindFirst() then begin
                    LoanResgister.Reset();
                    LoanResgister.SetRange("Client Code", Customer."No.");
                    LoanResgister.SetRange(LoanResgister."Loan  No.", AccountNumber);//ACCOUNT//LOAN
                    if LoanResgister.FindFirst() then begin
                        LoanResgister.CalcFields("Outstanding Balance");

                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        DataJson.Add('account_name', LoanResgister."Loan Product Type");
                        DataJson.Add('account_label', LoanResgister."Loan Product Type Name");
                        DataJson.Add('account_number', LoanResgister."Loan  No.");
                        DataJson.Add('account_type', 'LOAN');
                        DataJson.Add('account_balance', LoanResgister."Outstanding Balance");
                        Found := true;
                    end;

                end;
            END;
        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;
        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure StatementEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        AccountType: Text;
        AccountNumber: Text;
        NumberOfTransactions: Integer;
        StartDate: Date;
        EndDate: Date;
        SavAccount: Record Vendor;
        StatementType: Text;
        Members: Record Customer;
        TransactionsArray: JsonArray;
        TransactionObject: JsonObject;
        Iterator: Integer;
        SavLedger: record "Detailed Vendor Ledg. Entry";
        Found: Boolean;
        Loans: Record "Loans Register";
        CredLedger: Record "Detailed Cust. Ledg. Entry";
        DocumentNumber: Code[40];
        AccountTypeX: Record "Account Types-Saving Products";
        varTempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
        varBase64Conversion: Codeunit "Base64 Convert";
        vConvertedContent: Text;
        RecRef: RecordRef;
        MemberStatement: Report 50004;
        StatementOutstream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        StatementInstream: InStream;

    // AmountL: 
    begin
        Iterator := 0;
        Found := false;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
        AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
        NumberOfTransactions := SelectJsonToken(RequestJson, '$.number_of_transactions').AsValue.AsInteger();
        StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDate;
        EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDate;
        StatementType := SelectJsonToken(RequestJson, '$.statement_type').AsValue.AsText;
        DocumentNumber := SelectJsonToken(RequestJson, '$.reference_id').AsValue().AsText;


        if (StatementType = 'MINI_STATEMENT') or (StatementType = 'FULL_STATEMENT') or (StatementType = 'PDF_STATEMENT') then begin
            if (AccountType = 'ACCOUNT') or (AccountType = 'LOAN') then begin
                if AccountType = 'ACCOUNT' then begin

                    SavAccount.Reset();
                    SavAccount.SetRange("No.", AccountNumber);
                    //  SavAccount.SetRange("View on Mobile", true);
                    if SavAccount.FindFirst() then begin
                        SavAccount.CalcFields("Balance (LCY)");
                        AccountTypeX.Get(SavAccount."Account Type");
                        DataJson.Add('account_name', AccountTypeX.Description);
                        DataJson.Add('account_number', AccountNumber);
                        DataJson.Add('available_balance', SavAccount.GetAvailableBalance());
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        if StatementType = 'MINI_STATEMENT' then begin
                            Iterator := 0;
                            SavLedger.Reset();
                            SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
                            if SavLedger.FindFirst() then
                                repeat
                                    Iterator := Iterator + 1;
                                    SavLedger.CalcFields(SavLedger.Description);
                                    TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
                                    TransactionObject.Add('transaction_date', SavLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', Time);
                                    TransactionObject.Add('transaction_amount', SavLedger.Amount);
                                    TransactionObject.Add('available_balance', SavAccount.GetAvailableBalance());
                                    TransactionObject.Add('transaction_description', SavLedger.Description);
                                    TransactionObject.Add('other_details', SavLedger."Document No.");
                                    if Iterator < NumberOfTransactions then
                                        TransactionsArray.Add(TransactionObject);
                                    Clear(TransactionObject);



                                until SavLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;
                        if StatementType = 'FULL_STATEMENT' then begin

                            SavLedger.Reset();
                            SavLedger.SetRange(SavLedger."Vendor No.", AccountNumber);
                            // SavLedger.SetRange("Posting Date", StartDate, EndDate);
                            if SavLedger.FindFirst() then
                                repeat
                                    SavLedger.CalcFields(SavLedger.Description);
                                    TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
                                    TransactionObject.Add('transaction_date', SavLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', Time);
                                    TransactionObject.Add('transaction_amount', SavLedger.Amount);
                                    TransactionObject.Add('available_balance', SavAccount.GetAvailableBalance());
                                    TransactionObject.Add('transaction_description', SavLedger.Description);
                                    TransactionObject.Add('other_details', SavLedger."Document No.");
                                    TransactionsArray.Add(TransactionObject);
                                    Clear(TransactionObject);
                                until SavLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;
                        if StatementType = 'PDF_STATEMENT' then begin
                            SavAccount.Reset();
                            SavAccount.SetRange("No.", AccountNumber);
                            if SavAccount.Find('-') then begin
                                MemberStatement.SetTableView(SavAccount);
                                TempBlob.CreateOutStream(StatementOutstream);
                                if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then //begin
                                    TempBlob.CreateInStream(StatementInstream);
                                vConvertedContent := varBase64Conversion.ToBase64(StatementInstream, true);
                                DataJson.Add('pdf', vConvertedContent);
                            end;
                        end;
                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Account does not exist');
                end;
                if AccountType = 'LOAN' then begin

                    LoansRegister.Reset();
                    LoansRegister.SetRange(LoansRegister."Loan  No.", AccountNumber);
                    if LoansRegister.FindFirst() then begin
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
                        DataJson.Add('account_name', LoansRegister."Loan Product Type Name");
                        DataJson.Add('account_number', AccountNumber);
                        DataJson.Add('available_balance', LoansRegister."Outstanding Balance");
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                        if StatementType = 'MINI_STATEMENT' then begin
                            Iterator := 0;
                            CredLedger.Reset();
                            CredLedger.SetCurrentKey("Posting Date");
                            CredLedger.SetAscending("Posting Date", false);
                            CredLedger.SetRange("Loan No", AccountNumber);
                            if CredLedger.FindSet() then
                                repeat
                                    Iterator := Iterator + 1;
                                    TransactionObject.Add('transaction_reference', CredLedger."Document No.");
                                    TransactionObject.Add('transaction_date', CredLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', '');
                                    TransactionObject.Add('transaction_amount', CredLedger.Amount);
                                    TransactionObject.Add('available_balance', LoansRegister."Outstanding Balance");
                                    TransactionObject.Add('transaction_description', CredLedger.Description);
                                    TransactionObject.Add('other_details', CredLedger.Description);
                                    if Iterator < NumberOfTransactions then
                                        TransactionsArray.Add(TransactionObject);

                                    Clear(TransactionObject);



                                until CredLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;

                        if StatementType = 'FULL_STATEMENT' then begin

                            CredLedger.Reset();
                            CredLedger.SetRange("Loan No", AccountNumber);
                            CredLedger.SetRange("Posting Date", StartDate, EndDate);
                            if CredLedger.FindFirst() then
                                repeat

                                    TransactionObject.Add('transaction_reference', CredLedger."Document No.");
                                    TransactionObject.Add('transaction_date', CredLedger."Posting Date");
                                    TransactionObject.Add('transaction_time', '');
                                    TransactionObject.Add('transaction_amount', CredLedger.Amount);
                                    TransactionObject.Add('available_balance', LoansRegister."Outstanding Balance");
                                    TransactionObject.Add('transaction_description', CredLedger.Description);
                                    TransactionObject.Add('other_details', CredLedger.Description);

                                    TransactionsArray.Add(TransactionObject);
                                    Clear(TransactionObject);
                                until CredLedger.Next() = 0;

                            DataJson.Add('transactions', TransactionsArray);
                        end;

                    end else
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan does not exist');
                end;

                ResponseJson.Add(Data, DataJson);
                //RandText := Mob.GetBalanceEnquiry(Identifier, DocumentNumber);
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Account Type Invalid');
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Invalid statement type');


    end;




    // ------------------------------------------------------------------------------------------------
    local procedure PESAOUTRequest(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        GenJournalLine: Record "Gen. Journal Line";
        OriginatorID: Text;
        ProductID: Text;
        PesaType: Text;
        LineNo: Integer;
        TransactionAction: Text;
        Command: Text;
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorReference: Text;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSenderIdentifierType: Text;
        TransactionSenderIdentifier: Text;
        TransactionSenderAccount: Text;
        TransactionSenderName: Text;
        TransactionReceiverIdentifierType: Text;
        TransactionReceiverIdentifier: Text;
        TransactionReceiverAccount: Text;
        TransactionReceiverName: Text;
        TransactionBeneficiaryIdentifierType: Text;
        TransactionBeneficiaryIdentifier: Text;
        TransactionBeneficiaryAccount: Text;
        TransactionBeneficiaryName: Text;
        Amount: Decimal;
        Category: Text;
        TransactionDescription: Text;
        SourceReference: Text;
        RequestApplication: Text;
        SourceApplication: Text;
        TransactionDateTime: Text;
        GLPosting: Codeunit 12;
        WithdrawalBuffer: Record "Mpesa Withdawal Buffer";
        Vend: Record Vendor;
        Vendor: Record Vendor;
        // Mob: Codeunit MobileBanking_New;
        Response: Text;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        ProductID := SelectJsonToken(RequestJson, '$.product_id').AsValue.AsText;
        PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
        TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;

        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
        TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
        TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
        TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;

        TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
        TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
        TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
        TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;

        TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
        TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
        TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
        TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

        TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
        TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
        TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
        TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        Category := SelectJsonToken(RequestJson, '$.category').AsValue.AsText;
        TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

        if PesaType = 'PESA_OUT' then begin
            WithdrawalBuffer.Reset();
            WithdrawalBuffer.SetRange("Originator ID", OriginatorID);
            if WithdrawalBuffer.Find('-') = false then begin
                Vend.Reset();
                // Vend.SetRange(Vend."Mobile Phone No", TransactionInitiatorIdentifier);
                Vend.SetRange("No.", TransactionSourceAccount);
                Vend.SetAutoCalcFields(Balance);
                if Vend.FindFirst() then begin

                    if Amount > Vend.GetAvailableBalance() then begin
                        Response := 'You have insufficient balance in your account available balance Ksh.' + Format(Vend.GetAvailableBalance());
                    end
                    else begin
                        Response := 'Success';
                        WithdrawalBuffer.Init();
                        WithdrawalBuffer."Vendor No" := Vend."No.";
                        WithdrawalBuffer."Vendor Name" := Vend.Name;
                        WithdrawalBuffer."Amount Requested" := Amount;
                        WithdrawalBuffer.Posted := false;
                        WithdrawalBuffer."Originator ID" := OriginatorID;
                        WithdrawalBuffer."Transaction Date" := Today;
                        WithdrawalBuffer."Telephone No" := TransactionInitiatorIdentifier;
                        WithdrawalBuffer."Member No" := Vend."BOSA Account No";
                        WithdrawalBuffer.Insert(true);
                    end;

                end;/*  else begin
                     SetResponseStatus(ResponseJson, 'FAIL', 'FAIL', 'Account not found.');
                end; */
            end;
        end;

        if Response <> 'Success' then
            SetResponseStatus(ResponseJson, 'FAIL', 'Fail', 'Account not found.') else
            if Response = 'Success' then
                SetResponseStatus(ResponseJson, 'success', 'SUCCESS', 'Request processed successfully');

        DataJson.Add('transaction_reference', OriginatorID);
        DataJson.Add('transaction_status_description', Response);
        DataJson.Add('transaction_date_time', CurrentDateTime);

        ResponseJson.Add(Data, DataJson);
    end;
    // ------------------------------------------------------------------------------------------------
    local procedure PESAOUTConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        TransactionStatus: Text;
        TransactionStatusDescription: Text;
        BeneficiaryIdentifierType: Text;
        BeneficiaryIdentifier: Text;
        BeneficiaryName: Text;
        BeneficiaryReference: Text;
        TransactionDateTime: Text;
        BufferTable: Record "Mpesa Withdawal Buffer";
        MPESATRANS: Record "MOBILE MPESA Trans";
        GenJournalLine: Record "Gen. Journal Line";
        Vend: Record Vendor;
        Member: Record Customer;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        TransactionStatus := SelectJsonToken(RequestJson, '$.transaction_status').AsValue.AsText;
        TransactionStatusDescription := SelectJsonToken(RequestJson, '$.transaction_status_description').AsValue.AsText;

        BeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
        BeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
        BeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

        //BeneficiaryReference := SelectJsonToken(RequestJson, '$.beneficiary_reference').AsValue.AsText;//Kit Comment
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;
        //success transaction

        if TransactionStatus = 'CONFIRMED' then begin

            BufferTable.Reset();
            BufferTable.SetRange(BufferTable."Originator ID", UpperCase(OriginatorID));
            BufferTable.SetRange(Posted, false);
            if BufferTable.FindFirst() then begin

                MPESATRANS.Init;
                MPESATRANS."Document No" := OriginatorID;
                MPESATRANS.Trace := BeneficiaryReference;
                MPESATRANS.Description := TransactionStatusDescription;
                MPESATRANS."Telephone" := BeneficiaryIdentifier;
                MPESATRANS."Account No" := BufferTable."Vendor No";
                MPESATRANS.Amount := BufferTable."Amount Requested";
                MPESATRANS."Transaction Type" := 'Withdrawal';
                MPESATRANS."Document Date" := Today;
                MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
                MPESATRANS.Posted := false;
                MPESATRANS.Reference := OriginatorID;
                MPESATRANS."Transaction Category" := BufferTable."Transaction Description";
                MPESATRANS.Insert;

                //if BufferTable."Transaction Description" = 'MPESA_WITHDRAWAL' then

                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'MOBILE';
                DOCUMENT_NO := BufferTable."Vendor No";
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll();
                end;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, BufferTable."Amount Requested", 'FOSA', DOCUMENT_NO,
                 'Mobile Trans' + ' ' + Vend."No.", '');

                //Balancing Account
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, BufferTable."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
                 'Mobile Trans' + ' ' + Vend."No.", '');

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;

                BufferTable.Posted := true;
                BufferTable.Modify();

                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                DataJson.Add('transaction_status', 'SUCCESS');
                DataJson.Add('transaction_status_description', 'Result processed successfully');
                DataJson.Add('transaction_date_time', CurrentDateTime);

            end else
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Invalid originator ID');
            ResponseJson.Add(Data, DataJson);
        end;
        if TransactionStatus = 'REVERSE_CONFIRMED' then begin
            BufferTable.Reset();
            BufferTable.SetRange(BufferTable."Originator ID", UpperCase(OriginatorID));
            BufferTable.SetRange(BufferTable.Reversed, false);
            if BufferTable.FindFirst() then begin
                BufferTable.Reversed := true;
                // Using this to confirm why its always marking reversed true

                BufferTable."Reversed Posted" := true;
                BufferTable."Transaction Description" := (BufferTable."Transaction Description" + '_Reversed');
                if BufferTable.Modify() then begin
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'MOBILE';
                    DOCUMENT_NO := BufferTable."Vendor No";
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.FindSet() then begin
                        GenJournalLine.DeleteAll();
                    end;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, BufferTable."Vendor No", Today, BufferTable."Amount Requested" * -1, 'FOSA', DOCUMENT_NO,
                     'Mobile Trans Reversal' + ' ' + Vend."No.", '');

                    //Balancing Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, BufferTable."Amount Requested", 'FOSA', DOCUMENT_NO,
                     'Mobile Trans Reversal' + ' ' + Vend."No.", '');

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Transaction reversed successfully');
                    DataJson.Add('transaction_status', 'SUCCESS');
                    DataJson.Add('transaction_status_description', 'Transaction reversed successfully');
                    DataJson.Add('transaction_date_time', CurrentDateTime);
                end;
            end else begin
                SetResponseStatus(ResponseJson, 'success', 'Success', 'originator ID already reversed');
            end;
            ResponseJson.Add(Data, DataJson);
        end;
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure InternalFundsTransfer(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SourceAccount: Text;
        DestinationAccount: Text;
        Amount: Decimal;
        SourceReference: Text;
        RequestApplication: Text;
        SourceApplication: Text;
        TransactionDescription: Text;
        TransactionDateTime: Text;
        SavAccount: Record Vendor;
        GenJournalLine: Record "Gen. Journal Line";
        Vend: Record Vendor;
        RunBal: Decimal;
        IntAmount: decimal;
        PrincipleAMount: Decimal;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
        DestinationAccount := SelectJsonToken(RequestJson, '$.destination_account').AsValue.AsText;
        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
        TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


        //verify account
        SavAccount.Reset();
        SavAccount.SetRange(SavAccount."No.", SourceAccount);
        if SavAccount.FindFirst() then begin
            //get account balance
            if SavAccount.GetAvailableBalance() > Amount then begin


                MPESATRANS.Init;
                MPESATRANS."Document No" := SourceReference;
                MPESATRANS.Description := 'Mobile Funds Transfer -' + SourceReference;
                MPESATRANS."Account No" := DestinationAccount;
                MPESATRANS.Amount := Amount;
                MPESATRANS."Transaction Type" := 'Funds Transfer';
                MPESATRANS."Document Date" := Today;
                MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
                MPESATRANS."Key Word" := '';
                MPESATRANS.Posted := false;
                MPESATRANS."Telephone" := Identifier;
                MPESATRANS."Account No" := SourceAccount;
                MPESATRANS.Insert;


                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'MOBILE';
                DOCUMENT_NO := CopyStr(SourceReference, 1, 20);
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll();
                end;
                //Source Account
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, SourceAccount, Today, Amount, 'FOSA', DOCUMENT_NO,
                 'Funds Transfer' + ' ' + SavAccount."No.", '');

                //Destination Account
                Vend.Reset();
                Vend.SetRange(Vend."No.", DestinationAccount);
                if Vend.Find('-') then begin
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, DestinationAccount, Today, Amount * -1, 'FOSA', DOCUMENT_NO,
                     'Funds Transfer' + ' ' + SavAccount."No.", '');
                end else begin
                    RunBal := 0;
                    RunBal := Amount;
                    LoansRegister.Reset();
                    LoansRegister.SetRange(LoansRegister."Loan  No.", DestinationAccount);
                    LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance");
                    LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                    if LoansRegister.FindFirst then begin
                        LoansRegister.CalcFields("Outstanding Balance", "Outstanding Interest");
                        if LoansRegister."Outstanding Interest" > 0 then begin
                            IntAmount := 0;
                            if LoansRegister."Outstanding Interest" > RunBal then
                                IntAmount := RunBal
                            else
                                IntAmount := LoansRegister."Outstanding Interest";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                            GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, IntAmount * -1, 'FOSA', DOCUMENT_NO,
                             'Funds Transfer' + ' ' + SavAccount."No.", LoansRegister."Loan  No.");
                            RunBal := RunBal - IntAmount;
                        end;

                        if LoansRegister."Outstanding Balance" > 0 then begin
                            PrincipleAMount := 0;
                            if RunBal > LoansRegister."Outstanding Balance" then
                                PrincipleAMount := LoansRegister."Outstanding Balance"
                            else
                                PrincipleAMount := RunBal;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, PrincipleAMount * -1, 'FOSA', DOCUMENT_NO,
                             'Funds Transfer' + ' ' + SavAccount."No.", LoansRegister."Loan  No.");
                            RunBal := RunBal - PrincipleAMount;
                        end;


                        if RunBal > 0 then begin
                            SavAccount.Reset();
                            SavAccount.SetRange(SavAccount."BOSA Account No", LoansRegister."Client Code");
                            SavAccount.SetRange(SavAccount."Account Type", 'CURRENT');
                            IF SavAccount.FindFirst() then BEGIN
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, RunBal * -1, 'FOSA', DOCUMENT_NO,
                                 'Funds Transfer Excess' + ' ' + SavAccount."No.", '');
                            END;
                        end;
                    end;
                end;
                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;


                DataJson.Add('transaction_reference', SourceReference);
                DataJson.Add('transaction_status', 'SUCCESS');
                DataJson.Add('transaction_status_description', 'Transfer posted successfully');

                ResponseJson.Add(Data, DataJson);
                //end else
                //SetResponseStatus(ResponseJson, 'error', 'Error', 'Destination Account does not exist');
            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Insufficient balance');

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Source account does not match identifier');


    end;

    // ------------------------------------------------------------------------------------------------
    local procedure PESAINConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        PesaType: Text;
        TransactionAction: Text;
        Command: Text;
        Sensitivity: Text;
        Charge: Decimal;
        IdentifierType: Text;
        Identifier: Text;
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorReference: Text;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceReference: Text;
        TransactionSenderIdentifierType: Text;
        TransactionSenderIdentifier: Text;
        TransactionSenderAccount: Text;
        TransactionSenderName: Text;
        TransactionSenderReference: Text;
        TransactionReceiverIdentifierType: Text;
        TransactionReceiverIdentifier: Text;
        TransactionReceiverAccount: Text;
        TransactionReceiverName: Text;
        TransactionBeneficiaryIdentifierType: Text;
        TransactionBeneficiaryIdentifier: Text;
        TransactionBeneficiaryAccount: Text;
        TransactionBeneficiaryName: Text;
        Amount: Decimal;
        TransactionDescription: Text;
        SourceReference: Text;
        RequestApplication: Text;
        SourceApplication: Text;
        TransactionDateTime: Text;
        Vendor: Record Vendor;
        Customer: Record Customer;
        LoanRegister: Record "Loans Register";
        GenJournalLine: Record "Gen. Journal Line";

    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
        TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;
        Sensitivity := SelectJsonToken(RequestJson, '$.sensitivity').AsValue.AsText;
        Charge := SelectJsonToken(RequestJson, '$.charge').AsValue.AsDecimal;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
        TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
        TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
        TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;
        TransactionSourceReference := SelectJsonToken(RequestJson, '$.transaction_source_details.reference').AsValue.AsText;

        TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
        TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
        TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
        TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;
        TransactionSenderReference := SelectJsonToken(RequestJson, '$.transaction_sender_details.reference').AsValue.AsText;

        TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
        TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
        TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
        TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

        TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
        TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
        TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
        TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;



        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'MOBILE';

        GenJournalLine.Reset();
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DeleteAll();
        end;

        MPESATRANS.Reset();
        MPESATRANS.SetRange(MPESATRANS."Account No", TransactionBeneficiaryIdentifier);
        MPESATRANS.SetRange("Document No", OriginatorID);
        if MPESATRANS.Find('-') = false then begin
            Customer.Reset();
            Customer.SetRange("Mobile Phone No", Identifier);
            if Customer.FindFirst() then begin
                LoanRegister.Reset();
                LoanRegister.SetRange("Loan  No.", TransactionBeneficiaryIdentifier);
                if LoanRegister.Find('-') then begin
                    MPESATRANS.Init;
                    MPESATRANS."Document No" := OriginatorID;
                    MPESATRANS.Trace := TransactionBeneficiaryName;
                    MPESATRANS.Description := TransactionBeneficiaryIdentifier;
                    MPESATRANS.Telephone := Identifier;
                    MPESATRANS.Amount := Amount;
                    MPESATRANS."Transaction Type" := 'Loan Repayment';
                    MPESATRANS."Document Date" := Today;
                    MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
                    MPESATRANS.Posted := false;
                    MPESATRANS."Transaction Category" := TransactionBeneficiaryIdentifier;
                    MPESATRANS.Insert;



                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'MOBILE';
                    DOCUMENT_NO := CopyStr(TransactionSenderReference, 1, 20);


                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."Account Type"::Customer, Customer."No.", Today, Amount * -1, 'FOSA', DOCUMENT_NO,
                     'Mobile Trans Pesa In' + ' ' + Customer."No.", LoanRegister."Loan  No.");

                    //Balancing Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, Amount, 'FOSA', DOCUMENT_NO,
                     'Mobile Trans Pesa In' + ' ' + Customer."No.", '');

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;

                    //response
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
                    DataJson.Add('transaction_status', 'SUCCESS');
                    DataJson.Add('transaction_status_description', 'Loan Repayment processed successfully');
                    DataJson.Add('transaction_date_time', CurrentDateTime);
                end;

                Vendor.Reset();
                Vendor.SetRange("BOSA Account No", Customer."No.");
                if Vendor.FindFirst() then begin
                    MPESATRANS.Init;
                    MPESATRANS."Document No" := OriginatorID;
                    MPESATRANS.Trace := TransactionBeneficiaryName;
                    MPESATRANS.Description := TransactionBeneficiaryIdentifier;
                    MPESATRANS.Telephone := Identifier;
                    MPESATRANS.Amount := BufferTable."Amount Requested";
                    MPESATRANS."Account No" := TransactionInitiatorAccount;
                    MPESATRANS."Account Name" := Customer.Name;
                    MPESATRANS."Transaction Type" := 'Savings Deposit';
                    MPESATRANS."Document Date" := Today;
                    MPESATRANS."Transaction Date Time" := Format(CurrentDateTime);
                    MPESATRANS.Posted := false;
                    MPESATRANS."Transaction Category" := TransactionBeneficiaryIdentifier;
                    MPESATRANS.Insert;
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'MOBILE';
                    DOCUMENT_NO := CopyStr(TransactionSenderReference, 1, 20);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, TransactionInitiatorAccount, Today, Amount * -1, 'FOSA', DOCUMENT_NO,
                     'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');

                    //Balancing Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, Amount, 'FOSA', DOCUMENT_NO,
                     'Mobile Trans Pesa In' + ' ' + Vendor."No.", '');

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;

                    //response
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

                    DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
                    DataJson.Add('transaction_status', 'SUCCESS');
                    DataJson.Add('transaction_status_description', 'Savings Deposits processed successfully');
                    DataJson.Add('transaction_date_time', CurrentDateTime);
                end;

            end;
            ResponseJson.Add(Data, DataJson);
        end
        else begin
            MPESATRANS.Reset();
            MPESATRANS.SetRange(Description, TransactionBeneficiaryIdentifier);
            MPESATRANS.SetRange("Document No", OriginatorID);
            if MPESATRANS.Find('-') then begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
                DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
                DataJson.Add('transaction_status', 'DUPLICATE');
                DataJson.Add('transaction_status_description', 'Transaction failed');
                DataJson.Add('transaction_date_time', CurrentDateTime);
            end;
            ResponseJson.Add(Data, DataJson);
        end;
        //response
        // SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

        // DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
        // DataJson.Add('transaction_status', 'SUCCESS');
        // DataJson.Add('transaction_status_description', 'Withdrawal processed successfully');
        // DataJson.Add('transaction_date_time', CurrentDateTime);

    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetLoanTypes(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypesArray: JsonArray;
        LoanTypesArray2: JsonArray;
        LoanTypeObject: JsonObject;
        LoanTypeObject2: JsonObject;
        Iterator: Integer;
        ProdFactory: Record "Loan Products Setup";
        ProdFactory2: Record "Loan Products Setup";
        Found: Boolean;
    begin
        Found := false;
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;


        ProdFactory.Reset();
        ProdFactory.SetRange(ProdFactory."Is Mobile Loan?", true);
        ProdFactory.SetRange(ProdFactory."Mobile Application Source", true);
        if ProdFactory.FindFirst() then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            repeat
                LoanTypeObject.Add('loan_type_id', ProdFactory.Code);
                LoanTypeObject.Add('loan_type_name', Format(ProdFactory."Product Description"));
                LoanTypeObject.Add('loan_type_min_amount', ProdFactory."Min. Loan Amount");
                LoanTypeObject.Add('loan_type_max_amount', '100');
                LoanTypeObject.Add('loan_type_interest_rate', ProdFactory."Interest rate");
                LoanTypeObject.Add('loan_type_min_instalments', 1);
                LoanTypeObject.Add('loan_type_max_instalments', ProdFactory."Default Installements");
                LoanTypeObject.Add('Installation_type', 'INPUT/NONE');
                if ProdFactory."Min No. Of Guarantors" > 0 then begin
                    LoanTypeObject2.Add('required_guarantors', true);
                    LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
                    LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
                    LoanTypeObject.Add('guarantors', LoanTypeObject2);

                end else begin
                    LoanTypeObject2.Add('required_guarantors', false);
                    LoanTypeObject.Add('guarantors', LoanTypeObject2);
                    LoanTypeObject2.Add('minimum_guarantors', ProdFactory."Min No. Of Guarantors");
                    LoanTypeObject2.Add('maximum_guarantors', ProdFactory."Max No. Of Guarantor");
                end;
                LoanTypesArray.Add(LoanTypeObject);
                Clear(LoanTypeObject2);
                Clear(LoanTypeObject);
            until ProdFactory.Next() = 0;
            DataJson.Add('loan_types', LoanTypesArray);
            Found := true;
        end;


        if Found = false then begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'No product exists');
        end;

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure CheckLoanLimit(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanTypeID: Text;
        LoansRegister: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
        Customer: Record Customer;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;

        if true then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            Customer.Reset();
            Customer.SetRange("No.", Identifier);
            if Customer.Find('-') then begin
                Customer.CalcFields("Current Shares");
                if LoanType.Get(LoanTypeID) then begin
                    DataJson.Add('loan_type_id', LoanType.Code);
                    DataJson.Add('loan_name', LoanType."Product Description");
                    DataJson.Add('eligible_amount', LoanType."Deposits Multiplier" * Customer."Current Shares");
                end;


            end;
            Customer.Reset();
            Customer.SetRange(Customer."ID No.", Identifier);
            if Customer.Find('-') then begin
                Customer.CalcFields("Current Shares");
                if LoanType.Get(LoanTypeID) then begin
                    DataJson.Add('loan_type_id', LoanType.Code);
                    DataJson.Add('loan_name', LoanType."Product Description");
                    DataJson.Add('eligible_amount', LoanType."Deposits Multiplier" * Customer."Current Shares");
                end;


            end;

        end
        else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;
        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure LoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        IdentifierType: Text;
        Installments: Integer;
        Identifier: Text;
        LoanTypeID: Text;
        Amount: Decimal;
        SourceReference: Text;
        RequestApplication: Text;
        TransactionDateTime: Text;
        LoansRegister: Record "Loans Register";
        LoanProductSetup: Record "Loan Products Setup";
        LoanRec: Record "Loans Register";
        Members: Record Customer;
        NoSeries: Codeunit "No. Series";
        Found: Boolean;
        ProductFound: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;
        Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        Installments := SelectJsonToken(RequestJson, '$.installment_period').AsValue.AsInteger;
        SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
        RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
        TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;
        // SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
        Found := false;
        ProductFound := false;
        LoanRec.Reset();
        LoanRec.SetRange(LoanRec."Loan  No.", SourceReference);
        if not LoanRec.FindFirst() then begin
            Members.Reset();
            Members.SetRange("Mobile Phone No", Identifier);
            if Members.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
                LoansRegister.SetRange("Loan Product Type", LoanTypeID);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>0');
                if LoansRegister.FindFirst() then begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Member has an existing loan product.');
                end else
                    LoanProductSetup.Reset();
                LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
                LoanProductSetup.SetRange("Appraise Guarantors", true);
                if LoanProductSetup.FindFirst() then begin

                    LoanRec.INIT;
                    LoanRec."Account No" := Members."FOSA Account No.";
                    LoanRec."Application Date" := Today;
                    LoanRec."Client Code" := Members."No.";
                    LoanRec."Client Name" := Members.name;
                    LoanRec."Requested Amount" := amount;
                    LoanRec."Requested Amount" := amount;
                    LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
                    LoanRec.Installments := Installments;
                    LoanRec.Posted := FALSE;
                    LoanRec."Approval Status" := LoanRec."Approval Status"::Pending;
                    LoanRec."Loan  No." := NoSeries.GetNextNo('LOANS', Today, true);
                    LoanRec."Loan Product Type" := LoanTypeID;
                    LoanRec.INSERT(true);
                    // Mob.ProcessAdvanceLoansFinal(SourceReference);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    //Get Loan No
                    LoansRegister.Reset();
                    LoansRegister.SetRange(Remarks, SourceReference);
                    if LoansRegister.FindFirst() then
                        DataJson.Add('transaction_reference', SourceReference);
                    DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
                    DataJson.Add('loan_type_id', LoanTypeID);
                    DataJson.Add('loan_name', LoanProductSetup."Product Description");
                    DataJson.Add('amount', Amount);
                    Found := true;
                    ProductFound := true;
                end
                else begin
                    LoanProductSetup.Reset();
                    LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
                    LoanProductSetup.SetRange("Appraise Guarantors", false);
                    if LoanProductSetup.FindFirst() then begin

                        LoanRec.INIT;
                        LoanRec."Account No" := Members."FOSA Account No.";
                        LoanRec."Application Date" := Today;
                        LoanRec."Client Code" := Members."No.";
                        LoanRec."Client Name" := Members.name;
                        LoanRec."Requested Amount" := amount;
                        LoanRec."Requested Amount" := amount;
                        LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
                        LoanRec.Installments := Installments;
                        LoanRec.Posted := true;
                        LoanRec."Approval Status" := LoanRec."Approval Status"::Approved;
                        LoanRec."Loan  No." := NoSeries.GetNextNo('LOANS', Today, true);
                        LoanRec."Loan Product Type" := LoanTypeID;
                        LoanRec.INSERT(true);
                        // Mob.ProcessAdvanceLoansFinal(SourceReference);
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                        //Get Loan No
                        LoansRegister.Reset();
                        LoansRegister.SetRange(Remarks, SourceReference);
                        if LoansRegister.FindFirst() then
                            DataJson.Add('transaction_reference', SourceReference);
                        DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
                        DataJson.Add('loan_type_id', LoanTypeID);
                        DataJson.Add('loan_name', LoanProductSetup."Product Description");
                        DataJson.Add('amount', Amount);
                        Found := true;
                        ProductFound := true;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'MOBILE';
                        DOCUMENT_NO := LoanRec."Loan  No.";
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DeleteAll();
                        end;
                        //Balancing Account
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, Amount * -1, '', DOCUMENT_NO,
                         'Mobile Trans' + ' ' + Members."No.", '');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                        GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, Amount, '', DOCUMENT_NO,
                         'Mobile Loan' + ' ' + Members."No.", LoanRec."Loan  No.");

                    end;
                end;
                if ProductFound = false then begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Product is not valid');
                end;
            end;
            Members.Reset();
            Members.SetRange(Members."No.", Identifier);
            if Members.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
                LoansRegister.SetRange("Loan Product Type", LoanTypeID);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>0');
                if LoansRegister.FindFirst() then begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Member has an existing loan product.');
                end else
                    LoanProductSetup.Reset();
                LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
                if LoanProductSetup.FindFirst() then begin

                    LoanRec.INIT;
                    LoanRec."Account No" := Members."FOSA Account No.";
                    LoanRec."Application Date" := Today;
                    LoanRec."Client Code" := Members."No.";
                    LoanRec."Client Name" := Members.name;
                    LoanRec."Requested Amount" := amount;
                    LoanRec."Requested Amount" := amount;
                    LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
                    LoanRec.Installments := Installments;
                    LoanRec.Posted := FALSE;
                    LoanRec."Approval Status" := LoanRec."Approval Status"::Pending;
                    LoanRec."Loan  No." := NoSeries.GetNextNo('LOANS', Today, true);
                    LoanRec."Loan Product Type" := LoanTypeID;
                    LoanRec.INSERT(true);
                    // Mob.ProcessAdvanceLoansFinal(SourceReference);
                    SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    //Get Loan No
                    LoansRegister.Reset();
                    LoansRegister.SetRange(Remarks, SourceReference);
                    if LoansRegister.FindFirst() then
                        DataJson.Add('transaction_reference', SourceReference);
                    DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
                    DataJson.Add('loan_type_id', LoanTypeID);
                    DataJson.Add('loan_name', LoanProductSetup."Product Description");
                    DataJson.Add('amount', Amount);
                    Found := true;
                    ProductFound := true;
                end else begin
                    LoanProductSetup.Reset();
                    LoanProductSetup.SetRange(LoanProductSetup.Code, LoanTypeID);
                    LoanProductSetup.SetRange("Appraise Guarantors", false);
                    if LoanProductSetup.FindFirst() then begin

                        LoanRec.INIT;
                        LoanRec."Account No" := Members."FOSA Account No.";
                        LoanRec."Application Date" := Today;
                        LoanRec."Client Code" := Members."No.";
                        LoanRec."Client Name" := Members.name;
                        LoanRec."Requested Amount" := amount;
                        LoanRec."Requested Amount" := amount;
                        LoanRec."Mode Of Application" := LoanRec."Mode Of Application"::Mobile;
                        LoanRec.Installments := Installments;
                        LoanRec.Posted := true;
                        LoanRec."Approval Status" := LoanRec."Approval Status"::Approved;
                        LoanRec."Loan  No." := NoSeries.GetNextNo('LOANS', Today, true);
                        LoanRec."Loan Product Type" := LoanTypeID;
                        LoanRec.INSERT(true);
                        // Mob.ProcessAdvanceLoansFinal(SourceReference);
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                        //Get Loan No
                        LoansRegister.Reset();
                        LoansRegister.SetRange(Remarks, SourceReference);
                        if LoansRegister.FindFirst() then
                            DataJson.Add('transaction_reference', SourceReference);
                        DataJson.Add('loan_serial_number', LoanRec."Loan  No.");
                        DataJson.Add('loan_type_id', LoanTypeID);
                        DataJson.Add('loan_name', LoanProductSetup."Product Description");
                        DataJson.Add('amount', Amount);
                        Found := true;
                        ProductFound := true;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'MOBILE';
                        DOCUMENT_NO := LoanRec."Loan  No.";
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.FindSet() then begin
                            GenJournalLine.DeleteAll();
                        end;
                        //Balancing Account
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BNK00010', Today, Amount * -1, '', DOCUMENT_NO,
                         'Mobile Trans' + ' ' + Members."No.", '');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                        GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", Today, Amount, '', DOCUMENT_NO,
                         'Mobile Loan' + ' ' + Members."No.", LoanRec."Loan  No.");

                    end;
                end;
                if ProductFound = false then begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Product is not valid');
                end;
            end;
            if Found = false then begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Member cannot be found.');
            end;
        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Source reference already exists');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------    
    local procedure GetOutstandingLoans(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        LoansArray: JsonArray;
        LoanObject: JsonObject;
        Iterator: Integer;
        Loans: Record "Loans Register";
        Members: Record Customer;
        ProdFactory: Record "Loan Products Setup";


    begin
        Iterator := 0;

        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        if Members.get(Identifier) then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            Loans.Reset();
            Loans.SetRange(Loans."Client Code", Members."No.");
            Loans.SetAutoCalcFields(Loans."Outstanding Balance");
            Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
            if Loans.FindFirst() then begin

                repeat
                    Loans.CalcFields(Loans."Outstanding Balance");
                    LoanObject.Add('loan_serial_number', Loans."Loan  No.");
                    LoanObject.Add('loan_type_id', Loans."Loan Product Type");
                    if Loans."Loan Product Type Name" = '' then begin
                        ProdFactory.Reset();
                        ProdFactory.SetRange(ProdFactory.Code, Loans."Loan Product Type");
                        if ProdFactory.FindFirst() then begin
                            LoanObject.Add('loan_type_name', ProdFactory."Product Description");
                        end else begin
                            LoanObject.Add('loan_type_name', Loans."Loan Product Type Name");
                        end;
                    end;
                    LoanObject.Add('loan_amount', Loans."Approved Amount");
                    LoanObject.Add('loan_balance', Loans."Outstanding Balance");
                    LoanObject.Add('installment_amount', Loans.Repayment);
                    LoanObject.Add('loan_defaulted_amount', Loans."Amount in Arrears");
                    LoanObject.Add('loan_issued_date', Loans."Loan Disbursement Date");
                    LoanObject.Add('loan_end_date', Loans."Expected Date of Completion");
                    LoanObject.Add('loan_performance', Format(Loans."Loans Category-SASRA"));
                    LoanObject.Add('loan_performance_description', StrSubstNo('Loan is %1', UpperCase(Format(Loans."Loans Category-SASRA"))));

                    LoansArray.Add(LoanObject);
                    Clear(LoanObject);
                    Iterator := Iterator + 1;
                until Loans.Next() = 0;
            end;

            DataJson.Add('loans', LoansArray);

        end else
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Member does not exist');

        ResponseJson.Add(Data, DataJson);
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetTransactionCharges(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        TransactionType: Text;
        TransactionAmount: Decimal;
        TransType: Record "Transaction Types";
        TransCharge: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "CWithdrawal Graduated Charges";
        ProductID: code[30];
        ExciseDutyAmt: Decimal;
        GenSet: Record "Sacco General Set-Up";
        ExcisableAmt: Decimal;
    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        TransactionType := SelectJsonToken(RequestJson, '$.transaction_type').AsValue.AsText;
        TransactionAmount := SelectJsonToken(RequestJson, '$.transaction_amount').AsValue.AsDecimal;

        /*   GenSet.Get;
          TransType.Reset();
          TransType.SetRange(TransType.Code, TransactionType);
          if TransType.FindFirst() then begin


              ChargeAmount := 0;
              ExcisableAmt := 0;



              TariffDetails.Reset;
              TariffDetails.SetRange(TariffDetails."Account Type", TransType."Account Type");
              if TariffDetails.Find('-') then begin
                  repeat
                      if (TransactionAmount >= TariffDetails."Minimum Amount") and (TransactionAmount <= TariffDetails."Maximum Amount") then begin
                          if TariffDetails."Use Percentage" = true then begin
                              ChargeAmount := TransactionAmount * TariffDetails."Percentage of Amount" * 0.01;
                          end else begin
                              ChargeAmount := TariffDetails.Amount;
                              // ExcisableAmt := TariffDetails."Vendor Charge Amount";
                          end;
                      end;
                  until TariffDetails.Next = 0;
              end; */
        ChargeAmount := 50;

        ExciseDutyAmt := Round((ChargeAmount - ExcisableAmt) * GenSet."Excise Duty(%)" * 0.01, 0.0001, '=');
        ChargeAmount := ChargeAmount + ExciseDutyAmt;

        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
        DataJson.Add('total_charge_amount', ChargeAmount);

        /*         end else
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Transaction Type not set up'); */



        ResponseJson.Add(Data, DataJson);
    end;


    // ------------------------------------------------------------------------------------------------
    local procedure VirtualMemberRegistration(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        OriginatorID: Text;
        MobileNumber: Text;
        Name: Text;
        NationalIDNumber: Text;
        EmailAddress: Text;
        ReferrerMobileNumber: Text;
    begin
        OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
        MobileNumber := SelectJsonToken(RequestJson, '$.mobile_number').AsValue.AsText;
        Name := SelectJsonToken(RequestJson, '$.name').AsValue.AsText;
        NationalIDNumber := SelectJsonToken(RequestJson, '$.national_id_number').AsValue.AsText;
        EmailAddress := SelectJsonToken(RequestJson, '$.email_address').AsValue.AsText;
        ReferrerMobileNumber := SelectJsonToken(RequestJson, '$.referrer_mobile_number').AsValue.AsText;


        if true then begin
            SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
        end
        else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;
        ResponseJson.Add(Data, DataJson);
    end;

    // ################################################################################################
    // RESPONSE GENERATION PROCEDURE
    // ################################################################################################
    local procedure WrapResponse(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        PayloadJson: JsonObject;
        RequestAction: Text;
        RequestId: Text;
        WrappedArray: JsonArray;
        ResponsePayload: Text;
        ResponseRequestID: Text;
        ResponseRquestDate: Text;
        DebitAccount: Text;
    begin
        RequestId := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        DebitAccount := SelectJsonToken(RequestJson, '$.payload.get_balance_request.account.debit_account').AsValue.AsText;
        ResponseRequestID := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        ResponseRquestDate := SelectJsonToken(RequestJson, '$.api_request_date_time').AsValue.AsText;


        PayloadJson.WriteTo(ResponsePayload);

        ResponseInnerJson.Add('response_status', CheckResponseStatus(DebitAccount));
        ResponseInnerJson.Add('response_status_description', 'Request processed successfully');
        ResponseInnerJson.Add('response_status_date', ResponseRquestDate);
        ResponseInnerJson.Add('destination_reference', ResponseRequestID);
        ResponseInnerJson.Add('payload', ResponseJson);

        //  WrappedJson.Add('', ResponseInnerJson);
        // WrappedArray.Add(ResponseJson);
        ResponseInnerJson.WriteTo(Wrapped);
    end;


    local procedure WrapResponseFundsTransfer(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        PayloadJson: JsonObject;
        RequestAction: Text;
        RequestId: Text;
        WrappedArray: JsonArray;
        ResponsePayload: Text;
        ResponseRequestID: Text;
        ResponseRquestDate: Text;
        DebitAccount: Text;
        Amount: Decimal;
        TransactionType: Text;
        MessageID: Text[2048];
    begin
        RequestId := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;

        Amount := SelectJsonToken(RequestJson, '$.payload.send_funds_transfer_request.posting.amount').AsValue.AsDecimal;
        DebitAccount := SelectJsonToken(RequestJson, '$.payload.send_funds_transfer_request.posting.debit_account').AsValue.AsText;
        TransactionType := SelectJsonToken(RequestJson, '$.payload.send_funds_transfer_request.operation_parameters.transaction_type').AsValue.AsText;
        ResponseRequestID := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        ResponseRquestDate := SelectJsonToken(RequestJson, '$.api_request_date_time').AsValue.AsText;


        PayloadJson.WriteTo(ResponsePayload);

        ResponseInnerJson.Add('response_status', CheckResponseStatusFundsTransfer(DebitAccount, Amount, TransactionType, ''));
        ResponseInnerJson.Add('response_status_description', 'Request processed successfully');
        ResponseInnerJson.Add('response_status_date', ResponseRquestDate);
        ResponseInnerJson.Add('destination_reference', ResponseRequestID);
        ResponseInnerJson.Add('payload', ResponseJson);

        //  WrappedJson.Add('', ResponseInnerJson);
        // WrappedArray.Add(ResponseJson);
        ResponseInnerJson.WriteTo(Wrapped);
    end;

    local procedure WrapResponseMinistatement(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
    var
        ResponseInnerJson: JsonObject;
        WrappedJson: JsonObject;
        PayloadJson: JsonObject;
        RequestAction: Text;
        RequestId: Text;
        WrappedArray: JsonArray;
        ResponsePayload: Text;
        ResponseRequestID: Text;
        ResponseRquestDate: Text;
        DebitAccount: Text;
    begin
        RequestId := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        RequestAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
        DebitAccount := SelectJsonToken(RequestJson, '$.payload.ministatement_request.account.debit_account').AsValue.AsText;
        ResponseRequestID := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        ResponseRquestDate := SelectJsonToken(RequestJson, '$.api_request_date_time').AsValue.AsText;


        PayloadJson.WriteTo(ResponsePayload);

        ResponseInnerJson.Add('response_status', CheckResponseStatus(DebitAccount));
        ResponseInnerJson.Add('response_status_description', 'Request processed successfully');
        ResponseInnerJson.Add('response_status_date', ResponseRquestDate);
        ResponseInnerJson.Add('destination_reference', ResponseRequestID);
        ResponseInnerJson.Add('payload', ResponseJson);

        //  WrappedJson.Add('', ResponseInnerJson);
        // WrappedArray.Add(ResponseJson);
        ResponseInnerJson.WriteTo(Wrapped);
    end;
    // SUPPORTING PROCEDURES
    // ------------------------------------------------------------------------------------------------

    local procedure SetResponseStatus(var ResponseJson: JsonObject; TheStatus: Text; TheTitle: Text; TheMessage: Text)
    begin
        ResponseJson.Add(Status, TheStatus);
        ResponseJson.Add(Title, TheTitle);
        ResponseJson.Add(Message, TheMessage);

    end;

    local procedure SetResponseStatuss(var ResponseJson: JsonObject; TheMessage: Text; Identifier: Code[40])
    begin
        ResponseJson.Add('message_id', TheMessage);
        ResponseJson.Add('status_code', CheckStatusCode(Identifier));
        ResponseJson.Add('status_description', LowerCase(CheckResponseStatus(Identifier)));
    end;

    local procedure SetResponseStatussFunds(var ResponseJson: JsonObject; TheMessage: Text[2048]; Identifier: Code[40]; Amount: Decimal; TransactionType: Text)
    begin
        ResponseJson.Add('message_id', TheMessage);
        ResponseJson.Add('status_code', CheckStatusCodeTransfer(Identifier, Amount, TransactionType, TheMessage));
        ResponseJson.Add('status_description', LowerCase(CheckResponseStatusFundsTransfer(Identifier, Amount, TransactionType, TheMessage)));
    end;

    local procedure SetResponseStatussMinistatement(var ResponseJson: JsonObject; TheMessage: Text; Identifier: Code[40]; Amount: Decimal)
    begin
        ResponseJson.Add('message_id', TheMessage);
        ResponseJson.Add('status_code', CheckStatusCode(Identifier));
        ResponseJson.Add('status_description', LowerCase(CheckResponseStatus(Identifier)));
    end;

    local procedure ValidateUserSession(RequestJson: JsonObject) Response: Boolean
    var
        UserName: Text;
        RequestId: Text;
        Employee: Record Employee;
    begin
        UserName := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;
        RequestId := SelectJsonToken(RequestJson, '$.api_request_id').AsValue.AsText;

        Response := true;
    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    local procedure ValidateRequestHash(RequestJson: JsonObject)
    var
        PayLoadJson: JsonObject;
        PayLoad: Text;
        HashFromPayload: Text;
        HashedPayload: Text;
    begin
        exit;
        HashFromPayload := SelectJsonToken(RequestJson, '$.hash').AsValue.AsText;
        PayLoadJson := SelectJsonToken(RequestJson, '$.payload').AsObject;
        PayLoadJson.WriteTo(PayLoad);
        HashedPayload := Sha256Hash(PayLoad);

        if HashedPayload <> HashFromPayload then
            Error('Payload hash mismatch');
    end;

    local procedure Sha256Hash(ClearText: Text): Text
    var
        CryptographyManagement: codeunit "Cryptography Management";
        HashAlgorithmType: option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
    end;

    local procedure CheckFirstCharactor(Mobile: Code[60]) MobilePhone: Code[50]
    var
        MobileRest: Text;
        MobilePhoneNo: Text;
        Firstpart: Text;
        MobilePhoneNo3: Text;
        CustomerRecord: Record Vendor;
        MobileExt: Label '254';
        CheckZero: text;
        MobileRest2: Text;
    begin
        CustomerRecord.Reset();
        CustomerRecord.Setrange("No.", Mobile);
        if CustomerRecord.find('-') then begin
            MobileRest := ' ';
            MobileRest := ' ';
            MobilePhoneNo := ' ';
            MobileRest2 := ' ';
            MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
            Firstpart := CopyStr(MobilePhoneNo3, 1, 4);
            CheckZero := CopyStr(MobilePhoneNo3, 1, 1);
            MobileRest := CopyStr(MobilePhoneNo3, 5, 200);
            MobileRest2 := CopyStr(MobilePhoneNo3, 2, 200);
            if Firstpart = '+254' then begin
                MobilePhone := MobileExt + MobileRest
            end

            else begin
                MobilePhone := CustomerRecord."Mobile Phone No";
            end;
            if Firstpart = '0' then begin
                MobilePhone := '254' + MobileRest2
            end

            else begin
                MobilePhone := CustomerRecord."Mobile Phone No";
            end;



        end;
        exit(MobilePhone);
    end;

    local procedure AddGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        Guarantors: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;
    begin

        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.loan_name').AsValue.AsText;
        TransactionInitiatorAmount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.guarantor.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.guarantor.identifier').AsValue.AsText;
        TransactionSourceAmount := SelectJsonToken(RequestJson, '$.guarantor.amount').AsValue.AsDecimal;

        Found := false;
        LoanId := 1;

        if TransactionInitiatorIdentifierType = 'MEMBER_NUMBER' then begin
            Loans.Reset();
            Loans.SetRange(Loans."Loan  No.", TransactionInitiatorAccount);
            if Loans.FindFirst() then begin
                Members.Reset();
                Members.SetRange(Members."No.", UpperCase(TransactionSourceIdentifier));
                if Members.FindFirst() then begin
                    loansG.Reset();
                    LoanG.SetRange(LoanG."Loan No", Loans."Loan  No.");
                    LoanG.SetRange(LoanG."Member No", Members."No.");
                    if not LoanG.FindFirst() then begin
                        LoanG.Init();
                        loansG."Loan No" := TransactionInitiatorAccount;
                        loansG."Loanees  No" := Loans."Client Code";
                        loansG."Loanees  Name" := Loans."Client Name";
                        loansG."Amont Guaranteed" := TransactionSourceAmount;
                        loansG."Member No" := TransactionSourceIdentifier;
                        LoanG.Name := Members.Name;
                        loansG.Insert();
                        Found := true;
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    end else begin
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Guarantor Already Exists');
                    end;

                end else begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Member not found');
                end;
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan not found');
            end;
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
        end;

        ResponseJson.Add(Data, DataJson);
    end;

    local procedure RemoveGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        Guarantors: JsonObject;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;
    begin

        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.loan_name').AsValue.AsText;
        TransactionInitiatorAmount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.guarantor.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.guarantor.identifier').AsValue.AsText;
        TransactionSourceAmount := SelectJsonToken(RequestJson, '$.guarantor.amount').AsValue.AsDecimal;

        Found := false;
        LoanId := 1;

        if TransactionInitiatorIdentifierType = 'MEMBER_NUMBER' then begin
            Loans.Reset();
            Loans.SetRange(Loans."Loan  No.", TransactionInitiatorAccount);
            if Loans.FindFirst() then begin
                Members.Reset();
                Members.SetRange(Members."No.", UpperCase(TransactionSourceIdentifier));
                if Members.FindFirst() then begin
                    loansG.Reset();
                    LoanG.SetRange(LoanG."Loan No", Loans."Loan  No.");
                    LoanG.SetRange(LoanG."Member No", Members."No.");
                    if LoanG.FindFirst() then begin
                        LoanG.Delete();
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                    end else begin
                        SetResponseStatus(ResponseJson, 'error', 'Error', 'Guarantor not found');
                    end;

                end else begin
                    SetResponseStatus(ResponseJson, 'error', 'Error', 'Member not found');
                end;
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'Loan not found');
            end;
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
        end;

        ResponseJson.Add(Data, DataJson);
    end;


    local procedure GetPendingGuarantorshipRequest(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        Guarantors: JsonObject;
        GuarantorsArray: JsonArray;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;

    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;
        LoanId := 1;

        if IdentifierType = 'MEMBER_NUMBER' then begin
            loansG.Reset();
            LoanG.SetRange(LoanG."Member No", UpperCase(Identifier));
            LoanG.SetFilter(LoanG."Acceptance Status", '%1', loansG."Acceptance Status"::Pending);
            if LoanG.FindFirst() then begin
                repeat
                    Loans.Reset();
                    Loans.SetRange(Loans."Loan  No.", LoanG."Loan No");
                    if Loans.FindFirst() then begin
                        LoanG.CalcFields(LoanG."Outstanding Balance");
                        Guarantors.Add('loan_id', LoanG."Loan No");
                        Guarantors.Add('loan_name', Loans."Loan Product Type");
                        Guarantors.Add('amount', LoanG."Amont Guaranteed");
                        Guarantors.Add('status', UpperCase((Format(LoanG."Acceptance Status"))));
                        Guarantors.Add('identifier_type', 'MEMBER_NUMBER');
                        Guarantors.Add('identifier', Loans."Client Code");
                        Guarantors.Add('name', Loans."Client Name");
                        GuarantorsArray.Add(Guarantors);
                        Clear(Guarantors);
                    end;
                until LoanG.Next() = 0;
                DataJson.Add('loan_guarantors', GuarantorsArray);
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'No Pending Guarantors found');
            end;
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
        end;

        ResponseJson.Add(Data, DataJson);
    end;

    local procedure AcceptRejectGuarantorship(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        Guarantors: JsonObject;
        GuarantorsArray: JsonArray;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionInitiatorOption: text;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;

    begin
        TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
        TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.loan_id').AsValue.AsText;
        TransactionInitiatorName := SelectJsonToken(RequestJson, '$.loan_name').AsValue.AsText;
        TransactionInitiatorAmount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
        TransactionInitiatorOption := SelectJsonToken(RequestJson, '$.option').AsValue.AsText;

        TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.guarantor.identifier_type').AsValue.AsText;
        TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.guarantor.identifier').AsValue.AsText;
        TransactionSourceAmount := SelectJsonToken(RequestJson, '$.guarantor.amount').AsValue.AsDecimal;

        Found := false;
        LoanId := 1;
        TransactionInitiatorOption := UpperCase(TransactionInitiatorOption);
        if (TransactionInitiatorOption = 'ACCEPTED') or (TransactionInitiatorOption = 'REJECTED') then begin
            loansG.Reset();
            LoansG.SetRange(LoansG."Member No", UpperCase(TransactionSourceIdentifier));
            LoansG.SetRange(LoansG."Loan No", TransactionInitiatorAccount);
            LoansG.SetFilter(LoansG."Acceptance Status", '%1', loansG."Acceptance Status"::Pending);
            if LoansG.FindFirst() then begin
                Loans.Reset();
                Loans.SetRange(Loans."Loan  No.", LoansG."Loan No");
                if Loans.FindFirst() then begin

                    if TransactionInitiatorOption = 'ACCEPTED' then begin
                        loansG."Acceptance Status" := loansG."Acceptance Status"::Accepted;
                        loansG.Modify();
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Guarantorship accepted successfully');
                    end;
                    if TransactionInitiatorOption = 'REJECTED' then begin
                        loansG."Acceptance Status" := loansG."Acceptance Status"::Declined;
                        loansG.Modify();
                        SetResponseStatus(ResponseJson, 'success', 'Success', 'Guarantorship declined successfully');
                    end;
                end;
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'No Pending Guarantors found');
            end;
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Option not Found');
        end;
        ResponseJson.Add(Data, DataJson);
    end;

    local procedure GetLoansGuaranteedByMember(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        Guarantors: JsonObject;
        GuarantorsArray: JsonArray;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;

    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;
        LoanId := 1;

        if IdentifierType = 'MEMBER_NUMBER' then begin
            loansG.Reset();
            LoanG.SetRange(LoanG."Member No", UpperCase(Identifier));
            LoanG.SetFilter(LoanG."Acceptance Status", '%1', loansG."Acceptance Status"::Accepted);
            if LoanG.FindFirst() then begin
                repeat
                    Loans.Reset();
                    Loans.SetRange(Loans."Loan  No.", LoanG."Loan No");
                    Loans.SetAutoCalcFields(loans."Outstanding Balance");
                    //Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                    if Loans.FindFirst() then begin
                        Guarantors.Add('loan_id', LoanG."Loan No");
                        Guarantors.Add('loan_name', Loans."Loan Product Type");
                        Guarantors.Add('amount', LoanG."Amont Guaranteed");
                        Guarantors.Add('status', UpperCase(Format(Loans."Loans Category-SASRA")));
                        Guarantors.Add('identifier_type', 'MEMBER_NUMBER');
                        Guarantors.Add('identifier', Loans."Client Code");
                        Guarantors.Add('name', Loans."Client Name");
                        GuarantorsArray.Add(Guarantors);
                        Clear(Guarantors);
                    end;
                until LoanG.Next() = 0;
                DataJson.Add('loan_guarantors', GuarantorsArray);
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
            end else begin
                SetResponseStatus(ResponseJson, 'error', 'Error', 'You have not guaranteed any loans');
            end;
        end else begin
            SetResponseStatus(ResponseJson, 'error', 'Error', 'Wrong Identifier Type');
        end;

        ResponseJson.Add(Data, DataJson);
    end;


    local procedure GetLoanswithGuarantors(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        LoanJson: JsonObject;
        LoanObject: JsonObject;
        Guarantors: JsonObject;
        GuarantorsArray: JsonArray;
        GuarantorObject: JsonObject;
        LoanArray: JsonArray;
        Soft: JsonArray;
        IdentifierType: Text;
        Identifier: Text;
        Customer: Record Customer;
        Loans: Record "Loans Register";
        LoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Found: Boolean;
        LoanId: Integer;
        LoanG: Record "Loans Guarantee Details";
        LoansWithGuarantors: Record "Loans Guarantee Details";
        TransactionInitiatorIdentifierType: Text;
        TransactionInitiatorIdentifier: Text;
        TransactionInitiatorAccount: Text;
        TransactionInitiatorName: Text;
        TransactionInitiatorAmount: Decimal;
        TransactionSourceIdentifierType: Text;
        TransactionSourceIdentifier: Text;
        TransactionSourceAccount: Text;
        TransactionSourceName: Text;
        TransactionSourceAmount: Decimal;
        loansG: record "Loans Guarantee Details";
        Members: Record Customer;
        LoanTypes: Record "Loan Products Setup";
        DataArray: JsonArray;
        GuarantorArray: JsonArray;

    begin
        IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
        Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

        Found := false;
        LoanId := 1;

        if IdentifierType = 'MEMBER_NUMBER' then begin
            loanX.Reset();
            LoanX.SetRange(LoanX."Client Code", UpperCase(Identifier));
            if LoanX.FindFirst() then begin
                SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
                repeat
                    LoanX.CalcFields(LoanX."No Of Guarantors", LoanX."No Of Guarantors Needed", LoanX."Has Pending Guarantors");
                    DataJson.Add('loan_id', LoanX."Loan  No.");
                    DataJson.Add('loan_name', LoanX."Loan Product Type");
                    DataJson.Add('amount', Format(LoanX."Approved Amount"));
                    DataJson.Add('status', UpperCase(Format(Loans."Approval Status")));
                    DataJson.Add('number_of_guarantors_added', LoanX."No Of Guarantors");
                    DataJson.Add('number_of_guarantors_needed', LoanX."No Of Guarantors Needed");
                    DataJson.Add('has_pending_guarantors', UpperCase(Format(LoanX."Has Pending Guarantors")));
                    loanG.Reset();
                    LoanG.SetRange(LoanG."Loan No", LoanX."Loan  No.");
                    if LoanG.FindFirst() then begin
                        repeat
                            Members.Reset();
                            Members.SetRange(Members."No.", LoanG."Member No");
                            if Members.FindFirst() then begin
                                Guarantors.Add('guarantor_identifier_type', 'MSISDN/ID/Passport');
                                Guarantors.Add('guarantor_identifier', Members."Mobile Phone No");
                                Guarantors.Add('guarantor_member_number', Members."No.");
                                Guarantors.Add('guarantor_name', Members.Name);
                                Guarantors.Add('amount_guaranteed', Format(LoanG."Amont Guaranteed"));
                                Guarantors.Add('status', UpperCase(Format(LoanG."Acceptance Status")));
                                LoanArray.Add(Guarantors);
                                Clear(Guarantors);
                            end;
                        until LoanG.Next() = 0;

                    end;
                    DataJson.Add('guarantors', LoanArray);
                    Clear(LoanArray);
                    DataArray.Add(DataJson);

                    Clear(DataJson);
                until LoanX.Next() = 0;


            end else
                SetResponseStatus(ResponseJson, 'error', 'Error', 'No Loan found');


        end;

        ResponseJson.Add(Data, DataArray);
    end;

    local procedure BalanceEnquiryATM(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        InstitutionJson: JsonObject;
        InstitutionJsonArr: JsonObject;
        institutionArray: JsonArray;
        AccountJson: JsonObject;
        AccountArray: JsonArray;
        TransactionJson: JsonObject;
        TransactionArray: JsonArray;
        TransactionDate: Text;
        TerminalID: Text;
        AdditionJson: JsonObject;
        AdditionArray: JsonArray;
        Keys: Text;
        Values: Text;
        Keys2: Text;
        Values2: Text;
        Keys3: Text;
        Values3: Text;
        CreditAccount: Text;
        DebitAccount: Text;
        InstitutionCode: text;
        InstitutionName: Text;
        AccountType: Text;
        AccountNumber: Text;
        Customer: Record Customer;
        Vend: Record Vendor;
        LoanResgister: Record "Loans Register";
        Found: Boolean;
        GroupJson: JsonObject;
        MobilePhoneNumber: Text;
        AccountTypes: Record "Account Types-Saving Products";
        MessageId: Text[2048];
        Wrapped: Text[1000];
        SaccoChargeAccount: Code[50];
        GenJournalLine: Record "Gen. Journal Line";
        SaccoGen: Record "Sacco General Set-Up";
        FirstString: Text;
        PosATMCommisons: Record "POS Commissions";
        GLEntry: Record "G/L Entry";
    begin
        InstitutionCode := SelectJsonToken(RequestJson, '$.get_balance_request.institution.institution_code').AsValue.AsText;
        InstitutionName := SelectJsonToken(RequestJson, '$.get_balance_request.institution.institution_name').AsValue.AsText;
        CreditAccount := SelectJsonToken(RequestJson, '$.get_balance_request.account.credit_account').AsValue.AsText;
        DebitAccount := SelectJsonToken(RequestJson, '$.get_balance_request.account.debit_account').AsValue.AsText;
        AdditionArray := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info').AsArray();
        //Keys := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info[0].key').AsValue.AsText;
        // Values := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info[2].value').AsValue.AsText;
        MessageId := SelectJsonToken(RequestJson, '$.message_id').AsValue.AsText;
        TransactionDate := SelectJsonToken(RequestJson, '$.get_balance_request.operation_parameters.transaction_date').AsValue.AsText();
        TerminalID := SelectJsonToken(RequestJson, '$.get_balance_request.operation_parameters.terminal_id').AsValue.AsText;
        // Keys2 := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info[1].key').AsValue.AsText;
        // Values2 := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info[1].value').AsValue.AsText;
        // Keys3 := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info[2].key').AsValue.AsText;
        // Values3 := SelectJsonToken(RequestJson, '$.get_balance_request.additional_info[2].value').AsValue.AsText;
        FirstString := '';
        FirstString := CopyStr(TerminalID, 1, 3);
        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", DebitAccount);
        Vend.SetRange(Vend."Account Type", '103');
        if Vend.FindFirst() then begin

            Vend.CalcFields(Vend.Balance);
            AvailableBalance := 0;
            // AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
            AvailableBalance := Vend.GetAvailableBalance();
            SetResponseStatuss(ResponseJson, MessageId, DebitAccount);
            TransactionJson.Add('transaction_date', Format(TransactionDate));
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);

            InstitutionJson.Add('institution_code', InstitutionCode);
            InstitutionJson.Add('institution_name', InstitutionName);
            DataJson.Add('institution', InstitutionJson);
            Clear(InstitutionJson);


            AccountJson.Add('debit_account', DebitAccount);
            AccountJson.Add('book_balance', AvailableBalance);
            AccountJson.Add('cleared_balance', AvailableBalance);
            AccountJson.Add('currency', 'KES');
            DataJson.Add('account', AccountJson);
            Clear(AccountJson);


            // AdditionJson.Add('key', Keys);
            //AdditionJson.Add('value', Values);
            //AdditionArray.Add(AdditionJson);
            ///Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

            //GroupJson.Add('get_balance_response', DataJson);


            Found := true;

        end;

        Vend.Reset();
        Vend.SetRange(Vend."ATM No.", DebitAccount);
        Vend.SetRange(Vend."Account Type", '103');
        if Vend.FindFirst() then begin

            Vend.CalcFields(Vend.Balance);
            AvailableBalance := 0;
            // AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
            AvailableBalance := Vend.GetAvailableBalance();
            SetResponseStatuss(ResponseJson, MessageId, DebitAccount);
            TransactionJson.Add('transaction_date', Format(TransactionDate));
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);

            InstitutionJson.Add('institution_code', InstitutionCode);
            InstitutionJson.Add('institution_name', InstitutionName);
            DataJson.Add('institution', InstitutionJson);
            Clear(InstitutionJson);


            AccountJson.Add('debit_account', DebitAccount);
            AccountJson.Add('book_balance', AvailableBalance);
            AccountJson.Add('cleared_balance', AvailableBalance);
            AccountJson.Add('currency', 'KES');
            DataJson.Add('account', AccountJson);
            Clear(AccountJson);


            //AdditionJson.Add('key', Keys);
            // AdditionJson.Add('value', Values);
            //AdditionArray.Add(AdditionJson);
            // Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

            //GroupJson.Add('get_balance_response', DataJson);


            Found := true;

            SaccoGen.Get();
            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'MOBILE';
            DOCUMENT_NO := CopyStr(MessageId, 1, 20);
            GenJournalLine.Reset();
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
            if GenJournalLine.FindSet() then begin
                GenJournalLine.DeleteAll();
            end;

            GLEntry.Reset();
            GLEntry.SetRange("Document No.", DOCUMENT_NO);
            if GLEntry.Find('-') = false then begin
                if FirstString = 'ATM' then begin
                    PosATMCommisons.Reset();
                    PosATMCommisons.SetRange("Transaction Type", PosATMCommisons."Transaction Type"::"ATM Balance");
                    if PosATMCommisons.Find('-') then begin
                        if AvailableBalance >= (PosATMCommisons."Sacco charge" + PosATMCommisons."Excise Duty") then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vend."No.", Today, (PosATMCommisons."Sacco charge" + PosATMCommisons."Excise Duty"), 'FOSA', DOCUMENT_NO,
                             'ATM Bal Enq ' + ' ' + Vend."No.", '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", PosATMCommisons."Sacco charge Account", Today, -PosATMCommisons."Sacco charge", 'FOSA', DOCUMENT_NO,
                             'ATM Bal Enq' + ' ' + Vend."No.", '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, -PosATMCommisons."Excise Duty", 'FOSA', DOCUMENT_NO,
                             'Excise Duty ATM bal enq' + ' ' + Vend."No.", '');
                        end;
                    end;
                end;

                if FirstString = 'POS' then begin
                    PosATMCommisons.Reset();
                    PosATMCommisons.SetRange("Transaction Type", PosATMCommisons."Transaction Type"::"POS Balance");
                    if PosATMCommisons.Find('-') then begin
                        if AvailableBalance >= (PosATMCommisons."Sacco charge" + PosATMCommisons."Excise Duty" + PosATMCommisons."Bank charge") then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor, Vend."No.", Today, (PosATMCommisons."Sacco charge" + PosATMCommisons."Excise Duty" + PosATMCommisons."Bank charge"), 'FOSA', DOCUMENT_NO,
                             'POS Bal Enq ' + ' ' + Vend."No.", '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", PosATMCommisons."Sacco charge Account", Today, -PosATMCommisons."Sacco charge", 'FOSA', DOCUMENT_NO,
                             'POS Bal Enq' + ' ' + Vend."No.", '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"Bank Account", PosATMCommisons."Bank charge Account", Today, -PosATMCommisons."Bank charge", 'FOSA', DOCUMENT_NO,
                             'Bank  Charges' + ' ' + Vend."No.", '');

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, -PosATMCommisons."Excise Duty", 'FOSA', DOCUMENT_NO,
                             'Excise Duty POS Bal Enq' + ' ' + Vend."No.", '');
                        end;

                    end;
                end;
                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
            end;

            //end;
            fnInsertatmlogentries('Balance Enquiry', Vend."No.", Vend."ATM No.", '', 0, MessageId, TerminalID, Values,
                Today, '', true, Vend."No.", MessageId, '', '', InstitutionName, InstitutionCode, '', '', '', '', '', '', DOCUMENT_NO);
        end;


        if Found = false then begin
            Vend.CalcFields(Balance);
            SetResponseStatuss(ResponseJson, MessageId, DebitAccount);
            TransactionJson.Add('transaction_date', Format(TransactionDate));
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);

            InstitutionJson.Add('institution_code', InstitutionCode);
            InstitutionJson.Add('institution_name', InstitutionName);
            DataJson.Add('institution', InstitutionJson);
            Clear(InstitutionJson);

            AccountJson.Add('debit_account', DebitAccount);
            AccountJson.Add('book_balance', 0);
            AccountJson.Add('cleared_balance', 0);
            AccountJson.Add('currency', 'KES');
            DataJson.Add('account', AccountJson);
            Clear(AccountJson);


            // AdditionJson.Add('key', Keys);
            //AdditionJson.Add('value', Values);
            //AdditionArray.Add(AdditionJson);
            //Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);
            ResponseJson.Add('get_balance_response', DataJson);
        end;
        if Found = true then begin
            ResponseJson.Add('get_balance_response', DataJson);
        end;
    end;

    local procedure FundsTransferATM(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        InstitutionJson: JsonObject;
        institutionArray: JsonArray;
        AccountJson: JsonObject;
        AccountArray: JsonArray;
        TransactionJson: JsonObject;
        TransactionArray: JsonArray;
        TransactionDate: Text;
        TerminalID: Text;
        AdditionJson: JsonObject;
        AdditionArray: JsonArray;
        OriginalMessageID: Text;
        Keys: Text;
        Values: Text;
        Keys2: Text;
        Values2: Text;
        AvailableBalance: Decimal;
        Keys3: Text;
        Values3: Text;
        CreditAccount: Text;
        DebitAccount: Text;
        InstitutionCode: text;
        InstitutionName: Text;
        AccountType: Text;
        AccountNumber: Text;
        Customer: Record Customer;
        Vend: Record Vendor;
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        Transtype: Text;
        LoanResgister: Record "Loans Register";
        Found: Boolean;
        transCode: Boolean;
        Vends: Record Vendor;
        FOSAAcc: Code[50];
        GroupJson: JsonObject;
        MobilePhoneNumber: Text;
        AccountTypes: Record "Account Types-Saving Products";
        MessageId: Text[2048];
        GenJournalLine: Record "Gen. Journal Line";
        Amount: Decimal;
        ChargeAmount: Decimal;
        FeeAmount: Decimal;
        TransactionType: Text;
        DocumentID: Code[30];
        ATMCharges: Decimal;
        BankCharges: Decimal;
        ExciseFee: Decimal;
        SaccoGen: Record "Sacco General Set-Up";
        TotalCharges: Decimal;
        SaccoCharges: Decimal;
        ChargeDescription: Text;
        BankChargeAccount: code[40];
        SaccoChargeAccount: Code[50];
        ATMlogs: Record "ATM Log Entries3";
        TchargeAmount: Text[40];
        ConcatMessageID: code[50];
        StringCheck: Text;
        GLEntry: Record "G/L Entry";
        AmountToReverse: Decimal;
        DebitAmount: decimal;
        AccoountNo: text[50];
    begin
        InstitutionCode := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.institution.institution_code').AsValue.AsText;
        InstitutionName := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.institution.institution_name').AsValue.AsText;
        CreditAccount := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.posting.credit_account').AsValue.AsText;
        Amount := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.posting.amount').AsValue.AsDecimal;
        ChargeAmount := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.posting.charge_amount').AsValue.AsDecimal;
        FeeAmount := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.posting.fee_amount').AsValue.AsDecimal;
        DebitAccount := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.posting.debit_account').AsValue.AsText;
        AdditionArray := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info').AsArray();
        //Keys := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[0].key').AsValue.AsText;
        //  Values := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[0].value').AsValue.AsText;
        Values := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[2].value').AsValue.AsText;
        MessageId := SelectJsonToken(RequestJson, '$.message_id').AsValue.AsText;
        TransactionDate := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.operation_parameters.transaction_date').AsValue.AsText();
        TransactionType := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.operation_parameters.transaction_type').AsValue.AsText();
        TerminalID := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.operation_parameters.terminal_id').AsValue.AsText;
        OriginalMessageID := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.operation_parameters.original_message_id').AsValue.AsText;
        // Keys2 := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[1].key').AsValue.AsText;
        //Values2 := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[1].value').AsValue.AsText;
        //Keys3 := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[2].key').AsValue.AsText;
        //Values3 := SelectJsonToken(RequestJson, '$.send_funds_transfer_request.additional_info[2].value').AsValue.AsText;
        AccoountNo := '';
        if DebitAccount <> '' then begin
            AccoountNo := DebitAccount;
        end else begin
            AccoountNo := CreditAccount;
        end;

        MessagePresfix := '';
        MessagePresfix := CopyStr(TerminalID, 1, 3);
        SetResponseStatussFunds(ResponseJson, MessageId, AccoountNo, Amount, TransactionType);

        StringCheck := '';
        StringCheck := CopyStr(TerminalID, 1, 3);
        DebitAmount := 0;
        // if (CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, '') = '200') and (FnCheckIfExists(CopyStr(MessageId, 1, 20)) <> true) then begin
        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", DebitAccount);
        Vend.SetRange(Vend."Account Type", '103');
        if Vend.FindFirst() then begin

            Vend.CalcFields(Balance);
            //    AvailableBalance := 0;
            //  AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");

            TransactionJson.Add('transaction_date', Format(TransactionDate));
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            //TransactionArray.Add(TransactionJson);

            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);

            InstitutionJson.Add('institution_code', InstitutionCode);
            //InstitutionJson.Add('institution_name', InstitutionName);
            //institutionArray.Add(InstitutionJson);

            DataJson.Add('institution', InstitutionJson);
            Clear(InstitutionJson);

            AccountJson.Add('debit_account', DebitAccount);
            AccountJson.Add('amount', DELCHR(FORMAT(ChargeAmount), '=', ','));
            AccountJson.Add('cleared_balance', DELCHR(FORMAT(ChargeAmount), '=', ','));
            AccountJson.Add('credit_account', CreditAccount);
            //AccountArray.Add(AccountJson);

            DataJson.Add('posting', AccountJson);
            Clear(AccountJson);

            //AdditionJson.Add('key', Keys);
            // AdditionJson.Add('value', Values);
            // ;
            // AdditionArray.Add(AdditionJson);
            //  Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

            //GroupJson.Add('send_funds_transfer_response', DataJson);

            Found := true;

            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'MOBILE';
            DOCUMENT_NO := CopyStr(MessageId, 1, 20);
            //CheckStatusCode(DOCUMENT_NO);

            GenJournalLine.Reset();
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
            if GenJournalLine.FindSet() then begin
                GenJournalLine.DeleteAll();
            end;

            if (CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, '') = '200') then begin
                if TransactionType = '0001' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'M-PESA B2C' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'M-PESA B2C' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0004' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'KPLC postpaid' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'KPLC postpaid' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0005' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'KPLC prepaid' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'KPLC prepaid' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0006' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'DSTV' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'DSTV' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0007' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'ZUKU' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'ZUKU' + ' ' + Vend."No.", '');
                end;


                if TransactionType = '0008' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Safaricom Airtime purchase' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Safaricom Airtime purchase' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0009' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'PesaLink' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'PesaLink' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0010' then begin
                    //Source Account
                    //if StringCheck ='ATM' THEN begin
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'POS Cash deposit' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'POS Cash deposit' + ' ' + Vend."No.", '');
                    //END;
                end;

                if TransactionType = '0011' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Cash Withdrawal' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Cash Withdrawal' + ' ' + Vend."No.", '');

                    SaccoGen.Get();
                    Pos.Reset();
                    Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"ATM Withdrawal");
                    if Pos.FindFirst() then begin
                        repeat
                            if (ChargeAmount >= Pos."Lower Limit") and (ChargeAmount <= Pos."Upper Limit") then begin
                                ATMCharges := Pos."Total Charge";
                                BankCharges := Pos."Bank charge";
                                ExciseFee := Pos."Excise Duty";
                                SaccoCharges := Pos."Sacco charge";
                                BankChargeAccount := Pos."Bank charge Account";
                                SaccoChargeAccount := Pos."Sacco charge Account";
                            end;
                        until Pos.Next() = 0;
                    end;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, TotalCharges, 'FOSA', DOCUMENT_NO,
                     'ATM Charges' + ' ' + Vend."No.", '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", BankChargeAccount, Today, -BankCharges, 'FOSA', DOCUMENT_NO,
                     'Bank Charges' + ' ' + Vend."No.", '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", SaccoChargeAccount, Today, -SaccoCharges, 'FOSA', DOCUMENT_NO,
                     'Sacco Commissions' + ' ' + Vend."No.", '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, -ExciseFee, 'FOSA', DOCUMENT_NO,
                     'Excise Duty' + ' ' + Vend."No.", '');

                end;


                if TransactionType = '0012' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Cardless ATM withdrawal' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Cardless ATM withdrawal' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0013' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Safaricom C2B' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Safaricom C2B' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0014' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Mini Statement Sacco direct' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Mini Statement Sacco direct' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0015' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Airtel Airtime purchase' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Airtel Airtime purchase' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0016' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Balance Enquiry_Sacco_Direct' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Balance Enquiry_Sacco_Direct' + ' ' + Vend."No.", '');
                end;
                if TransactionType = '0017' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Nairobi water bill payment' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Nairobi water bill payment' + ' ' + Vend."No.", '');
                end;
                if TransactionType = '0018' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Bank Account to sacco account' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Bank Account to sacco account' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0019' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Sacco account to bank account' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Sacco account to bank account' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0020' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Airtel B2C' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Airtel B2Ct' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0021' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'TELKOM B2C' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'TELKOM B2C' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0022' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Sacco account to Virtual Card' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Sacco account to Virtual Card' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0023' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Virtual card to SACCO' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Virtual card to SACCO' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0024' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Sacco to other Sacco' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Sacco to other Sacco' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0025' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Other sacco to Sacco' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Other sacco to Sacco' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0026' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Telkom C2B' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Telkom C2B' + ' ' + Vend."No.", '');
                end;
                if TransactionType = '0027' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'VISA purchases' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'VISA purchases' + ' ' + Vend."No.", '');
                end;

                //Post
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", DOCUMENT_NO);
                if GLEntry.Find('-') = false then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                end;
                FOSAAcc := '';
                Vends.Reset();
                Vends.SetRange(Vends."ATM No.", DebitAccount);
                if Vends.FindFirst() then begin
                    FOSAAcc := Vends."No.";
                end;

                fnInsertatmlogentries('Funds Transfer', FOSAAcc, DebitAccount, '', ChargeAmount, MessageId, TerminalID, Values,
                    Today, TransactionType, true, CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, ''), MessageId, '', '', InstitutionName, InstitutionCode, '', '', '', '', '', TransactionType, DOCUMENT_NO);
            end;
        end;

        Vend.Reset();
        Vend.SetRange(Vend."ATM No.", DebitAccount);
        Vend.SetRange(Vend."Account Type", '103');
        if Vend.FindFirst() then begin
            if (CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, '') = '200') then begin
                DebitAmount := ChargeAmount
            end else begin
                DebitAmount := 0
            end;


            Vend.CalcFields(Balance);


            TransactionJson.Add('transaction_date', Format(TransactionDate));
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            //TransactionArray.Add(TransactionJson);

            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);

            InstitutionJson.Add('institution_code', InstitutionCode);
            //InstitutionJson.Add('institution_name', InstitutionName);
            //institutionArray.Add(InstitutionJson);

            DataJson.Add('institution', InstitutionJson);
            Clear(InstitutionJson);

            AccountJson.Add('debit_account', DebitAccount);
            AccountJson.Add('amount', DELCHR(FORMAT(ChargeAmount), '=', ','));
            AccountJson.Add('cleared_balance', DELCHR(FORMAT(Vend.GetAvailableBalance() - DebitAmount), '=', ','));
            // AccountJson.Add('cleared_balance', DELCHR(FORMAT(Vend.Balance - DebitAmount - 1000), '=', ','));
            AccountJson.Add('credit_account', Format(CreditAccount));
            //AccountArray.Add(AccountJson);

            DataJson.Add('posting', AccountJson);
            Clear(AccountJson);

            // AdditionJson.Add('key', Keys);
            //AdditionJson.Add('value', Values);
            // AdditionArray.Add(AdditionJson);
            //  Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

            //GroupJson.Add('send_funds_transfer_response', DataJson);


            Found := true;


            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'MOBILE';
            DOCUMENT_NO := CopyStr(MessageId, 1, 20);
            GenJournalLine.Reset();
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
            if GenJournalLine.FindSet() then begin
                GenJournalLine.DeleteAll();
            end;
            if (CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, '') = '200') then begin
                transCode := false;
                //Error('Arriving 3 -%1', (CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, '')));
                if TransactionType = '0001' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'M-PESA B2C' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'M-PESA B2C' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0004' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'KPLC postpaid' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'KPLC postpaid' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0005' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'KPLC prepaid' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'KPLC prepaid' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0006' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'DSTV' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'DSTV' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0007' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'ZUKU' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'ZUKU' + ' ' + Vend."No.", '');
                end;


                if TransactionType = '0008' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Safaricom Airtime purchase' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Safaricom Airtime purchase' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0009' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'PesaLink' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'PesaLink' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0010' then begin
                    transCode := true;
                    //Source Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'POS Cash deposit' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'POS Cash deposit' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0011' then begin
                    transCode := true;
                    //Source Account
                    IF StringCheck = 'ATM' THEN BEGIN
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                         'ATM Cash W\d' + ' ' + Vend."No.", '');

                        //Destination Account

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                         'ATM Cash W\d' + ' ' + Vend."No.", '');
                    END;
                    IF StringCheck = 'POS' THEN BEGIN
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                         'POS Cash W\d' + ' ' + Vend."No.", '');

                        //Destination Account

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                         'POS Cash W\d' + ' ' + Vend."No.", '');
                    END;
                    IF (StringCheck <> 'POS') AND (StringCheck <> 'ATM') THEN BEGIN
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                         'VISA Cash W\d' + ' ' + Vend."No.", '');

                        //Destination Account

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                         'VISA Cash W\d' + ' ' + Vend."No.", '');
                    END;

                    SaccoGen.Get();

                    SaccoCharges := 0;
                    BankCharges := 0;
                    ExciseFee := 0;
                    ChargeDescription := '';
                    IF StringCheck = 'ATM' THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', ChargeAmount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', ChargeAmount);
                        Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"ATM Withdrawal");
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Total Charge";
                            BankCharges := Pos."Bank charge";
                            ExciseFee := Pos."Excise Duty";
                            SaccoCharges := Pos."Sacco charge";
                            BankChargeAccount := Pos."Bank charge Account";
                            SaccoChargeAccount := Pos."Sacco charge Account";
                            ChargeDescription := 'ATM';

                        END;
                    END;
                    IF StringCheck = 'POS' THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', ChargeAmount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', ChargeAmount);
                        Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"POS Withdrawal");
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Total Charge";
                            BankCharges := Pos."Bank charge";
                            ExciseFee := Pos."Excise Duty";
                            SaccoCharges := Pos."Sacco charge";
                            BankChargeAccount := Pos."Bank charge Account";
                            SaccoChargeAccount := Pos."Sacco charge Account";
                            ChargeDescription := 'POS';

                        END;
                    END;
                    IF (StringCheck <> 'POS') and (StringCheck <> 'ATM') THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', ChargeAmount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', ChargeAmount);
                        Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"VISA ATM Withdrawal");
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Total Charge";
                            BankCharges := Pos."Bank charge";
                            ExciseFee := Pos."Excise Duty";
                            SaccoCharges := Pos."Sacco charge";
                            BankChargeAccount := Pos."Bank charge Account";
                            SaccoChargeAccount := Pos."Sacco charge Account";
                            ChargeDescription := 'VISA';

                        END;
                    END;

                    //SaccoCharges := ATMCharges - BankCharges;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ATMCharges, 'FOSA', DOCUMENT_NO,
                     ChargeDescription + ' Charges' + ' ' + Vend."No.", '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, -BankCharges, 'FOSA', DOCUMENT_NO,
                     'Bank Charges' + ' ' + Vend."No.", '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", SaccoChargeAccount, Today, -SaccoCharges, 'FOSA', DOCUMENT_NO,
                     'Sacco Commissions' + ' ' + Vend."No.", '');

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, -ExciseFee, 'FOSA', DOCUMENT_NO,
                     'Excise Duty' + ' ' + Vend."No.", '');

                end;


                if TransactionType = '0012' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Cardless ATM withdrawal' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Cardless ATM withdrawal' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0013' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Safaricom C2B' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Safaricom C2B' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0014' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Mini Statement Sacco direct' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Mini Statement Sacco direct' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0015' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Airtel Airtime purchase' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Airtel Airtime purchase' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0016' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Balance Enquiry_Sacco_Direct' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Balance Enquiry_Sacco_Direct' + ' ' + Vend."No.", '');
                end;
                if TransactionType = '0017' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Nairobi water bill payment' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Nairobi water bill payment' + ' ' + Vend."No.", '');
                end;
                if TransactionType = '0018' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Bank Account to sacco account' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Bank Account to sacco account' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0019' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Sacco account to bank account' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Sacco account to bank account' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0020' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Airtel B2C' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Airtel B2Ct' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0021' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'TELKOM B2C' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'TELKOM B2C' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0022' then begin
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Sacco account to Virtual Card' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Sacco account to Virtual Card' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0023' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Virtual card to SACCO' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Virtual card to SACCO' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0024' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Sacco to other Sacco' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Sacco to other Sacco' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0025' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Other sacco to Sacco' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Other sacco to Sacco' + ' ' + Vend."No.", '');
                end;

                if TransactionType = '0026' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'Telkom C2B' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'Telkom C2B' + ' ' + Vend."No.", '');
                end;
                if TransactionType = '0027' then begin
                    transCode := true;
                    //Source Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount, 'FOSA', DOCUMENT_NO,
                     'VISA Purchase' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                     'VISA Purchase' + ' ' + Vend."No.", '');
                end;


                //Post
                if transCode = true then begin
                    GLEntry.Reset();
                    GLEntry.SetRange("Document No.", DOCUMENT_NO);
                    if GLEntry.Find('-') = false then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                    end;

                    FOSAAcc := '';
                    Vends.Reset();
                    Vends.SetRange(Vends."ATM No.", DebitAccount);
                    if Vends.FindFirst() then begin
                        FOSAAcc := Vends."No.";
                    end;

                    fnInsertatmlogentries('Funds Transfer', FOSAAcc, DebitAccount, '', Amount, MessageId, TerminalID, Values,
                    Today, TransactionType, true, CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, ''), MessageId, '', '', InstitutionName, InstitutionCode, '', '', '', '', ChargeDescription, TransactionType, DOCUMENT_NO);
                    Message2 := 'Dear ' + Bname.NameStyle(Vend."BOSA Account No") + ', Cash withdrawal of ' + Format(ChargeAmount) + ' has been processed at ' + Format(CurrentDateTime) + ' Successfully.';
                    SMSCodeunit.SendSmsWithID(Source::CASH_WITHDRAWAL_CONFIRM, Vend."Mobile Phone No", Message2, Customer."No.", Vend."No.", true, 211, true, 'CBS', CreateGuid(), 'CBS');
                end;
            end;
        end;

        if CreditAccount <> '' then begin
            Vend.Reset();
            Vend.SetRange(Vend."ATM No.", CreditAccount);
            Vend.SetRange(Vend."Account Type", '103');
            if Vend.FindFirst() then begin
                Vend.CalcFields(Balance);

                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'MOBILE';
                DOCUMENT_NO := CopyStr(MessageId, 1, 20);
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll();
                end;

                if TransactionType = '0010' then begin
                    //Source Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, Vend."No.", Today, ChargeAmount * -1, 'FOSA', DOCUMENT_NO,
                    'POS Cash deposit' + ' ' + Vend."No.", '');

                    //Destination Account

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, ChargeAmount * 1, 'FOSA', DOCUMENT_NO,
                    'POS Cash deposit' + ' ' + Vend."No.", '');
                end;
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", DOCUMENT_NO);
                if GLEntry.Find('-') = false then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                end;
                //  SMSCodeunit.SendSmsWithID(Source::DEPOSIT_CONFIRMATION,Vend."Mobile Phone No",Message2)
                Message2 := 'Dear ' + Bname.NameStyle(Vend."BOSA Account No") + ', Cash deposit of ' + Format(ChargeAmount) + ' has been received on ' + Format(CurrentDateTime) + ' ."A penny saved is a penny earned"';
                SMSCodeunit.SendSmsWithID(Source::CASH_WITHDRAWAL_CONFIRM, Vend."Mobile Phone No", Message2, Customer."No.", Vend."No.", true, 211, true, 'CBS', CreateGuid(), 'CBS');

                FOSAAcc := '';
                Vends.Reset();
                Vends.SetRange(Vends."ATM No.", DebitAccount);
                if Vends.FindFirst() then begin
                    FOSAAcc := Vends."No.";
                end;
                fnInsertatmlogentries('Funds Transfer', FOSAAcc, DebitAccount, '', Amount, MessageId, TerminalID, Values,
                Today, TransactionType, true, CheckStatusCodeTransfer(DebitAccount, ChargeAmount, TransactionType, ''), MessageId, '', '', InstitutionName, InstitutionCode, '', '', '', '', ChargeDescription, TransactionType, DOCUMENT_NO);
            end;
        end;

        if (TransactionType = '1420') and (CheckMessageIDIfExists(MessageId) = true) then begin
            ConcatMessageID := CopyStr(MessageId, 1, 20);
            Transtype := '';
            AmountToReverse := 0;
            VendorAccountNo := '';
            ReversalDescription := '';
            ATMlogs.Reset();
            ATMlogs.SetRange("Message ID", OriginalMessageID);
            ATMlogs.SetRange(Reversed, false);
            ATMlogs.SetFilter("Transaction Code", '<>%1', '1420');
            if ATMlogs.FindFirst() then begin
                SaccoGen.Get();
                Transtype := ATMlogs."Terminal ID";

                SaccoCharges := 0;
                BankCharges := 0;
                ExciseFee := 0;
                if ATMlogs."Transaction Code" = '0011' then begin
                    IF Transtype = 'ATM' THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', ChargeAmount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', ChargeAmount);
                        Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"ATM Withdrawal");
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Total Charge";
                            BankCharges := Pos."Bank charge";
                            ExciseFee := Pos."Excise Duty";
                            SaccoCharges := Pos."Sacco charge";
                            BankChargeAccount := Pos."Bank charge Account";
                            SaccoChargeAccount := Pos."Sacco charge Account";
                            ChargeDescription := 'ATM';

                        END;
                    END;
                    IF Transtype = 'POS' THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', ChargeAmount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', ChargeAmount);
                        Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"POS Withdrawal");
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Total Charge";
                            BankCharges := Pos."Bank charge";
                            ExciseFee := Pos."Excise Duty";
                            SaccoCharges := Pos."Sacco charge";
                            BankChargeAccount := Pos."Bank charge Account";
                            SaccoChargeAccount := Pos."Sacco charge Account";
                            ChargeDescription := 'POS';

                        END;
                    END;
                    IF Transtype = 'VISA' THEN BEGIN
                        Pos.RESET;
                        Pos.SETFILTER(Pos."Lower Limit", '<=%1', ChargeAmount);
                        Pos.SETFILTER(Pos."Upper Limit", '>=%1', ChargeAmount);
                        Pos.SetRange(Pos."Transaction Type", Pos."Transaction Type"::"VISA ATM Withdrawal");
                        IF Pos.FINDFIRST THEN BEGIN
                            ATMCharges := Pos."Total Charge";
                            BankCharges := Pos."Bank charge";
                            ExciseFee := Pos."Excise Duty";
                            SaccoCharges := Pos."Sacco charge";
                            BankChargeAccount := Pos."Bank charge Account";
                            SaccoChargeAccount := Pos."Sacco charge Account";
                            ChargeDescription := 'VISA';

                        END;
                    END;
                end;
                DetailedVendorLedgerEntry.Reset();
                DetailedVendorLedgerEntry.SetRange("Document No.", CopyStr(OriginalMessageID, 1, 20));
                if DetailedVendorLedgerEntry.Find('-') then begin
                    AmountToReverse := Abs(DetailedVendorLedgerEntry.Amount);
                    VendorAccountNo := DetailedVendorLedgerEntry."Vendor No.";
                    ReversalDescription := DetailedVendorLedgerEntry.Description;
                end;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, VendorAccountNo, Today, ATMCharges * -1, 'FOSA', DOCUMENT_NO,
                 ChargeDescription + ' Charges_Reversal' + ' ' + VendorAccountNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", BankChargeAccount, Today, BankCharges, 'FOSA', DOCUMENT_NO,
                 'Bank Charges -Reversal' + ' ' + VendorAccountNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoChargeAccount, Today, SaccoCharges, 'FOSA', DOCUMENT_NO,
                 'Sacco Commissions-Reversal' + ' ' + VendorAccountNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, ExciseFee, 'FOSA', DOCUMENT_NO,
                 'Excise Duty - Reversal' + ' ' + VendorAccountNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, VendorAccountNo, Today, (AmountToReverse) * -1, 'FOSA', DOCUMENT_NO,
                 ChargeDescription + ' Reversal' + ' ' + VendorAccountNo, '');

                //Destination Account

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"Bank Account", 'BNK00008', Today, AmountToReverse * 1, 'FOSA', DOCUMENT_NO,
                 ChargeDescription + ' Reversal' + ' ' + VendorAccountNo, '');

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;

                ATMlogs.Reversed := true;
                ATMlogs.Modify;

                FOSAAcc := '';
                Vends.Reset();
                Vends.SetRange(Vends."ATM No.", DebitAccount);
                if Vends.FindFirst() then begin
                    FOSAAcc := Vends."No.";
                end;

                Message2 := 'Dear ' + Bname.NameStyle(Vends."BOSA Account No") + ', Your ATM transaction of ' + Format(ChargeAmount) + ' has been reversed ' + Format(CurrentDateTime);
                SMSCodeunit.SendSmsWithID(Source::CASH_WITHDRAWAL_CONFIRM, Vend."Mobile Phone No", Message2, Customer."No.", Vend."No.", true, 211, true, 'CBS', CreateGuid(), 'CBS');

                fnInsertatmlogentries('Reversal', FOSAAcc, DebitAccount, '', Amount, MessageId, TerminalID, VALUES,
                Today, TransactionType, true, Vend."No.", MessageId, '', '', InstitutionName, InstitutionCode, '', '', '', '', Transtype, TransactionType, DOCUMENT_NO);
                Cust.get(Vend."BOSA Account No");
                //end;
            end;

        end;
        if CheckStatusCodeTransfer(DebitAccount, Amount, TransactionType, '') <> '200' then begin
            // TransactionJson.
            // TransactionJson.Add('transaction_date', Format(TransactionDate));
            // TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            // //TransactionArray.Add(TransactionJson);

            // DataJson.Add('operation_parameters', TransactionJson);
            // Clear(TransactionJson);

            // InstitutionJson.Add('institution_code', InstitutionCode);
            // //InstitutionJson.Add('institution_name', InstitutionName);
            // //institutionArray.Add(InstitutionJson);

            // DataJson.Add('institution', InstitutionJson);
            // Clear(InstitutionJson);

            // AccountJson.Add('debit_account', DebitAccount);
            // AccountJson.Add('amount', 0);
            // AccountJson.Add('cleared_balance', 0);
            // AccountJson.Add('credit_account', CreditAccount);
            // //AccountArray.Add(AccountJson);

            // DataJson.Add('posting', AccountJson);
            // Clear(AccountJson);

            // AdditionJson.Add('key', Keys);
            // AdditionJson.Add('value', Values);
            // AdditionArray.Add(AdditionJson);
            // Clear(AdditionJson);
            // DataJson.Add('additional_info', AdditionArray);

            // // SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
        end;

        ResponseJson.Add('send_funds_transfer_response', DataJson);
    end;



    local procedure MiniStatementATM(RequestJson: JsonObject) ResponseJson: JsonObject
    var
        DataJson: JsonObject;
        InstitutionJson: JsonObject;
        institutionArray: JsonArray;
        AccountJson: JsonObject;
        AccountArray: JsonArray;
        TransactionJson: JsonObject;
        TransactionArray: JsonArray;
        TransactionDate: Text;
        TerminalID: Text;
        AdditionJson: JsonObject;
        AdditionArray: JsonArray;
        Keys: Text;
        Values: Text;
        Keys2: Text;
        Values2: Text;
        Keys3: Text;
        Values3: Text;
        CreditAccount: Text;
        DebitAccount: Text;
        InstitutionCode: text;
        InstitutionName: Text;
        AccountType: Text;
        AccountNumber: Text;
        SavLedger: record "Detailed Vendor Ledg. Entry";
        Customer: Record Customer;
        Vend: Record Vendor;
        TransactionObject: JsonObject;
        LoanResgister: Record "Loans Register";
        Found: Boolean;
        GroupJson: JsonObject;
        MobilePhoneNumber: Text;
        AccountTypes: Record "Account Types-Saving Products";
        MessageId: Text[2000];
        Iterator: Integer;
        NumberOfTransactions: Integer;
        TransactionsArray: JsonArray;
        Amounts: Decimal;
        charge: Decimal;
        DateFormat: Text;
        AvailableBalance: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        SaccoGen: Record "Sacco General Set-Up";
    begin
        InstitutionCode := SelectJsonToken(RequestJson, '$.ministatement_request.institution.institution_code').AsValue.AsText;
        //InstitutionName := SelectJsonToken(RequestJson, '$.ministatement_request.institution.institution_name').AsValue.AsText;
        CreditAccount := SelectJsonToken(RequestJson, '$.ministatement_request.account.credit_account').AsValue.AsText;
        DebitAccount := SelectJsonToken(RequestJson, '$.ministatement_request.account.debit_account').AsValue.AsText;
        AdditionArray := SelectJsonToken(RequestJson, '$.ministatement_request.additional_info').AsArray();
        Keys := SelectJsonToken(RequestJson, '$.ministatement_request.additional_info[2].key').AsValue.AsText;
        Values := SelectJsonToken(RequestJson, '$.ministatement_request.additional_info[2].value').AsValue.AsText;
        MessageId := SelectJsonToken(RequestJson, '$.message_id').AsValue.AsText;
        NumberOfTransactions := SelectJsonToken(RequestJson, '$.ministatement_request.operation_parameters.max_number_rows').AsValue.AsInteger();
        TransactionDate := SelectJsonToken(RequestJson, '$.ministatement_request.operation_parameters.transaction_date').AsValue.AsText();
        //Keys2 := SelectJsonToken(RequestJson, '$.ministatement_request.additional_info.key').AsValue.AsText;
        //Values2 := SelectJsonToken(RequestJson, '$.ministatement_request.additional_info.value').AsValue.AsText;
        Found := false;
        //Error();

        charge := 0;
        Vend.Reset();
        Vend.SetRange(Vend."BOSA Account No", DebitAccount);
        Vend.SetRange(Vend."Account Type", '103');
        if Vend.FindFirst() then begin
            AccountTypes.Get('103');
            AvailableBalance := 0;
            Vend.CalcFields(Vend.Balance);
            AvailableBalance := Vend.Balance - ((Vend."Uncleared Cheques" - Vend."Cheque Discounted Amount") + Vend."ATM Transactions" + Vend."EFT Transactions" + 1000 + Vend."Mobile Transactions" + Vend."Amount to freeze");
            Iterator := 0;
            SavLedger.Reset();
            SavLedger.SetRange(SavLedger."Vendor No.", Vend."No.");
            if SavLedger.FindFirst() then
                repeat

                    SavLedger.CalcFields(SavLedger.Description);
                    TransactionObject.Add('transaction_date', SavLedger."Posting Date");
                    TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
                    TransactionObject.Add('debit_credit_flag', 'DR');
                    TransactionObject.Add('amount', SavLedger.Amount);
                    TransactionObject.Add('narration', 'Withdrwal at ATM');
                    TransactionObject.Add('posting_date', SavLedger."Posting Date");
                    TransactionObject.Add('book_balance', Vend."Net Change (LCY)");
                    TransactionObject.Add('cleared_running_balance', Vend."Net Change");
                    TransactionObject.Add('channel_id', '23');
                    TransactionObject.Add('account_name', AccountTypes.Description);
                    TransactionObject.Add('account_number', Vend."No.");
                    if Iterator < NumberOfTransactions then
                        TransactionsArray.Add(TransactionObject);
                    Clear(TransactionObject);
                    Iterator := Iterator + 1;
                until SavLedger.Next() = 0;

            DataJson.Add('account_transactions', TransactionsArray);


            Vend.CalcFields(Balance);
            SetResponseStatuss(ResponseJson, MessageId, DebitAccount);
            TransactionJson.Add('transaction_date', Format(TransactionDate));
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            //TransactionArray.Add(TransactionJson);

            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);
            // AdditionJson.Add('key', Keys);
            // AdditionJson.Add('value', Values);
            //AdditionArray.Add(AdditionJson);
            // Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

            //GroupJson.Add('get_balance_response', DataJson);


            Found := true;

        end;

        Vend.Reset();
        Vend.SetRange(Vend."ATM No.", DebitAccount);
        Vend.SetRange(Vend."Account Type", '103');
        Vend.SetAutoCalcFields(Balance, "Balance (LCY)", "Net Change");
        if Vend.FindFirst() then begin
            AccountTypes.Get('103');
            Iterator := 0;
            SavLedger.Reset();
            SavLedger.SetCurrentKey("Entry No.");
            SavLedger.SetRange(SavLedger."Vendor No.", Vend."No.");
            SavLedger.SetAscending("Entry No.", false);
            if SavLedger.FindSet() then
                repeat

                    DateFormat := Format(SavLedger."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');

                    SavLedger.CalcFields(SavLedger.Description);
                    Amounts := 0;
                    if SavLedger.Amount < 0 then
                        Amounts := SavLedger.Amount * -1
                    else
                        Amounts := SavLedger.Amount;
                    TransactionObject.Add('transaction_date', DateFormat + 'T00:00:00');
                    TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
                    TransactionObject.Add('debit_credit_flag', Amounts);
                    TransactionObject.Add('amount', Amounts);
                    TransactionObject.Add('narration', SavLedger.Description);
                    TransactionObject.Add('posting_date', DateFormat + 'T00:00:00');
                    TransactionObject.Add('book_balance', Vend."Net Change" - Amounts);
                    TransactionObject.Add('cleared_running_balance', Vend."Net Change" - Amounts);
                    TransactionObject.Add('channel_id', '23');
                    TransactionObject.Add('account_name', AccountTypes.Description);
                    TransactionObject.Add('account_number', Vend."No.");
                    if Iterator < NumberOfTransactions then
                        TransactionsArray.Add(TransactionObject);
                    Clear(TransactionObject);
                    Iterator := Iterator + 1;
                until SavLedger.Next() = 0;

            DataJson.Add('account_transactions', TransactionsArray);


            Vend.CalcFields(Balance);
            SetResponseStatuss(ResponseJson, MessageId, DebitAccount);
            TransactionJson.Add('transaction_date', DateFormat + 'T00:00:00');
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            //TransactionArray.Add(TransactionJson);

            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);
            //AdditionJson.Add('key', Keys);
            //AdditionJson.Add('value', Values);
            //AdditionArray.Add(AdditionJson);
            // Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

            //GroupJson.Add('get_balance_response', DataJson);


            Found := true;

            SaccoGen.Get();
            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'MOBILE';
            DOCUMENT_NO := CopyStr(MessageId, 1, 20);
            GenJournalLine.Reset();
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
            if GenJournalLine.FindSet() then begin
                GenJournalLine.DeleteAll();
            end;

            if AvailableBalance >= (SaccoGen."Balance Enquiry Charge" + (SaccoGen."Balance Enquiry Charge" * SaccoGen."Excise Duty(%)" / 100)) then begin

                charge := (SaccoGen."Balance Enquiry Charge" + (SaccoGen."Balance Enquiry Charge" * SaccoGen."Excise Duty(%)" / 100));
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, Vend."No.", Today, (SaccoGen."Balance Enquiry Charge" + (SaccoGen."Balance Enquiry Charge" * SaccoGen."Excise Duty(%)" / 100)), 'FOSA', DOCUMENT_NO,
                 'Balance Enquiry ' + ' ' + Vend."No.", '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoGen."Balance Enquiry Charge Account", Today, -SaccoGen."Balance Enquiry Charge", 'FOSA', DOCUMENT_NO,
                 'Balance Enquiry' + ' ' + Vend."No.", '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", SaccoGen."Excise Duty Account", Today, -(SaccoGen."Balance Enquiry Charge" * SaccoGen."Excise Duty(%)" / 100), 'FOSA', DOCUMENT_NO,
                 'Excise Duty Sacco Charges' + ' ' + Vend."No.", '');

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
            end;
            fnInsertatmlogentries('Balance Enquiry', Vend."No.", Vend."ATM No.", '', charge, MessageId, TerminalID, Values,
            Today, '', true, Vend."No.", MessageId, '', '', InstitutionName, InstitutionCode, '', '', '', '', '', '', DOCUMENT_NO);

        end;

        if Found = false then begin
            TransactionObject.Add('transaction_date', format(SavLedger."Posting Date") + 'T00:00:00');
            TransactionObject.Add('transaction_reference', Format(SavLedger."Entry No."));
            TransactionObject.Add('debit_credit_flag', 'DR');
            TransactionObject.Add('amount', 0);
            TransactionObject.Add('narration', 'Withdrwal at ATM');
            TransactionObject.Add('posting_date', Format(SavLedger."Posting Date") + 'T00:00:00');
            TransactionObject.Add('book_balance', 0);
            TransactionObject.Add('cleared_running_balance', 0);
            TransactionObject.Add('channel_id', '23');
            TransactionObject.Add('account_name', AccountTypes.Description);
            TransactionObject.Add('account_number', Vend."No.");
            TransactionsArray.Add(TransactionObject);
            //Clear(TransactionObject);
            DataJson.Add('account_transactions', TransactionsArray);
            Vend.CalcFields(Balance);
            SetResponseStatuss(ResponseJson, MessageId, DebitAccount);
            TransactionJson.Add('transaction_date', format(TransactionDate) + 'T00:00:00');
            TransactionJson.Add('transaction_reference', 'REF_' + MessageId);
            //TransactionArray.Add(TransactionJson);

            DataJson.Add('operation_parameters', TransactionJson);
            Clear(TransactionJson);

            InstitutionJson.Add('institution_code', InstitutionCode);
            DataJson.Add('institution', InstitutionJson);
            Clear(InstitutionJson);

            //AdditionJson.Add('key', Keys);
            //AdditionJson.Add('value', Values);
            //AdditionArray.Add(AdditionJson);
            // Clear(AdditionJson);
            DataJson.Add('additional_info', AdditionArray);

        end;

        ResponseJson.Add('ministatement_response', DataJson);
    end;


    local procedure CheckResponseStatus(Identifier: Code[40]) Response: Code[100];
    var
        Vendors: Record Vendor;
        Found: Boolean;
    begin
        Found := false;
        Vendors.Reset();
        Vendors.SetRange(Vendors."BOSA Account No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin

            Found := true;
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."Mobile Phone No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
        end;
        Vendors.Reset();
        Vendors.SetRange(Vendors."ATM No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
        end;
        Vendors.Reset();
        Vendors.SetRange(Vendors."No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
        end;
        IF Found = true then begin
            Response := 'SUCCESS';
        end;

        IF Found = false then begin
            Response := 'FAILED';
        end;


    end;

    local procedure CheckResponseStatusFundsTransfer(Identifier: Code[40]; Amount: Decimal; TransactionType: Text[40]; MessageID: Text) Response: Code[100];
    var
        Vendors: Record Vendor;
        Found: Boolean;
        TransactionTypeFound: Boolean;
        GLEntry: Record "G/L Entry";
        atmLogs: Record "ATM Log Entries3";
    begin
        Found := false;
        Vendors.Reset();
        Vendors.SetRange(Vendors."BOSA Account No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Vendors.CalcFields(Vendors.Balance);
            AvailableBalance := 0;
            AvailableBalance := Vendors.GetAvailableBalance();
            if Amount < AvailableBalance then
                Found := true
            else
                Found := false;
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."Mobile Phone No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        //Vendors.SetAutoCalcFields(Balance);
        if Vendors.FindFirst() then begin
            Vendors.CalcFields(Vendors.Balance);
            AvailableBalance := 0;
            AvailableBalance := Vendors.GetAvailableBalance();
            if Amount < AvailableBalance then
                Found := true
            else
                Found := false;
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."ATM No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        //Vendors.SetAutoCalcFields(Balance);
        if Vendors.FindFirst() then begin
            Vendors.CalcFields(Vendors.Balance);
            AvailableBalance := 0;
            AvailableBalance := Vendors.GetAvailableBalance();
            if Amount < AvailableBalance then
                Found := true
            else
                Found := false;
        end;
        TransactionTypeFound := false;
        if TransactionType = '0001' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0004' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0005' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0006' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0007' then begin
            TransactionTypeFound := true;
        end;


        if TransactionType = '0008' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0009' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0010' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0011' then begin
            TransactionTypeFound := true;
        end;


        if TransactionType = '0012' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0013' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0014' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0015' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0016' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '0017' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '0018' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0019' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0020' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0021' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0022' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0023' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0024' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0025' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0026' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '0027' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '1420' then begin
            TransactionTypeFound := true;
        end;




        IF (Found = true) and (TransactionTypeFound = true) then begin
            Response := 'SUCCESS';
        end;

        IF (Found = false) or (TransactionTypeFound = false) then begin
            Response := 'FAILED';
        end;

        GLEntry.Reset();
        GLEntry.SetRange("Document No.", CopyStr(MessageID, 1, 20));
        if GLEntry.Find('-') then begin
            atmLogs.Reset();
            atmLogs.SetRange("Message ID", MessageID);
            atmLogs.SetRange(Reversed, true);
            if atmLogs.Find('-') then begin
                Response := 'Duplicate transaction';
            end else
                Response := 'SUCCESS';
        end;
    end;

    local procedure CheckStatusCode(Identifier: Code[40]) StatusCode: Code[40];
    var
        Vendors: Record Vendor;
        Vendor: Record Vendor;
        Found: Boolean;
        GLEntry: Record "G/L Entry";
    begin
        Found := false;
        StatusCode := '';
        Vendors.Reset();
        Vendors.SetRange(Vendors."BOSA Account No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '200';
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."Mobile Phone No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '200';
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."ATM No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '200';
        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."Mobile Phone No", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Frozen);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            Found := true;
            StatusCode := '401';

        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Frozen);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            Found := true;
            StatusCode := '401';

        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."Mobile Phone No", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Pending);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Pending);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;
        GLEntry.Reset();
        GLEntry.SetRange("Document No.", Identifier);
        if GLEntry.Find('-') then begin
            Found := true;
            StatusCode := '500';
        end;


        /// IF Found = true then begin
        //  StatusCode := StatusCode;
        // end;

        IF Found = false then begin
            StatusCode := '300';
        end;
    end;

    local procedure CheckStatusCodeTransfer(Identifier: Code[40]; Amount: Decimal; TransactionType: Text; MessageID: Text) StatusCode: Code[40];
    var
        Vendors: Record Vendor;
        Vendor: Record Vendor;
        Found: Boolean;
        TransactionTypeFound: Boolean;
        GLEntry: Record "G/L Entry";
        atmLogs: Record "ATM Log Entries3";
    begin
        Found := false;
        StatusCode := '';
        Vendors.Reset();
        Vendors.SetRange(Vendors."BOSA Account No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            Vendors.CalcFields(Vendors.Balance);
            if TransactionType = '0010' then begin
                StatusCode := '200'
            end else begin
                AvailableBalance := 0;
                AvailableBalance := Vendors.GetAvailableBalance();
                if Amount < AvailableBalance then begin
                    StatusCode := '200'
                end else begin
                    StatusCode := '402';
                end;
            end;

        end;


        Vendors.Reset();
        Vendors.SetRange(Vendors."Mobile Phone No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            Vendors.CalcFields(Vendors.Balance);
            AvailableBalance := 0;
            AvailableBalance := Vendors.GetAvailableBalance();
            if Amount < AvailableBalance then begin
                StatusCode := '200'
            end else begin
                StatusCode := '402';
            end;
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."ATM No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Active);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            if TransactionType = '0010' then begin
                StatusCode := '200'
            end else begin
                Vendors.CalcFields(Vendors.Balance);
                AvailableBalance := 0;
                AvailableBalance := Vendors.GetAvailableBalance();
                if Amount < AvailableBalance then begin
                    StatusCode := '200'
                end else begin
                    StatusCode := '402';
                end;
            end;
            GLEntry.Reset();
            GLEntry.SetRange("Document No.", CopyStr(MessageID, 1, 20));
            if GLEntry.Find('-') then begin
                atmLogs.Reset();
                atmLogs.SetRange("Message ID", MessageID);
                atmLogs.SetRange(Reversed, true);
                if atmLogs.Find('-') then begin
                    StatusCode := '500';
                end;
            end;
        end;


        Vendors.Reset();
        Vendors.SetRange(Vendors."BOSA Account No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Frozen);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."ATM No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Frozen);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."Mobile Phone No", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Frozen);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        Vendors.Reset();
        Vendors.SetRange(Vendors."ATM No.", Identifier);
        Vendors.SetRange(Vendors."Card Status", Vendors."Card Status"::Frozen);
        Vendors.SetRange(Vendors."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."Mobile Phone No", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Pending);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendors.FindFirst() then begin
            Found := true;
            StatusCode := '401';
            // Error('StatusCode%1AccountNo%2', StatusCode,Vendor."No.");
        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Pending);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        Vendor.Reset();
        Vendor.SetRange(Vendor."ATM No.", Identifier);
        Vendor.SetRange(Vendor."Card Status", Vendor."Card Status"::Pending);
        Vendor.SetRange(Vendor."Account Type", '103');
        if Vendor.FindFirst() then begin
            Found := true;
            StatusCode := '401';
        end;

        /// IF Found = true then begin
        //  StatusCode := StatusCode;
        // end;
        TransactionTypeFound := false;
        if TransactionType = '0001' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0004' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0005' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0006' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0007' then begin
            TransactionTypeFound := true;
        end;


        if TransactionType = '0008' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0009' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0010' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0011' then begin
            TransactionTypeFound := true;
        end;


        if TransactionType = '0012' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0013' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0014' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0015' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0016' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '0017' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '0018' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0019' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0020' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0021' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0022' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0023' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0024' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0025' then begin
            TransactionTypeFound := true;
        end;

        if TransactionType = '0026' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '0027' then begin
            TransactionTypeFound := true;
        end;
        if TransactionType = '1420' then begin
            TransactionTypeFound := true;
        end;

        IF Found = false then begin
            StatusCode := '300';
        end;

        if TransactionTypeFound = false then begin
            StatusCode := '404';
        end;
    end;

    local procedure FnCheckIfExists(PaybillCode: Code[40]) Response: Boolean;
    var
        BankAccL: Record "Detailed Vendor Ledg. Entry";
    begin
        Response := false;
        BankAccL.Reset();
        BankAccL.SetRange(BankAccL."Document No.", PaybillCode);
        BankAccL.SetRange(BankAccL.Reversed, false);
        if BankAccL.FindFirst() then begin
            Response := true;
        end;
        exit(Response);
    end;

    Procedure fnInsertatmlogentries(messageType: Text[50]; accountID: Code[50]; atmNo: Code[20]; authCode: Code[50]; amount: Decimal; reference: Code[200]; terminalID: Code[50]; TerminalLocation: Code[1024]; RequestDate: Date; ResponseCode: Code[10]; Posted: Boolean;
        AccountN: Code[250]; MessageID: Text[500]; Code: Code[10]; Description: Text[250]; institutionname: Text[100]; institutioncode: Text[100]; channel: Code[50]; connectionmode: Code[100]; Narration1: Text[250]; Narration2: Text[250]; TerminalID2: text[28]; TransactionCode: code[20]; docNo: Code[20]) result: Boolean
    var
        AtmLog: Record "ATM Log Entries3";
        EntryNo: Integer;

    begin
        EntryNo := 0;

        IF AtmLog.FIND('+') then
            EntryNo := AtmLog."Entry No" + 1
        else
            EntryNo := 1;

        AtmLog.RESET;
        AtmLog.SETRANGE(AtmLog."Reference No", Reference);
        IF AtmLog.FIND('-') = FALSE THEN BEGIN
            AtmLog.INIT;
            AtmLog."Date Time" := CURRENTDATETIME;
            AtmLog."Account No" := AccountID;
            AtmLog."ATM No" := AtmNo;
            AtmLog.Amount := Amount;
            AtmLog."Entry No" := EntryNo;
            AtmLog."ATM Amount" := Amount;
            AtmLog."ATM Location" := TerminalID;
            AtmLog."Card No." := AtmNo;
            AtmLog."Reference No" := Reference;
            AtmLog."Trace ID" := Reference;
            AtmLog."Withdrawal Location" := TerminalLocation;
            AtmLog."Return Code" := Code;
            AtmLog."Code Description" := Description;
            if TransactionCode = '0001' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"MPESA B2C";
            end else if TransactionCode = '0004' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"KPLC PostPaid";
            end else if TransactionCode = '0005' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"KPLC Prepaid";
            end else if TransactionCode = '0006' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::DSTV;
            end else if TransactionCode = '0007' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::ZUKU;
            end else if TransactionCode = '0008' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Safaricom Airtime Purchase";
            end else if TransactionCode = '0009' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::Pesalink;
            end else if TransactionCode = '0010' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"POS Cash deposit";
            end else if TransactionCode = '0011' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cash Withdrawal";
            end else if TransactionCode = '0012' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cardless ATM withdrawal";
            end else if TransactionCode = '0013' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Safaricom C2B";
            end else if TransactionCode = '0014' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Ministatement Sacco direct";
            end else if TransactionCode = '0015' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Airtel Airtime purchase";
            end else if TransactionCode = '0016' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Balance Enquiry_Sacco_Direct";
            end else if TransactionCode = '0017' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Nairobi water bill payment";
            end else if TransactionCode = '0018' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Bank Account to sacco account";
            end else if TransactionCode = '0019' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Sacco account to bank account";
            end else if TransactionCode = '0020' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Airtel B2C";
            end else if TransactionCode = '0021' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"TELKOM B2C";
            end else if TransactionCode = '0022' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Sacco account to Virtual Card";
            end else if TransactionCode = '0023' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Virtual card to SACCO";
            end else if TransactionCode = '0024' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Sacco to other Sacco";
            end else if TransactionCode = '0025' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Other sacco to Sacco";
            end else if TransactionCode = '0026' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"TELCOM C2B";
            end else if TransactionCode = '0027' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"VISA Cash withdrawal";
            end else if TransactionCode = '1420' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::Reversal;
            end else begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Balance Enquiry_Sacco_Direct";
            end;
            AtmLog."institution Name" := institutionname;
            AtmLog."Institutional code" := institutioncode;
            AtmLog.Channel := channel;
            AtmLog."Connection Mode" := MessageType;
            AtmLog.Narrative1 := Narration1;
            AtmLog."Narrative2" := Narration2;
            AtmLog."Message ID" := MessageID;
            AtmLog."Terminal ID" := TerminalID2;
            AtmLog."Transaction Code" := TransactionCode;
            // AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cash Withdrawal";
            AtmLog."Code Description" := '';
            AtmLog."Bank Doc_No" := docNo;
            AtmLog.INSERT;
        END;

        AtmLog.RESET;
        AtmLog.SETRANGE(AtmLog."Reference No", Reference);
        AtmLog.SetRange(Reversed, true);
        IF AtmLog.FIND('-') THEN BEGIN
            AtmLog.INIT;
            AtmLog."Date Time" := CURRENTDATETIME;
            AtmLog."Account No" := AccountID;
            AtmLog."ATM No" := AtmNo;
            AtmLog.Amount := Amount;
            AtmLog."Entry No" := EntryNo;
            AtmLog."ATM Amount" := Amount;
            AtmLog."ATM Location" := TerminalID;
            AtmLog."Card No." := AtmNo;
            AtmLog."Reference No" := Reference;
            AtmLog."Trace ID" := Reference;
            AtmLog."Withdrawal Location" := TerminalLocation;
            AtmLog."Return Code" := Code;
            AtmLog."Code Description" := Description;
            if TransactionCode = '0001' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"MPESA B2C";
            end else if TransactionCode = '0004' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"KPLC PostPaid";
            end else if TransactionCode = '0005' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"KPLC Prepaid";
            end else if TransactionCode = '0006' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::DSTV;
            end else if TransactionCode = '0007' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::ZUKU;
            end else if TransactionCode = '0008' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Safaricom Airtime Purchase";
            end else if TransactionCode = '0009' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::Pesalink;
            end else if TransactionCode = '0010' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"POS Cash deposit";
            end else if TransactionCode = '0011' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cash Withdrawal";
            end else if TransactionCode = '0012' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cardless ATM withdrawal";
            end else if TransactionCode = '0013' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Safaricom C2B";
            end else if TransactionCode = '0014' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Ministatement Sacco direct";
            end else if TransactionCode = '0015' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Airtel Airtime purchase";
            end else if TransactionCode = '0016' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Balance Enquiry_Sacco_Direct";
            end else if TransactionCode = '0017' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Nairobi water bill payment";
            end else if TransactionCode = '0018' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Bank Account to sacco account";
            end else if TransactionCode = '0019' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Sacco account to bank account";
            end else if TransactionCode = '0020' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Airtel B2C";
            end else if TransactionCode = '0021' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"TELKOM B2C";
            end else if TransactionCode = '0022' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Sacco account to Virtual Card";
            end else if TransactionCode = '0023' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Virtual card to SACCO";
            end else if TransactionCode = '0024' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Sacco to other Sacco";
            end else if TransactionCode = '0025' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Other sacco to Sacco";
            end else if TransactionCode = '0026' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"TELCOM C2B";
            end else if TransactionCode = '0027' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"VISA Cash withdrawal";
            end else if TransactionCode = '1420' then begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::Reversal;
            end else begin
                AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Balance Enquiry_Sacco_Direct";
            end;
            AtmLog."institution Name" := institutionname;
            AtmLog."Institutional code" := institutioncode;
            AtmLog.Channel := channel;
            AtmLog."Connection Mode" := MessageType;
            AtmLog.Narrative1 := Narration1;
            AtmLog."Narrative2" := Narration2;
            AtmLog."Message ID" := MessageID;
            AtmLog."Terminal ID" := TerminalID2;
            AtmLog."Transaction Code" := TransactionCode;
            // AtmLog."Transaction Type" := AtmLog."Transaction Type"::"Cash Withdrawal";
            AtmLog."Code Description" := '';
            AtmLog."Bank Doc_No" := docNo;
            AtmLog.INSERT;
        END;
    end;


    procedure CheckMessageIDIfExists(DocumentNo: code[60]) Exists: Boolean
    var
        DetVend: Record "Detailed Vendor Ledg. Entry";
        atmLogs: Record "ATM Log Entries3";
    begin
        Exists := false;
        // DetVend.Reset();
        // DetVend.SetRange(DetVend."Document No.", DocumentNo);
        // DetVend.SetRange(DetVend.Reversed, false);
        // if DetVend.FindFirst() then begin
        //     Exists := true;
        // end;

        atmLogs.Reset();
        atmLogs.SetRange("Reference No", DocumentNo);
        if atmLogs.Find('-') then begin
            Exists := true;
        end;
    end;

    var
        SFactory: Codeunit "SURESTEP FactoryMobile";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[60];
        BATCH_NAME: Code[80];
        Pos: Record "POS Commissions";
        DOCUMENT_NO: Code[40];
        AvailableBalance: Decimal;

}
