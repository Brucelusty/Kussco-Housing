Codeunit 50081 "PORTALIntegration"
{

    trigger OnRun()
    begin
        //Message(fnRegister('8972572'));
        //MESSAGE( fnMemberStatement('000002','','');
        //fnTotalDepositsGraph('055000005','2013');
        //fnCurrentShareGraph('10000','2013');
        //fnTotalRepaidGraph('055000005','2013');
        //MESSAGE( MiniStatement('1024'));
        //fnMemberStatement('1024','006995Thox.pdf');
        //FnDepositsStatement('006995','dstatemnt.pdf');
        //FnLoanStatement('ACI015683','lsmnt.pdf');
        //MESSAGE(MiniStatement('006995'));
        //MESSAGE(FORMAT( FnLoanApplication('1023','D303',20000,'DEV',2,FALSE,FALSE,TRUE)));
        //fnFosaStatement('2483-05-1-1189','fosa1.pdf');
        //fnLoanRepaymentShedule('BLN0036','fstn11.pdf');
        //fndividentstatement('000547','divident.pdf')
        //fnLoanGuranteed('006995','loansguaranteed.pdf');
        //fnLoanRepaymentShedule('10000','victorLoanrepay.pdf');
        //fnLoanGurantorsReport('10000','Guarantors.pdf');
        //fnAtmApplications('0101-001-00266')
        //FnLoanStatement('1024','jk');
        //fnChangePassword('10000','1122','1200');
        //FnUpdateMonthlyContrib('2439', 2000);
        //fnUpdatePassword('10001','8340224','1340');
        //fnAtmApplications('2483-05-1-1189')
        //FnStandingOrders('2439','2483-05-1-1189','1W','1Y','2483-05-06-1189',20170913D,240,1);
        //MESSAGE(FORMAT( FnLoanApplication('2439','TANK LOAN',12500,'DEVELOPMENT',6,TRUE, FALSE, FALSE)));
        //fnFosaStatement('2747-006995-01', 'thox.pdf')
        //MESSAGE(FORMAT( Fnlogin('1024','')));
        //MESSAGE( MiniStatement('ACI015683'));
        //MESSAGE( fnAccountInfo('1024'));
        //MESSAGE(FORMAT(fnLoanDetails('d308')));
        //MESSAGE(FnmemberInfo('1024'));
        //MESSAGE(Fnloanssetup());
        //fnFeedback('1024', 'I have a big problem');
        //MESSAGE( FnloanCalc(100000, 10, 'D301'));
        //MESSAGE( FnNotifications());
        //MESSAGE(fnLoanDetails('ss'));
        //FnApproveGurarantors(
        //fnGuarantorsPortal('1024', '1023', 'BLN00148', 'Has requested you to quarantee laon');
        //FnApproveGurarantors(1, '000001',5, '',10000);
        //MESSAGE( FNAppraisalLoans('1024'));
        //MESSAGE( FnGetLoansForGuarantee('000001'));
        //MESSAGE(FnEditableLoans('1024','BLN00167'));
        //MESSAGE(fnLoans('1024'));
        //MESSAGE(FnmemberInfo('27394785'));
        //MESSAGE(FnGetLoansForGuarantee('000005'));
        //MESSAGE(FnApprovedGuarantors('1024', 'BLN00051'));
        //MESSAGE(FnloanCalc(40000,12,'D301'));
        //MESSAGE(FORMAT(fnTotalLoanAm('BLN00019')));
        //MESSAGE(fnLoans('000002'));
        //Fnquestionaire('000005', 'ASKDL', 'WATCH','TIME','FND','1',2,3,2,'Hellen');
        //FnNotifications('bln00084','manu1.pdf');
        //fnLoanApplicationform('10230');
        //fnLoanApplicationform('1050',TODAY, '10');
        //MESSAGE(FnLoanfo('1050'));
        //MESSAGE( FnLoanfo('5752'));
        //Message(Format(FnGetMonthlyDeduction('0006')));
    end;

    var
        objMember: Record Customer;
        Vendor: Record Vendor;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FILESPATH: label 'D:\Airport Revised\Airport\Airport\Airport\Downloads\';
        objLoanRegister: Record "Loans Register";
        objAtmapplication: Record "ATM Card Applications";
        objRegMember: Record "Membership Applications";
        objNextKin: Record "Members Next of Kin";
        GenSetup: Record "General Ledger Setup";
        FreeShares: Decimal;
        Transtype: Text;
        glamount: Decimal;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        objStandingOrders: Record "Standing Orders";
        CustomerLedgerEntries: Record 379;
        ObjMemberLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        freq: DateFormula;
        dur: DateFormula;
        ObjVendor: Record Vendor;
        ObjVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        phoneNumber: Code[20];
        SMSMessages: Record "SMS Messages";
        OnlineOTP: Record "Online Portal OTP";
        iEntryNo: Integer;
        FAccNo: Text[250];
        sms: Text[250];
        objLoanApplication: Record "Loans Register";
        ClientName: Code[20];
        Loansetup: Record "Loan Products Setup";
        feedback: Record Response;
        LoansPurpose: Record "Loans Purpose";
        ObjLoansregister: Record "Loans Register";
        LPrincipal: Decimal;
        count: Integer;
        LInterest: Decimal;
        Amount: Decimal;
        LBalance: Decimal;
        LoansRec: Record "Loans Register";
        MemberSaving: Record MemberSavings;
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        Date: Date;
        FormNo: Code[40];
        Loanperiod: Integer;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record Customer;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record "Customer Price Group";
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        loansregister: Record "Loans Register";
        OnlineUsers: Record "Online Portal Users";
        OnlineCommitteUsers: Record "Online Commitee Users";
        OnlineComitteOTP: Record "Online Committe OTP";
        CapDiv: Decimal;
        DivCapTotal: Decimal;
        RunningPeriod: Code[10];
        LineNo: Integer;
        loansguarantee: Record "Loans Guarantee Details";
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        DivInTotal: Decimal;
        WTaxInTotal: Decimal;
        CapTotal: Decimal;
        Period: Code[20];
        WTaxShareCap: Decimal;
        ENtry: Integer;
        loanproducts: Record "Loan Products Setup";
        //Online: Record UnknownRecord170416;
        setup: Record "Treasury Transactions";
        noseries: Codeunit "No. Series";
        memberApp: Record "Membership Applications";
        JSONTextWriter: Codeunit "Json Text Reader/Writer";

        JSON: Codeunit DotNet_String;
        StringWriter2: Codeunit DotNet_StreamWriter;

        StringBuilder: Codeunit DotNet_StringBuilder;


        FilePath2: Codeunit "SharePoint Auth.";



    PROCEDURE FnGetMinistatement(memberno: Text; bal_code: Text; VAR ministatementtxt: BigText) Res: Text;
    BEGIN
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", (memberno));
        IF objMember.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + objMember.Name + '",';
            Res += '"mobile_no":"' + objMember."Mobile Phone No" + '",';
            Res += '"member_no":"' + objMember."No." + '",';
            Res += '"stm_list":[';
            count := 0;

            Transtype := '';
            // if (bal_code = 'SHA') then begin
            ObjMemberLedgerEntry.RESET;
            ObjMemberLedgerEntry.SETASCENDING("Entry No.", FALSE);
            ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Customer No.", objMember."No.");
            IF bal_code = 'SHA' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Share Capital");
            IF bal_code = 'DEP' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Deposit Contribution");
            //IF bal_code = 'BEN' THEN
            //   ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Benevolent Fund");
            IF bal_code = 'TLA' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::Loan);
            IF ObjMemberLedgerEntry.FIND('-') THEN BEGIN
                REPEAT
                    count := count + 1;
                    IF ObjMemberLedgerEntry.Amount > 0 THEN
                        Transtype := 'DR';
                    IF ObjMemberLedgerEntry.Amount < 0 THEN
                        Transtype := 'CR';

                    // Res+='{"loan_no":"'+ObjMemberLedgerEntry."Loan No"+'",';
                    Res += '{"description":"' + FORMAT(ObjMemberLedgerEntry.Description) + '",';
                    Res += '"transaction_date":"' + FORMAT(ObjMemberLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + '",';
                    Res += '"document_no":"' + FORMAT(ObjMemberLedgerEntry."Document No.") + '",';
                    Res += '"amount":"' + FORMAT(ABS(ObjMemberLedgerEntry.Amount)) + '",';
                    Res += '"trans_type":"' + FORMAT(Transtype) + '"},';

                UNTIL (ObjMemberLedgerEntry.NEXT = 0) OR (count = 20);
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            end;
            // end else begin
            ObjVendor.Reset();
            ObjVendor.SetRange(ObjVendor."BOSA Account No", objMember."No.");
            ObjVendor.SetRange(ObjVendor."Account Type", bal_code);
            if ObjVendor.Find('-') then begin
                ObjVendorLedgerEntry.RESET;
                ObjVendorLedgerEntry.SETASCENDING("Entry No.", FALSE);
                ObjVendorLedgerEntry.SETRANGE(ObjVendorLedgerEntry."Vendor No.", ObjVendor."No.");
                IF ObjVendorLedgerEntry.FIND('-') THEN BEGIN
                    REPEAT
                        count := count + 1;
                        IF ObjVendorLedgerEntry.Amount > 0 THEN
                            Transtype := 'DR';
                        IF ObjVendorLedgerEntry.Amount < 0 THEN
                            Transtype := 'CR';

                        // Res+='{"loan_no":"'+ObjMemberLedgerEntry."Loan No"+'",';
                        Res += '{"description":"' + FORMAT(ObjVendorLedgerEntry.Description) + '",';
                        Res += '"transaction_date":"' + FORMAT(ObjVendorLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + '",';
                        Res += '"document_no":"' + FORMAT(ObjVendorLedgerEntry."Document No.") + '",';
                        Res += '"amount":"' + FORMAT(ABS(ObjVendorLedgerEntry.Amount)) + '",';
                        Res += '"trans_type":"' + FORMAT(Transtype) + '"},';

                    UNTIL (ObjVendorLedgerEntry.NEXT = 0) OR (count = 20);
                    Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                end;
                // end;
            END;
            Res := Res + ']}';
        END;
    END;

    procedure MiniStatement(MemberNo: Code[20]) MiniStmt: Text
    var
        VendorRec: Record Vendor;
        VendorLedger: Record "Vendor Ledger Entry";
        JsonObj: JsonObject;
        JsonArray: JsonArray;
        TransactionObj: JsonObject;
        Amount: Decimal;
        MinimunCount: Integer;
    begin
        Clear(JsonObj);
        Clear(JsonArray);

        // 🔹 Filter Vendor by MemberNo
        VendorRec.Reset();
        VendorRec.SetRange("No.", MemberNo);

        if VendorRec.FindFirst() then begin

            VendorLedger.Reset();
            VendorLedger.SetCurrentKey("Entry No.");
            VendorLedger.SetAscending("Entry No.", false);
            VendorLedger.SetRange("Vendor No.", VendorRec."No.");
            VendorLedger.SetRange(Reversed, false);

            if VendorLedger.FindSet() then begin

                MinimunCount := 0;

                repeat
                    MinimunCount += 1;

                    VendorLedger.CalcFields("Credit Amount");

                    Amount := VendorLedger."Credit Amount";

                    if Amount < 0 then
                        Amount := Amount * -1;

                    Clear(TransactionObj);

                    TransactionObj.Add('postingDate', Format(VendorLedger."Posting Date"));
                    TransactionObj.Add('description', VendorLedger.Description);
                    TransactionObj.Add('amount', Format(Amount));

                    JsonArray.Add(TransactionObj);

                    if MinimunCount >= 5 then
                        break;

                until VendorLedger.Next() = 0;
            end;
        end;

        JsonObj.Add('success', true);
        JsonObj.Add('member', MemberNo);
        JsonObj.Add('transactions', JsonArray);

        JsonObj.WriteTo(MiniStmt);
        exit(MiniStmt);
    end;

    /* procedure fnMemberDefaultStatement(MemberNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        //MemberStatement: Report 80007;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            //MemberStatement.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            //if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end; */

    /* procedure fnMemberStatement(MemberNo: Code[50]; StartDate: Date; EndDate: Date; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        MemberStatement: Report 
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        objMember.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
        if objMember.Find('-') then begin
            MemberStatement.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            if MemberStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end; */
    PROCEDURE GetDetailedStatement(member_no: Text) Res: Text;
    VAR
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;
    BEGIN

        // Filter member
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", member_no);

        IF NOT objMember.FIND('-') THEN BEGIN
            EXIT('{"success":false,"message":"Member not found"}');
        END;

        // Get table reference for report
        recRef.GETTABLE(objMember);

        tmpBlob.CreateOutStream(OutStr);

        // 🔥 Generate Report — Auto name it using member number
        IF Report.SaveAs(50049, 'Statement_' + member_no, format::Pdf, OutStr, recRef) THEN BEGIN

            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, TRUE);

            Res := '{"success":true,';
            Res += '"base_report":"' + ReduceSpaces(txtB64) + '"}';

        END
        ELSE BEGIN
            Res := '{"success":false,"message":"Report generation failed"}';
        END;

    END;

    procedure ReduceSpaces(InputString: Text) OutputString: Text
    var
        i: integer;
        n: Integer;
        CRLF: Text;

    begin
        CRLF[1] := 10;
        CRLF[2] := 13;
        OutputString := DELCHR(InputString, '=', CRLF);
    end;

    procedure fndividentstatement(MemberNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        DividendsStatement: Report 50012;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            DividendsStatement.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            if DividendsStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnFosaStatement(AccountNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        FosaStatement: Report 50004;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", AccountNo);
        if Vendor.Find('-') then begin
            FosaStatement.SetTableView(Vendor);
            TempBlob.CreateOutStream(StatementOutstream);
            if FosaStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    /*  procedure fnLoanGuranteed(MemberNo: Code[50]; var Base64Txt: Text)
     var
         Filename: Text[100];
         TempBlob: Codeunit "Temp Blob";
         StatementOutstream: OutStream;
         StatementInstream: InStream;
         LoanGuaranteed: Report 80009;
         Base64Convert: Codeunit "Base64 Convert";
     begin
         objMember.Reset;
         objMember.SetRange(objMember."No.", MemberNo);
         if objMember.Find('-') then begin
             LoanGuaranteed.SetTableView(objMember);
             TempBlob.CreateOutStream(StatementOutstream);
             if LoanGuaranteed.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                 TempBlob.CreateInStream(StatementInstream);
                 Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
             end;

         end;
     end; */

    /*     procedure FnLoanStatement(IdNo: Code[50]; var Base64Txt: Text)
        var
            Filename: Text[100];
            TempBlob: Codeunit "Temp Blob";
            StatementOutstream: OutStream;
            StatementInstream: InStream;
            LoanStatement: Report 80027;
            Base64Convert: Codeunit "Base64 Convert";
        begin


            objMember.Reset;
            objMember.SetRange(objMember."ID No.", IdNo);
            if objMember.Find('-')
            then begin
                objMember.Reset();

                objMember.SETRANGE(objMember."No.", idNO);
                //objMember.SetRange("No.", objMember."No.");
                LoanStatement.SetTableView(objMember);
                TempBlob.CreateOutStream(StatementOutstream);
                if LoanStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;

            end;
        end;
     */
    /* procedure FnDepoStatement(MemberNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        LoanStatement: Report 80012;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            LoanStatement.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            if LoanStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

 */
    procedure fnLoanRepaymentShedule("Loan No": Code[50]; path: Text[100])
    var
        "Member No": Code[100];
        filename: Text[250];
    begin
        filename := FILESPATH + path;
        // if Exists(filename) then
        //     Erase(filename);
        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Loan  No.", "Loan No");

        if objLoanRegister.Find('-') then begin
            //Report.SaveAsPdf(60477, filename, objLoanRegister);
            Message(FILESPATH);
        end;
    end;

    /* procedure fnLoanGurantorsReport(MemberNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        LoanGuarantors: Report 80010;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            LoanGuarantors.SetTableView(objMember);
            TempBlob.CreateOutStream(StatementOutstream);
            if LoanGuarantors.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;
 */

    procedure fnAtmApplications(Account: Code[100])
    begin
        objAtmapplication.Init;
        objAtmapplication."Account No" := Account;
        objAtmapplication."Application Date" := Today;
        objAtmapplication."Request Type" := objAtmapplication."request type"::New;
        objAtmapplication."Card Status" := objAtmapplication."card status"::Pending;
        objAtmapplication.Validate(objAtmapplication."Account No");
        objAtmapplication.Insert;
    end;


    procedure fnAtmBlocking(Account: Code[100]; ReasonForBlock: Text[250])
    begin
        objAtmapplication.Reset;
        objAtmapplication.SetRange(objAtmapplication."Account No", Account);
        if objAtmapplication.Find('-') then begin
            objAtmapplication."Card Status" := objAtmapplication."card status"::Frozen;
            objAtmapplication."Reason for Account blocking" := ReasonForBlock;
            objAtmapplication.Modify;
        end;
    end;


    procedure fnChangePassword(memberNumber: Code[100]; currentPass: Text; newPass: Text) updated: Boolean
    var
        EncryptionManagement: Codeunit "Cryptography Management";
        InStream: InStream;
        PasswordText: Text;
        OutStream: OutStream;
        DecryptPassword: Text;
    begin
        updated := false;
        OnlineUsers.reset;
        OnlineUsers.SetRange("Member No.", memberNumber);
        OnlineUsers.SetRange(Password, currentPass);
        if OnlineUsers.FindFirst() then begin
            OnlineUsers.Password := newPass;
            OnlineUsers."Changed Password" := true;
            if OnlineUsers.Modify(true) then
                updated := true;
            exit(updated);
        end;
    end;


    procedure fnTotalRepaidGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            //objMember.CALCFIELDS("Current Shares");
            total := objMember."Total Repayments";
            Message('current repaid is %1', total);
        end;
    end;


    procedure fnCurrentShareGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            objMember.CalcFields("Current Shares");
            total := objMember."Current Shares";
            Message('current shares is %1', total);
        end;
    end;


    procedure fnTotalDepositsGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        // objMember.RESET;
        // objMember.SETRANGE("No.", Mno);
        // IF objMember.FIND('-') THEN BEGIN
        //
        // objMember.SETFILTER("Date Filter",'0101'+year+'..1231'+year);
        // objMember.CALCFIELDS("Share Cap");
        // total:=objMember."Share Cap";
        // MESSAGE ('current deposits is %1', total);
        // END;
    end;


    procedure FnRegisterKin("Full Names": Text; Relationship: Text; "ID Number": Code[10]; "Phone Contact": Code[10]; Address: Text; Idnomemberapp: Code[10])
    begin
        begin
            objRegMember.Reset;
            objNextKin.Reset;
            objNextKin.Init();
            objRegMember.SetRange("ID No.", Idnomemberapp);
            if objRegMember.Find('-') then begin
                objNextKin."Account No" := objRegMember."No.";
                objNextKin.Name := "Full Names";
                objNextKin.Relationship := Relationship;
                objNextKin."ID No." := "ID Number";
                objNextKin.Telephone := "Phone Contact";
                objNextKin.Address := Address;
                objNextKin.Insert(true);
            end;
        end;
    end;

    procedure GetMemberRegions(): Text
    var
        RegionRec: Record "Member Delegate Zones";
        Result: Text;
    begin
        if RegionRec.FindSet() then begin
            repeat
                if Result <> '' then
                    Result += '|';

                Result += RegionRec.Code + ',' + RegionRec.Description;
            until RegionRec.Next() = 0;
        end;

        exit(Result);
    end;

    procedure FnMemberApply(

        // Person 1
        FirstName: Text[100];
        MiddleName: Text[100];
        LastName: Text[100];
        DateOfBirth: Date;
        Region: Code[50];
        IDNumber: Code[40];
        County: Code[50];
        Residence: Text[100];
        PostalAddress: Text[150];
        PostalCode: Code[40];
        Town: Text[100];
        MobileNumber: Code[50];
        Email: Text[100];
        Occupation: Text[100];
        Employer: Text[100];
        EmployerPostalCode: Text[100];
       MaritalStatus: Option;
       AccountCategory: Option;

        MonthlyContribution: Decimal;
        ProfilePhoto: Text; IDFront: Text; IDBack: Text;

        // Person 2
        FirstName1: Text[100];
        MiddleName1: Text[100];
        LastName1: Text[100];
        IDNumber1: Code[40];
        MobileNumber1: Code[50];
        DateOfBirth1: Date;
        PostalAddress1: Text[150];
        PostalCode1: Code[40];
        Town1: Text[100];
        Email1: Text[100];
        Employer1: Text[100];
        EmployerPostalCode1: Text[100];
        MaritalStatus1: Option;
        //Occupation1: Text[100];
        //Region1: Code[50];
        //County1: Code[50];
        //Residence1: Text[100];



        // Person 3
        FirstName2: Text[100];
        MiddleName2: Text[100];
        LastName2: Text[100];
        //Occupation2: Text[100];
        IDNumber2: Code[40];
        MobileNumber2: Code[50];
        DateOfBirth2: Date;
        PostalAddress2: Text[150];
        PostalCode2: Code[40];
        Town2: Text[100];
        Email2: Text[100];
        Employer2: Text[100];
        EmployerPostalCode2: Text[100]


    ) Response: Text
    var

        objRegMember: Record "Membership Applications";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin

        // ✅ Check if already exists
        objRegMember.Reset();
        objRegMember.SetRange("ID No.", "IDNumber");

        if objRegMember.FindFirst() then begin
            exit('EXISTS');
        end;

        objRegMember.Init;
        objRegMember."First Name" := FirstName;
        objRegMember."Middle Name" := MiddleName;
        objRegMember."Last Name" := LastName;
        objRegMember."Date of Birth" := DateOfBirth;
        objRegMember."Marital Status" := MaritalStatus;
        objRegMember.Region := Region;
        objRegMember."ID No." := IDNumber;
        objRegMember.County := County;
        objRegMember."Member's Residence" := Residence;
        objRegMember.Address := PostalAddress;
        objRegMember."Postal Code" := PostalCode;
        objRegMember."Home Town" := Town;
        objRegMember."Mobile Phone No" := MobileNumber;
        objRegMember."E-Mail (Personal)" := Email;
        objRegMember.Occupation := Occupation;
        objRegMember."Employer Name" := Employer;
        objRegMember."Employer Code" := EmployerPostalCode;
        objRegMember."Monthly Contribution" := MonthlyContribution;

        objRegMember."Account Category" := AccountCategory;

        // ===== Person 2 =====
        objRegMember."First Name2" := FirstName1;
        objRegMember."Middle Name2" := MiddleName1;
        objRegMember."Last Name2" := LastName1;
        objRegMember."ID No.2" := IDNumber1;
        objRegMember."Mobile No. 2" := MobileNumber1;
        objRegMember."Date of Birth2" := DateOfBirth1;
        //objRegMember.Occupation2 := Occupation1;
        //objRegMember."resid" := Residence1;
        objRegMember."Marital Status2" := MaritalStatus1;
        //objRegMember.County := County1;
        objRegMember."Address 2" := PostalAddress1;
        objRegMember."Postal Code 2" := PostalCode1;
        objRegMember."Home Town2" := Town1;
        objRegMember."E-Mail (Personal2)" := Email1;
        objRegMember."Employer Name2" := Employer1;
        objRegMember."Employer Code2" := EmployerPostalCode1;

        // ===== Person 3 =====
        objRegMember."First Name3" := FirstName2;
        objRegMember."Middle Name 3" := MiddleName2;
        objRegMember."Last Name3" := LastName2;
        objRegMember."ID No.3" := IDNumber2;
        objRegMember."Mobile No. 3" := MobileNumber2;
        objRegMember."Date of Birth3" := DateOfBirth2;
        objRegMember.Address3 := PostalAddress2;
        objRegMember."Postal Code 3" := PostalCode2;
        objRegMember."Town 3" := Town2;
        objRegMember."E-Mail (Personal3)" := Email2;
        objRegMember."Employer Name3" := Employer2;
        objRegMember."Employer Code3" := EmployerPostalCode2;
        //objRegMember.County3 := County2;
        //objRegMember."Village/Residence" := Residence2;
        // objRegMember.Region3 := Region2;
        //objRegMember.Occupation3 := Occupation2;


        objRegMember."Created By" := UserId;
        objRegMember."Date of Registration" := Today;
        objRegMember."Membership Approval Status" :=
            objRegMember."Membership Approval Status"::Open;

        objRegMember.Insert(true);

        if ProfilePhoto <> '' then
            SaveBase64ToMedia(ProfilePhoto, objRegMember, 'PROFILE');

        if IDFront <> '' then
            SaveBase64ToMedia(IDFront, objRegMember, 'IDFRONT');

        if IDBack <> '' then
            SaveBase64ToMedia(IDBack, objRegMember, 'IDBACK');



        // ✅ Return Application No
        exit(objRegMember."No.");

        //exit('SUCCESS');
    end;

    procedure fnInsertNominees(AccountNo: Code[30]; Name: Text[100];
            Idno: Text[100]; Email: Text[100]; Relationship: Text[50]; Allocation: Decimal; Address: Code[50])
    var
        NOK: Record "Member App Nominee";
    begin
        // 🔹 Restrict to maximum 4 per member
        NOK.Reset();

        if NOK.Count >= 4 then
            Error('Maximum of 4 Next of Kin allowed for this member.');

        // 🔹 Insert new record
        NOK.Init();

        NOK."Account No" := AccountNo;
        NOK.Name := Name;
        NOK."ID No." := Idno;
        NOK.Email := Email;
        NOK.Relationship := Relationship;
        NOK."%Allocation" := Allocation;
        NOK.Address := Address;

        NOK.Insert(true);
    end;

    procedure FnMemberApplyOLD("First Name": Code[30]; "Mid Name": Code[30]; "Last Name": Code[30]; "Phone Number": Code[30]; Email: Text; "ID Number": Code[30]; ProfilePhoto: Text; IDFront: Text; IDBack: Text) num: Text

    var
        objRegMember: Record "Membership Applications";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;

    begin

        // ✅ Check if already exists
        objRegMember.Reset();
        objRegMember.SetRange("ID No.", "ID Number");

        if objRegMember.FindFirst() then begin
            exit('EXISTS');
        end;

        // ✅ Create New Record
        objRegMember.Init();

        objRegMember.Name := "First Name" + ' ' + "Mid Name" + ' ' + "Last Name";
        objRegMember."ID No." := "ID Number";
        objRegMember."Mobile Phone No" := "Phone Number";
        objRegMember."E-Mail (Personal)" := Email;

        objRegMember."Created By" := UserId;
        objRegMember."Date of Registration" := Today;
        objRegMember."Membership Approval Status" :=
            objRegMember."Membership Approval Status"::Open;
        objRegMember.Insert(true);

        if ProfilePhoto <> '' then
            SaveBase64ToMedia(ProfilePhoto, objRegMember, 'PROFILE');

        if IDFront <> '' then
            SaveBase64ToMedia(IDFront, objRegMember, 'IDFRONT');

        if IDBack <> '' then
            SaveBase64ToMedia(IDBack, objRegMember, 'IDBACK');



        // ✅ Return Application No
        exit(objRegMember."No.");

    end;

    local procedure SaveBase64ToMedia(
     Base64Text: Text;
     var MemberRec: Record "Membership Applications";
     ImageType: Text
 )
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    begin

        if Base64Text = '' then
            exit;

        // Create OutStream
        TempBlob.CreateOutStream(OutStr);

        // Decode Base64 into stream
        Base64Convert.FromBase64(Base64Text, OutStr);

        // Create InStream
        TempBlob.CreateInStream(InStr);

        FileName := MemberRec."ID No." + '_' + ImageType + '.jpg';

        case ImageType of
            'PROFILE':
                MemberRec.Picture.ImportStream(InStr, FileName);

            'IDFRONT':
                MemberRec."ID Front".ImportStream(InStr, FileName);

            'IDBACK':
                MemberRec."ID Back".ImportStream(InStr, FileName);
        end;

        MemberRec.Modify(true);

    end;

    procedure FnInsertCustomerLead(FirstName: Code[50]; LastName: Code[50]; PhoneNumber: Code[30]; Email: Text) LeadNo: Code[20]
    var
        objLead: Record "Customer Contact";
        NoSeriesMgt: Codeunit "No. Series";
    begin

        objLead.Init();

        //Use CONTACT No Series
        objLead."No." := NoSeriesMgt.GetNextNo('CONTACT', Today, true);

        objLead."First Name" := FirstName;
        objLead."Surname" := LastName;
        objLead."Mobile Phone No" := PhoneNumber;
        objLead."E-Mail Address" := Email;
        objLead."Lead Status" := objLead."Lead Status"::Active;

        objLead.Insert(true);

        exit(objLead."No.");

    end;

    local procedure FnFreeShares("Member No": Text) Shares: Text
    begin
        begin
            begin
                GenSetup.Get();
                FreeShares := 0;
                glamount := 0;

                objMember.Reset;
                objMember.SetRange(objMember."No.", "Member No");
                if objMember.Find('-') then begin
                    objMember.CalcFields("Current Shares");
                    LoansGuaranteeDetails.Reset;
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No", objMember."No.");
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted, false);
                    if LoansGuaranteeDetails.Find('-') then begin
                        repeat
                            glamount := glamount + LoansGuaranteeDetails."Amont Guaranteed";
                        //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                        until LoansGuaranteeDetails.Next = 0;
                    end;
                    //  FreeShares:=(objMember."Current Shares"*GenSetup."Contactual Shares (%)")-glamount;
                    Shares := Format(FreeShares, 0, '<Precision,2:2><Integer><Decimals>');
                end;
            end;
        end;
    end;


    procedure FnStandingOrders(BosaAcNo: Code[30]; SourceAcc: Code[50]; frequency: Text; Duration: Text; DestAccNo: Code[30]; StartDate: Date; Amount: Decimal; DestAccType: Option)
    begin
        objStandingOrders.Init();
        objStandingOrders."BOSA Account No." := BosaAcNo;
        objStandingOrders."Source Account No." := SourceAcc;
        objStandingOrders.Validate(objStandingOrders."Source Account No.");
        if Format(freq) = '' then
            Evaluate(freq, frequency);
        objStandingOrders.Frequency := freq;
        if Format(dur) = '' then
            Evaluate(dur, Duration);
        objStandingOrders.Duration := dur;
        objStandingOrders."Destination Account No." := DestAccNo;
        objStandingOrders.Validate(objStandingOrders."Destination Account No.");
        objStandingOrders."Destination Account Type" := DestAccType;
        objStandingOrders.Amount := Amount;
        objStandingOrders."Effective/Start Date" := StartDate;
        objStandingOrders.Validate(objStandingOrders.Duration);
        objStandingOrders.Status := objStandingOrders.Status::Open;
        objStandingOrders.Insert(true);
        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaAcNo);
        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            sms := 'You have created a standing order of amount : ' + Format(Amount) + ' from Account ' + SourceAcc + ' start date: '
                  + Format(StartDate) + '. Thanks for using AU INNOVATION SACCO Portal.';
            FnSMSMessage(SourceAcc, phoneNumber, sms);
            //MESSAGE('All Cool');
        end
    end;


    procedure FnUpdateMonthlyContrib("Member No": Code[30]; "Updated Fig": Decimal)
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Member No");

        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            FAccNo := objMember."FOSA Account No.";
            objMember."Monthly Contribution" := "Updated Fig";
            objMember.Modify;
            sms := 'You have adjusted your monthly contributions to: ' + Format("Updated Fig") + ' account number ' + FAccNo +
                  '. Thank you for using AU INNOVATION Sacco Portal';
            FnSMSMessage(FAccNo, phoneNumber, sms);

            //MESSAGE('Updated');
        end
    end;


    procedure FnSMSMessage(accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin

        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        //SMSMessages."Batch No":=documentNo;
        //SMSMessages."Document No":=documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'WEBPORTAL';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure FnLoanApplication(Member: Code[30]; LoanProductType: Code[10]; AmountApplied: Decimal; LoanPurpose: Code[30]; RepaymentFrequency: Integer; LoanConsolidation: Boolean; LoanBridging: Boolean; LoanRefinancing: Boolean) Result: Boolean
    begin
        // objMember.RESET;
        // objMember.SETRANGE(objMember."No.", Member);
        // IF objMember.FIND('-') THEN BEGIN
        //
        //   objLoanApplication.RESET;
        //   objLoanApplication.INIT;
        //
        //   objLoanApplication.Type:=objLoanApplication.Type::"Loan Form";
        //    objLoanApplication.INSERT(TRUE);
        //   objLoanApplication."Account No":=Member;
        //   objLoanApplication.VALIDATE(objLoanApplication."Account No");
        //   objLoanApplication.VALIDATE(No);
        //
        //   objLoanApplication."Loan Type" :=LoanProductType;
        //
        //   objLoanApplication."Captured by":=USERID;
        //   objLoanApplication.Amount:=AmountApplied;
        //   objLoanApplication."Purpose of loan":=LoanPurpose;
        //   objLoanApplication."Repayment Period":=RepaymentFrequency;
        //   MESSAGE(objAtmapplication."Form No");
        //   objLoanApplication.VALIDATE("Loan Product Type");
        //   objLoanApplication."Loan Bridging":=LoanBridging;
        //   objLoanApplication."Loan Consolidation":=LoanConsolidation;
        //   objLoanApplication."Loan Refinancing":=LoanRefinancing;
        //   objLoanApplication.VALIDATE("Repayment Period");
        //   //objLoanApplication.VALIDATE("Loan Bridging");
        //   //objLoanApplication.VALIDATE("Loan Consolidation");
        //  // objLoanApplication.VALIDATE("Loan Refinancing");
        //   objLoanApplication.Submited:=TRUE;
        //   // objLoanApplication.INSERT(TRUE);
        //  objLoanApplication.MODIFY;
        //
        //
        // END;
        //
        // //***********insert******************//
        // objLoanApplication.RESET;
        // objLoanApplication.SETRANGE(objLoanApplication."Account No", Member);
        // objLoanApplication.SETRANGE(objLoanApplication.Type,objLoanApplication.Type::"Loan Form");
        // //objLoanApplication.SETCURRENTKEY("Capture Date");
        // IF objLoanApplication.FINDLAST THEN
        //   FormNo:=objLoanApplication.No;
        //   objLoanApplication.SETRANGE(objLoanApplication.No,FormNo);
        //   IF objLoanApplication.FIND('-') THEN
        //     BEGIN
        //       objLoanRegister.INIT;
        //   MESSAGE(FormNo);
        //        objLoanRegister.INSERT(TRUE);
        //       objLoanRegister.Source:=objLoanRegister.Source::BOSA;
        //       //objLoanRegister.Installments:=RepaymentFrequency;
        //       MESSAGE(FORMAT(RepaymentFrequency));
        //       objLoanRegister."Captured By":=USERID;
        //       objLoanRegister."Select From Forms":=FormNo;
        //
        //      MESSAGE(objLoanRegister."Loan  No.");
        //       objLoanRegister.VALIDATE("Select From Forms");
        //      // objLoanRegister."Original Loan":=TRUE;
        //        objLoanRegister.VALIDATE("Requested Amount");
        //       objLoanRegister."Loan Status":=objLoanRegister."Loan Status"::Application;
        //      objLoanRegister.MODIFY;
        //       MESSAGE('here');
        //        Result:=TRUE;
        //        phoneNumber:=objMember."Phone No.";
        //        ClientName := objMember."FOSA Account No.";
        //        sms:='We have received your '+LoanProductType+' loan application of  amount : ' +FORMAT(AmountApplied)+
        //        '. We are processing your loan, you will hear from us soon. Thanks for using KENTOURS SACCO  Portal.';
        //        FnSMSMessage(ClientName,phoneNumber,sms);
        //        PortaLuPS.INIT;
        //       // PortaLuPS.INSERT(TRUE);
        //       objLoanRegister.RESET;
        //       objLoanRegister.SETRANGE("Client Code", Member);
        //       objLoanRegister.SETCURRENTKEY("Application Date");
        //       objLoanRegister.ASCENDING(TRUE);
        //       IF objLoanRegister.FINDLAST
        //         THEN
        //
        //          PortaLuPS.LaonNo:=objLoanRegister."Loan  No.";
        //        PortaLuPS.RequestedAmount:=AmountApplied;
        //        PortaLuPS.INSERT;
        //        //MESSAGE('All Cool');
        //      //MESSAGE('Am just cool');
        // END;
    end;

    procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    var
        JsonObj: JsonObject;
    begin
        objMember.Reset();
        objMember.SetRange(objMember."No.", MemberNo);

        if objMember.FindFirst() then begin
            // ===== Person1 =====
            JsonObj.Add('No', objMember."No.");
            JsonObj.Add('FirstName', objMember."First Name");
            JsonObj.Add('MiddleName', objMember."Middle Name");
            JsonObj.Add('LastName', objMember."Last Name");
            JsonObj.Add('Dob', objMember."Date Of Birth");
            JsonObj.Add('MaritalStatus', objMember."Marital Status");
            JsonObj.Add('Religion', objMember.Religion);
            JsonObj.Add('IdNumber', objMember."ID No.");
            JsonObj.Add('County', objMember.County);
            JsonObj.Add('Residence', objMember."Member's Residence");
            JsonObj.Add('PostalAddress', objMember.Address);
            JsonObj.Add('PostalCode', objMember."Post Code");
            JsonObj.Add('Town', objMember.Town);
            JsonObj.Add('MobileNumber', objMember."Mobile Phone No");
            JsonObj.Add('Email', objMember."E-Mail (Personal)");
            JsonObj.Add('Occupation', objMember.Occupation);
            JsonObj.Add('Employer', objMember."Employer Name");
            JsonObj.Add('EmployerPostalCode', objMember."Employer code");
            JsonObj.Add('MonthlyContribution', objMember."Monthly Contribution");

            // ===== Person2 =====
            JsonObj.Add('FirstName1', objMember."Name 2");
            JsonObj.Add('Dob1', objMember."Date of Birth2");
            JsonObj.Add('MaritalStatus1', objMember."Marital Status2");
            JsonObj.Add('IdNumber1', objMember."ID No.2");
            JsonObj.Add('PostalAddress1', objMember."Home Postal Code2");
            JsonObj.Add('PostalCode1', objMember."Postal Code 2");
            JsonObj.Add('Town1', objMember."Town 2");
            JsonObj.Add('MobileNumber1', objMember."Mobile No. 2");
            JsonObj.Add('Email1', objMember."E-Mail (Personal2)");
            JsonObj.Add('Employer1', objMember."Employer Name2");
            JsonObj.Add('EmployerPostalCode1', objMember."Employer Code2");

            // ===== Person3 =====
            JsonObj.Add('FirstName2', objMember."Name 3");

            JsonObj.Add('MaritalStatus2', objMember."Marital Status3");

            JsonObj.Add('IdNumber2', objMember."ID No.3");
            JsonObj.Add('PostalAddress2', objMember."Home Postal Code3");
            JsonObj.Add('PostalCode2', objMember."Postal Code 3");
            JsonObj.Add('Town2', objMember."Town 3");
            JsonObj.Add('MobileNumber2', objMember."Mobile No. 3-Joint");
            JsonObj.Add('Email2', objMember."E-Mail (Personal3)");
            JsonObj.Add('Employer2', objMember."Employer Name3");
            JsonObj.Add('EmployerPostalCode2', objMember."Employer Code3");

            // ===== Balances =====
            objMember.CalcFields(
                "Outstanding Balance", "Current Shares", "Shares Retained",
                "Member Deposits", "Total Loan Balance"
            );
            JsonObj.Add('OutstandingBalance', objMember."Outstanding Balance");
            JsonObj.Add('MemberDeposits', objMember."Member Deposits");
            JsonObj.Add('TotalLoanBalance', objMember."Total Loan Balance");
            JsonObj.Add('CurrentShares', objMember."Current Shares");
            JsonObj.Add('SharesRetained', objMember."Shares Retained");
        end else begin
            // ===== Defaults =====
            JsonObj.Add('No', '');
            JsonObj.Add('FirstName', '');
            JsonObj.Add('MiddleName', '');
            JsonObj.Add('LastName', '');
            JsonObj.Add('Dob', 0);
            JsonObj.Add('MaritalStatus', '');
            JsonObj.Add('Religion', '');
            JsonObj.Add('IdNumber', '');
            JsonObj.Add('County', '');
            JsonObj.Add('Residence', '');
            JsonObj.Add('PostalAddress', '');
            JsonObj.Add('PostalCode', '');
            JsonObj.Add('Town', '');
            JsonObj.Add('MobileNumber', '');
            JsonObj.Add('Email', '');
            JsonObj.Add('Occupation', '');
            JsonObj.Add('Employer', '');
            JsonObj.Add('EmployerPostalCode', '');
            JsonObj.Add('MonthlyContribution', 0);

            JsonObj.Add('FirstName1', '');
            JsonObj.Add('Dob1', 0);
            JsonObj.Add('MaritalStatus1', '');
            JsonObj.Add('IdNumber1', '');
            JsonObj.Add('PostalAddress1', '');
            JsonObj.Add('PostalCode1', '');
            JsonObj.Add('Town1', '');
            JsonObj.Add('MobileNumber1', '');
            JsonObj.Add('Email1', '');
            JsonObj.Add('Employer1', '');
            JsonObj.Add('EmployerPostalCode1', '');

            JsonObj.Add('FirstName2', '');
            JsonObj.Add('Dob2', 0);
            JsonObj.Add('MaritalStatus2', '');
            JsonObj.Add('IdNumber2', '');
            JsonObj.Add('PostalAddress2', '');
            JsonObj.Add('PostalCode2', '');
            JsonObj.Add('Town2', '');
            JsonObj.Add('MobileNumber2', '');
            JsonObj.Add('Email2', '');
            JsonObj.Add('Employer2', '');
            JsonObj.Add('EmployerPostalCode2', '');


            JsonObj.Add('OutstandingBalance', 0);
            JsonObj.Add('MemberDeposits', 0);
            JsonObj.Add('TotalLoanBalance', 0);
            JsonObj.Add('CurrentShares', 0);
            JsonObj.Add('SharesRetained', 0);
        end;

        JsonObj.WriteTo(info);
    end;
    // procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    // var
    //     JsonObj: JsonObject;
    // begin
    //     objMember.Reset();
    //     objMember.SetRange(objMember."No.", MemberNo);

    //     if objMember.FindFirst() then begin

    //         objMember.CalcFields(
    //             "Outstanding Balance", "Current Shares", "Shares Retained",
    //             "Member Deposits",

    //             "Total Loan Balance"
    //         //"Share Capital Contribution"
    //         );

    //         JsonObj.Add('No', objMember."No.");
    //         JsonObj.Add('IdNo', objMember."ID No.");
    //         JsonObj.Add('Name', objMember.Name);
    //         JsonObj.Add('Email', objMember."E-Mail (Personal)");
    //         JsonObj.Add('Age', objMember.Age);
    //         JsonObj.Add('Dob', objMember."Date Of Birth");
    //         JsonObj.Add('Gender', objMember.Gender);
    //         JsonObj.Add('MemberType', objMember."Member Type");
    //         JsonObj.Add('MemberStatus', objMember.Status);


    //         JsonObj.Add('OutstandingBalance', objMember."Outstanding Balance");
    //         JsonObj.Add('MemberDeposits', objMember."Member Deposits");
    //         JsonObj.Add('TotalLoanBalance', objMember."Total Loan Balance");
    //         JsonObj.Add('Current Shares', objMember."Current Shares");
    //         JsonObj.Add('Shares Retained', objMember."Shares Retained");

    //         //JsonObj.Add('ShareCapital', objMember."Share Capital Contribution");

    //     end
    //     else begin
    //         // ✅ Always return valid JSON even if not found
    //         JsonObj.Add('No', '');
    //         JsonObj.Add('Name', '');
    //         JsonObj.Add('IdNo', '');
    //         JsonObj.Add('Email', '');
    //         JsonObj.Add('Age', '');
    //         JsonObj.Add('Dob', '');
    //         JsonObj.Add('Gender', '');
    //         JsonObj.Add('MemberType', '');
    //         JsonObj.Add('MemberStatus', '');

    //         JsonObj.Add('OutstandingBalance', 0);
    //         JsonObj.Add('MemberDeposits', 0);
    //         JsonObj.Add('MonthlyContribution', 0);
    //         JsonObj.Add('Current Shares', 0);
    //         JsonObj.Add('Shares Retained', 0);
    //         JsonObj.Add('TotalLoanBalance', 0);
    //         JsonObj.Add('ShareCapital', 0);
    //     end;

    //     JsonObj.WriteTo(info);
    // end;

    procedure FnNokProfile(MemberNo: Code[20]): Text
    var
        MembersNOK: Record "Members Next of Kin";
        info: Text;
        firstNOK: Boolean;
    begin
        info := '['; // start JSON array
        firstNOK := true;

        // Find the member by MemberNo
        objMember.Reset();
        objMember.SetRange(objMember."No.", MemberNo);

        if objMember.Find('-') then begin
            MembersNOK.Reset();
            //MembersNOK.SetRange("Account No", objMember."No.");

            if MembersNOK.Find('-') then
                repeat
                    if not firstNOK then
                        info += ','; // separate NOK objects
                    firstNOK := false;

                    info += '{' +
                            '"Name":"' + MembersNOK.Name + '",' +
                            '"DateOfBirth":"' + Format(MembersNOK."Date of Birth") + '",' +
                            '"Allocation":' + Format(MembersNOK."%Allocation") + ',' +
                            '"Relationship":"' + MembersNOK.Relationship + '"' +
                            '}';
                until MembersNOK.Next() = 0;
        end;

        // If no NOK found, return a single empty object
        if firstNOK then
            info += '{' +
                    '"Name":"","DateOfBirth":"","Allocation":0,"Relationship":""' +
                    '}';

        info += ']'; // close JSON array
        exit(info);
    end;



    procedure FnGetMemberProfile(MemberNo: Code[20]): Text
    var
        JsonObj: JsonObject;
        ResultText: Text;
    begin
        Clear(JsonObj);

        objMember.Reset();
        objMember.SetRange("No.", MemberNo);

        if objMember.FindFirst() then begin

            // Basic Information
            JsonObj.Add('No', objMember."No.");
            JsonObj.Add('IdNo', objMember."ID No.");
            JsonObj.Add('Name', objMember.Name);
            JsonObj.Add('Email', objMember."E-Mail (Personal)");
            JsonObj.Add('MobilePhone', objMember."Mobile Phone No.");
            JsonObj.Add('Age', Format(objMember.Age));
            JsonObj.Add('Dob', Format(objMember."Date Of Birth"));
            JsonObj.Add('Gender', Format(objMember.Gender));
            JsonObj.Add('MemberType', Format(objMember."Member Type"));
            JsonObj.Add('MemberStatus', Format(objMember.Status));
            JsonObj.Add('Country', objMember."Country/Region Code");
            JsonObj.Add('County', objMember.County);
            JsonObj.Add('City', objMember.City);

            // Bank Information
            JsonObj.Add('BankName', objMember."Bank Name");
            JsonObj.Add('BankBranch', objMember."Bank Branch Name");
            JsonObj.Add('BankBranchCode', objMember."Bank Branch Code");
            JsonObj.Add('BankAccountNo', objMember."Bank Account No.");

            // Registration Info
            JsonObj.Add('RegistrationDate', Format(objMember."Registration Date"));

        end else begin

            // Default JSON if member is not found
            JsonObj.Add('No', '');
            JsonObj.Add('IdNo', '');
            JsonObj.Add('Name', '');
            JsonObj.Add('Email', '');
            JsonObj.Add('MobilePhone', '');
            JsonObj.Add('Age', '');
            JsonObj.Add('Dob', '');
            JsonObj.Add('Gender', '');
            JsonObj.Add('MemberType', '');
            JsonObj.Add('MemberStatus', '');
            JsonObj.Add('Country', '');
            JsonObj.Add('County', '');
            JsonObj.Add('City', '');

            JsonObj.Add('BankName', '');
            JsonObj.Add('BankBranch', '');
            JsonObj.Add('BankBranchCode', '');
            JsonObj.Add('BankAccountNo', '');

            JsonObj.Add('RegistrationDate', '');

        end;

        JsonObj.WriteTo(ResultText);
        exit(ResultText);
    end;

    procedure FnGetNOKProfile(MemberNo: Code[20]): Text
    var
        MembersNOK: Record "Members Next of Kin";
        info: Text;
        sep: Text;
    begin
        info := '{ "success": true, "next_of_kin": [';
        sep := '';

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            MembersNOK.Reset;
            MembersNOK.SetRange("Account No", objMember."No.");
            if MembersNOK.Find('-') then
                repeat
                    info += sep + '{' +
                            '"name":"' + MembersNOK.Name + '",' +
                            '"dob":"' + Format(MembersNOK."Date of Birth", 0, '<StandardFormat>') + '",' +
                            '"allocation":' + Format(MembersNOK."%Allocation") + ',' +
                            '"relationship":"' + MembersNOK.Relationship + '"' +
                            '}';
                    sep := ',';
                until MembersNOK.Next() = 0;
        end;

        info += ']}';
        exit(info);
    end;

    procedure fnAccountInfo(Idno: Code[20]) info: Text
    var
        JsonObj: JsonObject;
    begin

        objMember.Reset();
        objMember.SetRange(objMember."ID No.", Idno);

        if objMember.FindFirst() then begin

            objMember.CalcFields(
                "Shares Retained",
                "Total Committed Shares",
                "Current Savings",
                "Current Shares",
                "Dividend Amount",
                "Un-allocated Funds"
            );

            JsonObj.Add('CurrentSavings', Round(objMember."Current Savings" * -1, 0.01));
            JsonObj.Add('SharesRetained', Round(objMember."Shares Retained", 0.01));
            JsonObj.Add('HolidaySavings', Round(objMember."Holiday Savings", 0.01));
            JsonObj.Add('DependantSavings1', Round(objMember."Dependant Savings 1", 0.01));
            JsonObj.Add('DependantSavings2', Round(objMember."Dependant Savings 2", 0.01));
            JsonObj.Add('DependantSavings3', Round(objMember."Dependant Savings 3", 0.01));
            JsonObj.Add('UtafitiHousing', Round(objMember."Utafiti Housing", 0.01));
            JsonObj.Add('DividendAmount', Round(objMember."Dividend Amount", 0.01));

            JsonObj.WriteTo(info);
        end;
    end;

    procedure FnGetMonthlyDeduction(IDNumber: Code[20]) Amount: Decimal
    var
        MembersRegister: Record Customer;

    begin
        Amount := 0;
        MembersRegister.Reset();
        MembersRegister.SetRange(MembersRegister."No.", IDNumber);
        if MembersRegister.Find('-') then begin
            Amount += MembersRegister."Monthly Contribution";
            // MemberSaving.Reset();
            // MemberSaving.SetRange(MemberSaving.MemberNo, MembersRegister."No.");

            // if MemberSaving.FindSet() then begin

            //     repeat

            //         Amount += MemberSaving."Amount On";
            //     until MemberSaving.Next = 0;
            // end;
            loansregister.Reset();
            loansregister.SetRange("Client Code", MembersRegister."No.");
            loansregister.SetFilter("Outstanding Balance", '>%1', 0);
            if loansregister.FindSet() then begin
                repeat
                    Amount += loansregister.Repayment;
                until loansregister.Next = 0;
            end;
            exit(Amount);
        end;
    end;

    procedure fnloaninfo(Memberno: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);
        if objMember.Find('-') then begin
            objMember.CalcFields("Outstanding Balance");
            objMember.CalcFields("Outstanding Interest");
            info := Format(objMember."Outstanding Balance") + ':' + Format(objMember."Outstanding Interest");
        end;
    end;

    procedure fnLoans(MemberNo: Code[20]) loans: Text
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Loanperiod := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", MemberNo);
        objLoanRegister.SetFilter("Loan Product Type", objLoanRegister."Loan Product Type");
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        objLoanRegister.SetFilter("Outstanding Balance", '>%1', 0);
        if objLoanRegister.Find('-') then begin
            repeat
                //Loanperiod := Round((objLoanRegister."Expected Date of Completion" - Today) / 30, 1, '=');
                ObjRepaymentSchedule.Reset;
                ObjRepaymentSchedule.SetRange("Loan No.", objLoanRegister."Loan  No.");
                ObjRepaymentSchedule.SetFilter("Repayment Date", '>%1', Today);
                if ObjRepaymentSchedule.Find('-') then begin
                    Loanperiod := ObjRepaymentSchedule.Count;
                end;

                objLoanRegister.CalcFields("Outstanding Balance");
                loans := loans + objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Outstanding Balance") + ':' + Format(objLoanRegister."Loans Category") + ':' + Format(objLoanRegister.Installments) + ':'
                + Format(Loanperiod) + ':' + Format(objLoanRegister."Amount in Arrears") + ':' + Format(objLoanRegister."Requested Amount") + ':' + Format(objLoanRegister."Loan  No.") + '::';
            until objLoanRegister.Next() = 0;
        end;
    end;

    procedure fnLoansDetrails(MemberNo: Code[20]) loans: Text
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Loanperiod := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Loan  No.", MemberNo);
        objLoanRegister.SetFilter("Loan Product Type", objLoanRegister."Loan Product Type");
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        objLoanRegister.SetFilter("Outstanding Balance", '>%1', 0);
        if objLoanRegister.Find('-') then begin
            repeat
                //Loanperiod := Round((objLoanRegister."Expected Date of Completion" - Today) / 30, 1, '=');
                ObjRepaymentSchedule.Reset;
                ObjRepaymentSchedule.SetRange("Loan No.", objLoanRegister."Loan  No.");
                ObjRepaymentSchedule.SetFilter("Repayment Date", '>%1', Today);
                if ObjRepaymentSchedule.Find('-') then begin
                    Loanperiod := ObjRepaymentSchedule.Count;
                end;

                objLoanRegister.CalcFields("Outstanding Balance");
                loans := loans + objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Outstanding Balance") + ':' + Format(objLoanRegister."Loans Category") + ':' + Format(objLoanRegister.Installments) + ':'
                + Format(Loanperiod) + ':' + Format(objLoanRegister."Amount in Arrears") + ':' + Format(objLoanRegister."Requested Amount") + ':' + Format(objLoanRegister."Loan  No.") + '::';
            until objLoanRegister.Next() = 0;
        end;
    end;

    procedure FnloanCalc(LoanAmount: Decimal; RepayPeriod: Integer; LoanCode: Code[30]) text: Text
    begin
        /*Loansetup.RESET;
        Loansetup.SETRANGE(Code, LoanCode);

        IF Loansetup.FIND('-') THEN BEGIN

         IF Loansetup."Repayment Method"= Loansetup."Repayment Method"::Amortised THEN BEGIN
        // LoansRec.TESTFIELD(LoansRec.Interest);
        // LoansRec.TESTFIELD(LoansRec.Installments);
         TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - POWER((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
         LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.0001,'>');
         LPrincipal:=TotalMRepay-LInterest;
         END;

         IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::"Straight Line" THEN BEGIN
         LoansRec.TESTFIELD(LoansRec.Interest);
         LoansRec.TESTFIELD(LoansRec.Installments);
         LPrincipal:=LoanAmount/RepayPeriod;
         LInterest:=(Loansetup."Interest rate"/12/100)*LoanAmount/RepayPeriod;
         END;

         IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::"Reducing Balance" THEN BEGIN
         //LoansRec.TESTFIELD(LoansRec.Interest);
         //LoansRec.TESTFIELD(LoansRec.Installments);
         MESSAGE('type is %1',LoanCode);
          Date:=TODAY;
         //IF RepayPeriod>Loansetup."Band I Maximum" THEN BEGIN
           MESSAGE('HERE');
          TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - POWER((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
          REPEAT
         LInterest:=ROUND(LoanAmount * Loansetup."Interest rate"/12/100,0.0001,'>');
         LPrincipal:=TotalMRepay-LInterest;
           LoanAmount:=LoanAmount-LPrincipal;
        RepayPeriod:= RepayPeriod-1;

         text:=text+FORMAT(Date)+'!!'+FORMAT(ROUND( LPrincipal))+'!!'+FORMAT(ROUND( LInterest))+'!!'+FORMAT(ROUND(TotalMRepay))+'!!'+FORMAT(ROUND(LoanAmount))+'??';
         Date:=CALCDATE('+1M', Date);

         UNTIL RepayPeriod=0;
         END
          //
          END;
         IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::Constants THEN BEGIN
         LoansRec.TESTFIELD(LoansRec.Repayment);
         IF LBalance < LoansRec.Repayment THEN
         LPrincipal:=LBalance
         ELSE
         LPrincipal:=LoansRec.Repayment;
         LInterest:=LoansRec.Interest;
         END;



         //END;

       //EXIT(Amount);
       //END;
       //END;*/

    end;


    procedure Fnloanssetup() loanType: Text
    begin
        /*Loansetup.RESET;
        BEGIN
        loanType:='';
        REPEAT
        loanType:=FORMAT(Loansetup.Code)+':'+Loansetup."Product Description"+':::'+loanType;
          UNTIL Loansetup.NEXT=0;
        END;
        */

    end;


    procedure fnLoanDetails1(Loancode: Code[20]) loandetail: Text
    begin
        /*Loansetup.RESET;
        //Loansetup.SETRANGE(Code, Loancode);
        IF Loansetup.FIND('-') THEN BEGIN
          REPEAT
          loandetail:=loandetail+Loansetup."Product Description"+'!!'+ FORMAT(Loansetup."Repayment Method")+'!!'+FORMAT(Loansetup."Max. Loan Amount")+'!!'+FORMAT(Loansetup."Instalment Period")+'!!'+FORMAT(Loansetup."Interest rate")+'!!'
          +FORMAT(Loansetup."Repayment Frequency")+'??';
          UNTIL Loansetup.NEXT=0;
        END;
        */

    end;

    procedure FnFeedback(MemberNo: Code[30]; TextMessage: Text[250]) isSaved: Boolean
    var
        Enquiry: Record "General Equiries.";
    begin
        if TextMessage = '' then
            Error('Feedback message cannot be empty');

        Enquiry.Init();
        Enquiry.Validate("Member No", MemberNo);
        Enquiry.Description := TextMessage;

        Enquiry.Status := Enquiry.Status::New;
        Enquiry."Calling As" := Enquiry."Calling As"::"As Member";
        Enquiry."Contact Mode" := Enquiry."Contact Mode"::Website;
        Enquiry."Calling For" := Enquiry."Calling For"::Enquiry;

        Enquiry."Date Sent" := Today;
        Enquiry."Time Sent" := Time;
        Enquiry."Sent By" := MemberNo;

        Enquiry.Insert(true);

        exit(true);
    end;

    procedure fnLoansPurposes() LoanType: Text
    begin
        LoansPurpose.Reset;
        begin
            LoanType := '';
            repeat
                LoanType := Format(LoansPurpose.Code) + ':' + LoansPurpose.Description + ':::' + LoanType;
            until LoansPurpose.Next = 0;
        end;
    end;


    procedure fnReplys(No: Code[20]) text: Text
    begin
        // feedback.RESET;
        // feedback.SETRANGE(No, No);
        // feedback.SETCURRENTKEY(Entry);
        // feedback.ASCENDING(FALSE);
        // IF feedback.FIND('-') THEN BEGIN
        //   REPEAT
        //      IF(feedback.Reply ='') THEN BEGIN
        //
        //  END ELSE
        //     text:=text+FORMAT(feedback.DatePosted)+'!!'+feedback.Portalfeedback+'!!'+ feedback.Reply+'??';
        // UNTIL feedback.NEXT=0;
        // END;
    end;


    procedure FnLoanfo(MemberNo: Code[20]) dividend: Text
    begin
        /*DivProg.RESET;
        DivProg.SETRANGE("Member No",MemberNo);
        IF DivProg.FIND('-') THEN BEGIN
          REPEAT
            IF DivProg."Gross Dividends" < 1 THEN DivProg."Gross Dividends":=-1*DivProg."Gross Dividends";
             IF DivProg."Net Dividends" < 1 THEN DivProg."Net Dividends":=-1*DivProg."Net Dividends";
             IF DivProg."Witholding Tax" < 1 THEN DivProg."Witholding Tax":=-1*DivProg."Witholding Tax";
             IF DivProg."Qualifying Shares" < 1 THEN DivProg."Qualifying Shares":=-1*DivProg."Qualifying Shares";
             IF DivProg.Shares < 1 THEN DivProg.Shares:=-1*DivProg.Shares;
            dividend:=dividend+FORMAT(DivProg.Date)+':::'+FORMAT( DivProg."Gross Dividends")+':::'+FORMAT(DivProg."Witholding Tax")+':::'+FORMAT(DivProg."Net Dividends")+':::'+FORMAT(DivProg."Qualifying Shares")+':::'
            +FORMAT(DivProg.Shares)+'::::';
            UNTIL DivProg.NEXT=0;
            END;
            */

    end;


    procedure fnGetAtms(Idnumber: Code[20]) return: Text
    begin
        Vendor.Reset;
        objAtmapplication.SetRange("Customer ID", Idnumber);
        if objAtmapplication.Find('-') then begin
            repeat
                return := objAtmapplication."No." + ':::' + return;
            until
              objAtmapplication.Next = 0;
        end;
    end;

    procedure fnRegister(MemberNo: Code[15]) Registered: Boolean;
    var
    //MemberNo: Code[10];
    begin
        Registered := false;

        // 1️⃣ Find member using ID Number
        objMember.Reset();
        objMember.SetRange("No.", MemberNo);

        if not objMember.FindFirst() then
            Error('Member not found. Please contact support.');

        MemberNo := objMember."No.";

        // 2️⃣ Check if already registered (by PK Member No)
        if OnlineUsers.Get(MemberNo) then
            Error('You are already registered. Please login.');

        // 3️⃣ Insert into OnlineUsers
        OnlineUsers.Init();
        OnlineUsers."Member No." := MemberNo; // PK
        OnlineUsers."ID Number" := objMember."ID No.";
        OnlineUsers."Member Name" := objMember.Name;
        OnlineUsers."Email Address" := objMember."E-Mail";
        //OnlineUsers."Phone No" := objMember."Phone No.";
        OnlineUsers."Member Name" := objMember.Name;
        OnlineUsers."Changed Password" := false;
        OnlineUsers."member type" := objmember."Account Category";

        OnlineUsers."Date Created" := Today;

        OnlineUsers.Insert(true);

        Registered := true;

        exit(Registered);
    end;

    procedure fnSetPassword(MemberNo: Code[15]; NewPassword: Text) Success: Boolean

    begin
        Success := false;

        OnlineUsers.Reset();
        OnlineUsers.SetRange("Member No.", MemberNo);

        if not OnlineUsers.FindFirst() then
            Error('User not found.');


        OnlineUsers.Password := NewPassword;
        OnlineUsers."Changed Password" := true;


        OnlineUsers.Modify(true);

        Success := true;
        exit(Success);
    end;

    procedure fnGetMemberType(MemberNo: Code[20]): Text
    var
        OnlineUsers: Record "Online Portal Users";
    begin

        Message('Searching for MemberNo: %1', MemberNo); // 🔥 DEBUG

        OnlineUsers.Reset();
        OnlineUsers.SetRange("Member No.", MemberNo);

        if OnlineUsers.FindFirst() then begin
            Message('Found! Member Type: %1', OnlineUsers."Member Type");
            exit(Format(OnlineUsers."Member Type"));
        end else begin
            Message('NOT FOUND');
            exit('');
        end;
    end;
    /*  procedure fnGetMemberType(MemberNo: Code[15]): Text
     var
         OnlineUsers: Record "Online Users";
     begin
         if OnlineUsers.Get(MemberNo) then
             exit(Format(OnlineUsers."Member Type")) // ✅ convert enum to text
         else
             exit('');
     end; */

    procedure fnInsertOTP(MemberNo: Code[10]; OTP: Integer; OTPMode: Text) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            OnlineOTP.Reset();
            OnlineOTP.SetRange("Member No", MemberNo);
            if OnlineOTP.FindSet() then begin
                OnlineOTP."Member No" := objMember."No.";
                OnlineOTP."Member Name" := objMember."First Name" + ' ' + objMember."Middle Name" + ' ' + objMember."Last Name";
                OnlineOTP.OTP := OTP;
                OnlineOTP.Authenticated := false;
                if OnlineOTP.Modify(true) then
                    smtpc.Create(objMember."E-Mail", 'Airport Sacco Member Portal Login OTP', 'Your One Time Password To Access Airport Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end else begin
                OnlineOTP.Init();
                OnlineOTP."Member No" := objMember."No.";
                OnlineOTP."Member Name" := objMember."First Name" + ' ' + objMember."Middle Name" + ' ' + objMember."Last Name";
                OnlineOTP.OTP := OTP;
                OnlineOTP.Authenticated := false;
                if OnlineOTP.Insert(true) then
                    smtpc.Create(objMember."E-Mail", 'Airport Sacco Member Portal Login OTP', 'Your One Time Password To Access Airport Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end;
        end;
    end;

    procedure fnLogin(MemberNo: Code[15]; Password: Text) Success: Boolean

    begin
        Success := false;

        // Find user by ID Number
        OnlineUsers.Reset();
        OnlineUsers.SetRange("Member No.", MemberNo);

        if not OnlineUsers.FindFirst() then
            exit(false); // user not found

        // Validate password
        if OnlineUsers.Password = Password then
            Success := true;

        exit(Success);
    end;

    procedure fnForgotPassword(MemberNo: Code[15]) Success: Boolean
    begin
        Success := false;

        OnlineUsers.Reset();
        OnlineUsers.SetRange("Member No.", MemberNo);

        if OnlineUsers.FindFirst() then
            Success := true;

        exit(Success);
    end;

    procedure fnResendOTP(MemberNo: Code[10]; OTP: Integer; OTPMode: Text) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange("Member No.", MemberNo);
        if OnlineUsers.Find('-') then begin
            OnlineOTP.Reset();
            OnlineOTP.SetRange("Member No", OnlineUsers."Member No.");
            if OnlineOTP.FindSet() then begin
                OnlineOTP."Member No" := OnlineUsers."Member No.";
                OnlineOTP."Member Name" := OnlineUsers."Member Name";
                OnlineOTP.OTP := OTP;
                OnlineOTP.Authenticated := false;
                if OnlineOTP.Modify(true) then
                    smtpc.Create(OnlineUsers."Email Address", 'Airport Sacco Member Portal Password Reset OTP', 'Your One Time Password To Access Airport Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end;

        end;
    end;

    procedure fnVerifyOTP(MemberNo: Code[10]; OTP: Integer) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineOTP.Reset();
        OnlineOTP.SetRange("Member No", MemberNo);
        OnlineOTP.SetRange(OnlineOTP.OTP, OTP);
        OnlineOTP.SetRange(OnlineOTP.Authenticated, false);
        if OnlineOTP.FindFirst then begin
            OnlineOTP.Authenticated := true;
            if OnlineOTP.Modify(true) then
                Registered := true;
            exit(Registered);
        end;
    end;

    procedure FnSendFeedback(MemberNo: Code[10]; Body: Text) Sent: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
        otp: Text;
    begin
        Sent := false;
        objMember.Reset();
        objMember.SetRange("No.", MemberNo);
        if objMember.Find('-') then begin
            smtpc.Create('info@kusccohousing.coop', 'KUscco Housing COrporative Member Portal Feedback', Body, true);
            smtp.Send(smtpc, Enum::"Email Scenario"::Default);
            Sent := true;
            exit(Sent);
        end;
    end;

    procedure fnConfirmRegistration(MemberNo: Code[40]; otp: Text; newpassword: Text) status: Boolean
    begin
        status := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange(OnlineUsers."Member No.", MemberNo);
        OnlineUsers.SetRange(OnlineUsers."Changed Password", false);
        if OnlineUsers.Find('-') then begin
            OnlineUsers.Password := newpassword;
            OnlineUsers."Changed Password" := true;
            if OnlineUsers.Modify(true) then
                status := true;
            exit(status);
        end
        else
            exit(status);
    end;

    procedure MemberPhoto(MemberNo: Code[30]) PictureText: text
    var
        InStream: InStream;
        Member: record "Customer";
        Media: Record "Tenant Media";
        //Picture: Record "Media Set";
        FileSystem: File;
        LargeText: text;
        FileName: Text[100];
        Base64: Codeunit "Base64 Convert";
    begin
        Member.GET(MemberNo);
        if Member.Piccture.Count > 0 then begin
            Media.Get(Member.Piccture.Item(1));
            Media.CalcFields(Content);
            Media.Content.createinstream(InStream, TextEncoding::UTF8);
            PictureText := Base64.ToBase64(InStream, false);
        end;
    end;

    procedure fnIndividulaBiodata(MemberNo: Code[20]; MemberType: Option Individual,Corporate,Joint; FirstName: Text[100]; MiddleName: Text[100]; LastName: Text[100]; DateOfBirth: Date; MaritalStatus: Option Single,Married,Divorced,Widowed; Religion: Code[50]; IDNumber: Code[40];
        County: Code[50]; Residence: Text[100]; PostalAddress: Text[150]; PostalCode: Code[40]; Town: Text[100]; MobileNumber: Code[50]; Email: Text[100]; Occupation: Text[100]; Employer: Text[100]; EmployerPostalCode: Text[100]; MonthlyContribution: Decimal)
    var
        MemberApp: Record "Biodata";
    begin

        if MemberApp.Get(MemberNo) then
            Error('Biodata already submitted for this member.');

        // ✅ Insert new record
        MemberApp.Init();
        MemberApp."No." := MemberNo;

        MemberApp."Member Type" := MemberType;
        // Primary member
        MemberApp."First Name" := FirstName;
        MemberApp."Middle Name" := MiddleName;
        MemberApp."Last Name" := LastName;
        MemberApp."Date of Birth" := DateOfBirth;
        MemberApp."Marital Status" := MaritalStatus;
        MemberApp.Religion := Religion;
        MemberApp."ID No." := IDNumber;
        //MemberApp.Designation := Designation;
        MemberApp.County := County;
        MemberApp."Member's Residence" := Residence;
        MemberApp.Address := PostalAddress;
        MemberApp."Post Code" := PostalCode;
        MemberApp."Home Town" := Town;
        MemberApp."Mobile Phone No" := MobileNumber;
        //MemberApp."Other Mobile No." := OtherMobileNumber;
        MemberApp."E-Mail (Personal)" := Email;
        MemberApp.Occupation := Occupation;
        MemberApp.Employer2 := Employer;
        MemberApp."Employer Code" := EmployerPostalCode;


        MemberApp."Monthly Contribution" := MonthlyContribution;

        MemberApp.Insert(true);
        // 🔥 IF JOINT → Call Participant Insert Logic
        /* case MemberType of

            MemberType::Joint:
               /*  fnInsertJointParticipant(MemberNo, FirstName,
                MiddleName, LastName, DateOfBirth, MaritalStatus, Religion, IDNumber, County, Residence, PostalAddress, PostalCode,
                Town, MobileNumber, Email, Occupation, Employer, EmployerPostalCode, MonthlyContribution);
            */ //CORPORATE TYPE
               /*  MemberType::Corporate:
                    fnInsertCorporateOfficial(MemberNo, FirstName, MiddleName, LastName, IDNumber, Occupation);
            end; */
    end;

    procedure fnInsertProfile(
     MemberNo: Code[20];
     // Person 1
     FirstName: Text[100];
     MiddleName: Text[100];
     LastName: Text[100];
     DateOfBirth: Date;
     //MaritalStatus:Text[100];
     Religion: Code[50];
     IDNumber: Code[40];
     County: Code[50];
     Residence: Text[100];
     PostalAddress: Text[150];
     PostalCode: Code[40];
     Town: Text[100];
     MobileNumber: Code[50];
     Email: Text[100];
     Occupation: Text[100];
     Employer: Text[100];
     EmployerPostalCode: Text[100];

     MonthlyContribution: Decimal;

    ProfilePhoto: Text;
    Signature: Text;
    IDFront: Text;
    IDBack: Text;

     // Person 2
     FirstName1: Text[100];
     MiddleName1: Text[100];
     LastName1: Text[100];
     Occupation1: Text[100];
     IDNumber1: Code[40];
     MobileNumber1: Code[50];
     DateOfBirth1: Date;
     //MaritalStatus1:Text[100];
     Religion1: Code[50];
     County1: Code[50];
     Residence1: Text[100];
     PostalAddress1: Text[150];
     PostalCode1: Code[40];
     Town1: Text[100];
     Email1: Text[100];
     Employer1: Text[100];
     EmployerPostalCode1: Text[100];

     // Person 3
     FirstName2: Text[100];
     MiddleName2: Text[100];
     LastName2: Text[100];
     Occupation2: Text[100];
     IDNumber2: Code[40];
     MobileNumber2: Code[50];
     DateOfBirth2: Date;
     //MaritalStatus2: Text[100];
     Religion2: Code[50];
     County2: Code[50];
     Residence2: Text[100];
     PostalAddress2: Text[150];
     PostalCode2: Code[40];
     Town2: Text[100];
     Email2: Text[100];
     Employer2: Text[100];
     EmployerPostalCode2: Text[100]
 )
    var
        MemberApp: Record "Biodata";
    begin

        MemberApp.Init();
        MemberApp."No." := MemberNo;

        MemberApp."First Name" := FirstName;
        MemberApp."Middle Name" := MiddleName;
        MemberApp."Last Name" := LastName;
        MemberApp."Date of Birth" := DateOfBirth;
        //MemberApp."Marital Status" := MaritalStatus;
        MemberApp.Religion := Religion;
        MemberApp."ID No." := IDNumber;
        MemberApp.County := County;
        MemberApp."Member's Residence" := Residence;
        MemberApp.Address := PostalAddress;
        MemberApp."Post Code" := PostalCode;
        MemberApp."Home Town" := Town;
        MemberApp."Mobile Phone No" := MobileNumber;
        MemberApp."E-Mail (Personal)" := Email;
        MemberApp.Occupation := Occupation;
        MemberApp."Employer Name" := Employer;
        MemberApp."Employer Code" := EmployerPostalCode;
        MemberApp."Monthly Contribution" := MonthlyContribution;

        // ===== Person 2 =====
        MemberApp."First Name2" := FirstName1;
        MemberApp."Middle Name2" := MiddleName1;
        MemberApp."Last Name2" := LastName1;
        MemberApp."ID No.2" := IDNumber1;
        MemberApp."Mobile No. 2" := MobileNumber1;
        MemberApp."Date of Birth2" := DateOfBirth1;
        //MemberApp."Marital Status2" := MaritalStatus1;
        MemberApp.Religion2 := Religion1;
        MemberApp.County2 := County1;
        MemberApp."Residence2" := Residence1;
        MemberApp."Address 2" := PostalAddress1;
        MemberApp."Postal Code 2" := PostalCode1;
        MemberApp."Home Town2" := Town1;
        MemberApp."E-Mail (Personal2)" := Email1;
        MemberApp."Employer Name2" := Employer1;
        MemberApp."Employer Code2" := EmployerPostalCode1;

        // ===== Person 3 =====
        MemberApp."First Name3" := FirstName2;
        MemberApp."Middle Name3" := MiddleName2;
        MemberApp."Last Name3" := LastName2;
        MemberApp."ID No.3" := IDNumber2;
        MemberApp."Mobile No 3" := MobileNumber2;
        MemberApp."Date of Birth3" := DateOfBirth2;
        //MemberApp."Marital Status3" := MaritalStatus2;
        MemberApp.Religion3 := Religion2;
        MemberApp.County3 := County2;
        MemberApp.Residence3 := Residence2;
        MemberApp.Address3 := PostalAddress2;
        MemberApp."Postal Code 3" := PostalCode2;
        MemberApp."Town 3" := Town2;
        MemberApp."E-Mail (Personal3)" := Email2;
        MemberApp."Employer Name3" := Employer2;
        MemberApp."Employer Code3" := EmployerPostalCode2;

        MemberApp.Insert(true);
        // ✅ Save images
        if ProfilePhoto <> '' then
            SaveBase64ToMedia(ProfilePhoto, MemberApp, 'PROFILE');

        if Signature <> '' then
            SaveBase64ToMedia(Signature, MemberApp, 'Signature');

        if IDFront <> '' then
            SaveBase64ToMedia(IDFront, MemberApp, 'IDFRONT');

        if IDBack <> '' then
            SaveBase64ToMedia(IDBack, MemberApp, 'IDBACK');
        MemberApp.Modify(true); // after all images
    end;

    // TO handle Base64 images
    local procedure SaveBase64ToMedia(Base64Text: Text; var MemberRec: Record "Biodata"; ImageType: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    begin
        if Base64Text = '' then
            exit;

        // Decode Base64 into TempBlob
        TempBlob.CreateOutStream(OutStr);
        Base64Convert.FromBase64(Base64Text, OutStr);

        // Create InStream for importing
        TempBlob.CreateInStream(InStr);

        FileName := MemberRec."No." + '_' + ImageType + '.jpg';

        case ImageType of
            'PROFILE':
                MemberRec.Piccture.ImportStream(InStr, FileName);
            'Signature':
                MemberRec.Signature.ImportStream(InStr, FileName);
            'IDFRONT':
                MemberRec."ID Front".ImportStream(InStr, FileName);
            'IDBACK':
                MemberRec."ID Back".ImportStream(InStr, FileName);
        end;
    end;

    /* procedure fnInsertCorporateOfficial(MemberNo: Code[20]; FirstName: Text[100]; MiddleName: Text[100]; LastName: Text[100]; IdNumber: Code[40]; Designation: Text[100])
    var
        Official: Record "Corporate Officials";
        LineNo: Integer;
    begin

        Official.Reset();
        Official.SetRange("Member No.", MemberNo);

        if Official.Count >= 3 then
            Error('Maximum 3 corporate officials allowed.');

        if Official.FindLast() then
            LineNo := Official."Line No." + 1
        else
            LineNo := 1;

        Official.Init();
        Official."Member No." := MemberNo;
        Official."Line No." := LineNo;

        Official."First Name" := FirstName;
        Official."Middle Name" := MiddleName;
        Official."Last Name" := LastName;
        Official."IdNumber" := IdNumber;
        Official.Designation := Designation;

        Official.Insert(true);

    end; */

    /*  procedure fnInsertJointParticipant(MemberNo: Code[20]; FirstName: Text[100]; MiddleName: Text[100]; LastName: Text[100]; DateOfBirth: Date;
      MaritalStatus: Option Single,Married,Divorced,Widowed; Religion: Code[50]; IDNumber: Code[40];
      County: Code[50]; Residence: Text[100]; PostalAddress: Text[150]; PostalCode: Code[40]; Town: Text[100]; MobileNumber: Code[50]; Email: Text[100]; Occupation: Text[100]; Employer: Text[100]; EmployerPostalCode: Text[100]; MonthlyContribution: Decimal)
     var
         Participant: Record "Joint Participants";
         LineNo: Integer;
     begin

         // 🔥 Prevent more than 3
         Participant.Reset();
         Participant.SetRange("Member No.", MemberNo);

         if Participant.Count >= 3 then
             Error('Maximum 3 joint participants allowed.');

         // 🔥 Auto Generate LineNo
         if Participant.FindLast() then
             LineNo := Participant."Line No." + 1
         else
             LineNo := 1;

         // 🔥 Insert Participant
         Participant.Init();
         Participant."Member No." := MemberNo;
         Participant."Line No." := LineNo;

         Participant."First Name" := FirstName;
         Participant."Middle Name" := MiddleName;
         Participant."Last Name" := LastName;
         Participant."Date of Birth" := DateOfBirth;
         Participant."Marital Status" := MaritalStatus;
         Participant."Religion" := Religion;
         Participant."IdNumber" := IDNumber;
         Participant.County := County;
         Participant.Residence := Residence;
         Participant."Postal Address" := PostalAddress;
         Participant."Postal Code" := PostalCode;
         Participant.Town := Town;
         Participant."Mobile Phone No" := MobileNumber;
         Participant."E-Mail" := Email;
         Participant.Occupation := Occupation;
         Participant.Employer := Employer;
         Participant."Employer Postal Code" := EmployerPostalCode;
         Participant."Monthly Contribution" := MonthlyContribution;

         Participant.Insert(true);

     end; */

    /*  procedure fnInsertNextOfKin(MemberNo: Code[20];
         LineNo: Integer; FirstName: Text[100];
         MiddleName: Text[100]; LastName: Text[100]; Relationship: Text[50]; Allocation: Decimal; Contact: Code[50]
     )
     var
         NOK: Record NEXTOFKIN;
     begin
         // 🔹 Restrict to maximum 4 per member
         NOK.Reset();
         NOK.SetRange("Member No.", MemberNo);
         if NOK.Count >= 4 then
             Error('Maximum of 4 Next of Kin allowed for this member.');

         // 🔹 Insert new record
         NOK.Init();
         NOK."Member No." := MemberNo;
         NOK."Line No." := LineNo;
         NOK."First Name" := FirstName;
         NOK."Middle Name" := MiddleName;
         NOK."Last Name" := LastName;
         NOK.Relationship := Relationship;
         NOK."Allocation %" := Allocation;
         NOK.Contact := Contact;

         NOK.Insert(true);
     end; */

    procedure fnCreateBiodata(
     MemberNo: Code[20];

     // Primary Member
     fname: Text[100];
     mname: Text[100];
     sname: Text[100];
     Religion: Code[50];
     PostCode: Code[40];
     County: Code[50];
     Residence: Text[100];
     IDNumber: Code[40];
     MaritalStatus: Integer;
     Address: Text[150];
     EmployerCode: Code[50];
     DateOfBirth: Date;
     Occupation: Text[100];
     PhoneNo: Code[50];
     Email: Text[100];
     HomeTown: Text[100];

     // Joint 2
     DateOfBirth2: Date;
     MaritalStatus2: Integer;
     MobilePhoneNo2: Code[50];
     Address2: Text[150];
     Occupation2: Text[100];
     Religion2: Code[50];
     EmployerCode2: Code[50];
     County2: Code[50];
     Residence2: Text[100];
     PostalCode2: Code[40];
     HomeTown2: Text[100];
     Email2: Text[100];
     IDNo2: Code[40];
     FirstName2: Text[100];
     MiddleName2: Text[100];
     LastName2: Text[100];

     // Joint 3
     Occupation3: Text[100];
     Residence3: Text[100];
     Religion3: Code[50];
     EmployerCode3: Code[50];
     County3: Code[50];
     FirstName3: Text[100];
     MiddleName3: Text[100];
     LastName3: Text[100];
     Address3Joint: Text[150];
     PostalCode3: Code[40];
     MobileNo4: Code[50];
     HomeTown3: Text[100];
     IDNo3: Code[40];
     DateOfBirth3: Date;
     MaritalStatus3: Integer;
     Email3: Text[100]
 ) No: Code[20]

    var
        MemberApp: Record "Biodata";
    begin
        MemberApp.Init();
        MemberApp."No." := MemberNo;

        // Primary
        MemberApp."First Name" := fname;
        MemberApp."Middle Name" := mname;
        MemberApp."Last Name" := sname;
        MemberApp.Religion := Religion;
        MemberApp."Post Code" := PostCode;
        MemberApp.County := County;
        MemberApp."Member's Residence" := Residence;
        MemberApp."ID No." := IDNumber;
        MemberApp."Marital Status" := MaritalStatus;
        MemberApp.Address := Address;
        MemberApp."Employer Code" := EmployerCode;
        MemberApp."Date of Birth" := DateOfBirth;
        MemberApp.Occupation := Occupation;
        MemberApp."Mobile Phone No" := PhoneNo;
        MemberApp."E-Mail (Personal)" := Email;
        MemberApp."Home Town" := HomeTown;

        // Joint 2
        MemberApp."Date of Birth2" := DateOfBirth2;
        MemberApp."Marital Status2" := MaritalStatus2;
        MemberApp."Mobile No. 2" := MobilePhoneNo2;
        MemberApp."Address 2" := Address2;
        MemberApp.Occupation2 := Occupation2;
        MemberApp.Religion2 := Religion2;
        MemberApp.Employer2 := EmployerCode2;
        MemberApp.County2 := County2;
        MemberApp.Residence2 := Residence2;
        MemberApp."Postal Code 2" := PostalCode2;
        MemberApp."Home Town2" := HomeTown2;
        MemberApp."E-Mail (Personal2)" := Email2;
        MemberApp."ID No.2" := IDNo2;
        MemberApp."First Name2" := FirstName2;
        MemberApp."Middle Name2" := MiddleName2;
        MemberApp."Last Name2" := LastName2;

        // Joint 3
        MemberApp.Occupation3 := Occupation3;
        MemberApp.Residence3 := Residence3;
        MemberApp.Religion3 := Religion3;
        MemberApp.Employer3 := EmployerCode3;
        MemberApp.County3 := County3;
        MemberApp."First Name3" := FirstName3;
        MemberApp."Middle Name3" := MiddleName3;
        MemberApp."Last Name3" := LastName3;
        MemberApp."Address3-Joint" := Address3Joint;
        MemberApp."Postal Code 3" := PostalCode3;
        MemberApp."Mobile No. 4" := MobileNo4;
        MemberApp."Home Town3" := HomeTown3;
        MemberApp."ID No.3" := IDNo3;
        MemberApp."Date of Birth3" := DateOfBirth3;
        MemberApp."Marital Status3" := MaritalStatus3;
        MemberApp."E-Mail (Personal3)" := Email3;

        MemberApp.Insert(true);


    end;

    /*  procedure InsertMemberBiodata(MemberNo: Code[20]; IdNo: Code[20]; FirstName: Text[100]; Surname: Text[100]; OtherNames: Text[100]; Email: Text[100]; PhoneNumber: Text[20])
     var
        BiodataRec: Record "Biodata";
     begin
         // Check if biodata already exists for this member
         if BiodataRec.Get(MemberNo) then
             exit; // Already exists → do nothing

         // Insert new record
         BiodataRec.Init();
         BiodataRec.MemberNo := MemberNo;
         BiodataRec."Id No" := IdNo;
         BiodataRec."First Name" := FirstName;
         BiodataRec.Surname := Surname;
         BiodataRec.OtherNames := OtherNames;
         //BiodataRec.Email := Email;
         BiodataRec."PhoneNumber" := PhoneNumber;
         //BiodataRec."Created At" := CurrentDateTime();
        // BiodataRec.Insert();
     end;  */

    procedure IsMemberBiodataExists(MemberNo: Code[20]): Boolean
    var
        BiodataRec: Record "Biodata";
    begin
        exit(BiodataRec.Get(MemberNo)); // returns true if member has biodata
    end;

    procedure GetMemberName(MemberNo: Code[250]) email: text
    var
    begin
        objMember.Reset();
        objMember.setrange("No.", MemberNo);
        if objMember.FIND('-') then begin
            email := objMember.Name;
        end;
    end;

    /* procedure FnInsertPortalLogs(MemberNo: Code[30];IdNo:Code[30]; Name: Code[250]; Activity: Text[2048]; MemberType: Text[50]; ActionType: Integer)
    var
        PortalLogs: Record "Portal Logs";
    begin

        PortalLogs.init;
        PortalLogs."Date Accessed" := CurrentDateTime;
        PortalLogs."Member No" := MemberNo;
        PortalLogs."Member Name" := Name;
        PortalLogs."Action" := Activity;
        if ActionType = 1 then begin
            PortalLogs.Type := PortalLogs.Type::"Register Member";
        end else
            if ActionType = 2 then begin
                PortalLogs.Type := PortalLogs.Type::"Sign Up";
            end else
                if ActionType = 3 then begin
                    PortalLogs.Type := PortalLogs.Type::"Login";
                end else
                    if ActionType = 4 then begin
                        PortalLogs.Type := PortalLogs.Type::"Forgot Password";
                    end else
                        if ActionType = 5 then begin
                            PortalLogs.Type := PortalLogs.Type::Dashboard;
                        end else
                            if ActionType = 6 then begin
                                PortalLogs.Type := PortalLogs.Type::"Profile";
                            end else
                                if ActionType = 7 then begin
                                    PortalLogs.Type := PortalLogs.Type::"Loans";
                                end else
                                    if ActionType = 8 then begin
                                        PortalLogs.Type := PortalLogs.Type::"Payments";
                                    end else
                                        if ActionType = 9 then begin
                                            PortalLogs.Type := PortalLogs.Type::"Statements";
                                        end else
                                            if ActionType = 10 then begin
                                                PortalLogs.Type := PortalLogs.Type::"Change Password";
                                            end else
                                                if ActionType = 11 then begin
                                                    PortalLogs.Type := PortalLogs.Type::"Dividends";
                                                end else
                                                    if ActionType = 12 then begin
                                                        PortalLogs.Type := PortalLogs.Type::"Customer Care";
                                                    end else
                                                        if ActionType = 12 then begin
                                                            PortalLogs.Type := PortalLogs.Type::"Downloaded Sacco Forms";
                                                        end else
                                                            if ActionType = 12 then begin
                                                                PortalLogs.Type := PortalLogs.Type::OTP;
                                                            end;
        if MemberType = 'Individual' then begin
            PortalLogs."Member Type" := PortalLogs."Member Type"::Individual;
        end else
            if MemberType = 'Corporate' then begin
                PortalLogs."Member Type" := PortalLogs."Member Type"::Corporate;
            end else
                if MemberType = 'Church' then begin
                    PortalLogs."Member Type" := PortalLogs."Member Type"::Church;

                end else
                    if MemberType = 'Joint' then begin
                        PortalLogs."Member Type" := PortalLogs."Member Type"::Joint;
                    end else
                        if MemberType = 'Group' then begin
                            PortalLogs."Member Type" := PortalLogs."Member Type"::Group;
                        end;
        PortalLogs.Insert(true);
    end; */

    // procedure fnPostalCodes() returnout: Text
    // var
    //     jsonout: dotnet String;
    //     zipcodes: Record "Post Code";
    // begin
    //     StringBuilder := StringBuilder;
    //     // StringWriter := StringWriter.StringWriter(StringBuilder);
    //     // JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
    //     if zipcodes.Find('-') then begin
    //         JSONTextWriter.WriteStartArray('Postal');
    //         repeat
    //             JSONTextWriter.WriteStartObject('PostalCodes');
    //             CreateJsonAttribute('value', zipcodes.Code);
    //             CreateJsonAttribute('name', zipcodes.City);
    //             JSONTextWriter.WriteEndObject;
    //         until zipcodes.Next = 0;

    //         JSONTextWriter.WriteEndArray;
    //     end;
    //     jsonout := StringBuilder.ToString;
    //     returnout := Format(jsonout);
    // end;







    procedure FnLoanApplicationNew(memberno: Code[50]; product: Code[60]; installments: Integer; amount: Decimal) loanno: Code[40]
    begin
        /*
        loansreg.INIT;
        SaccoNoSeries.GET;
        loanssetup.GET;
        loansreg."Loan  No.":=noseries.GetNextNo(SaccoNoSeries."BOSA Loans Nos", TODAY, TRUE);
        loansreg.INSERT(TRUE);
        loansreg."Client Code":=memberno;
        loansreg.VALIDATE(loansreg."Client Code");
        loansreg."Loan Product Type":=product;
        loansreg.VALIDATE(loansreg."Loan Product Type");
        loansreg."Requested Amount":=amount;
        loansreg.VALIDATE(loansreg."Requested Amount");
        loansreg.Installments:=installments;
        loansreg.VALIDATE(loansreg.Installments);
        loansreg."Repayment Frequency":=loanssetup."Repayment Frequency";
        loansreg.VALIDATE(loansreg."Repayment Frequency");
        loansreg."Repayment Method":=loanssetup."Repayment Method";
        loansreg.VALIDATE(loansreg."Repayment Method");
        loansreg.ApplicationSource:=loansreg.ApplicationSource::Portal;
        loansreg.MODIFY;

        loanno:=loansreg."Loan  No.";
        */

    end;

    procedure fnInsertGuarantors(memberNo: Code[50]; amount: Decimal; guarantor: Code[60]; loanno: Code[60])
    begin
        /*
        LoansGuaranteeDetails.INIT;
        LoansGuaranteeDetails."Loan No":=loanno;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Loan No");
        LoansGuaranteeDetails."Member No":=guarantor;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Member No");
        LoansGuaranteeDetails.RequestedGuarantee:=amount;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Amont Guaranteed");
        LoansGuaranteeDetails."Loanees  No":=memberNo;
        LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Loanees  No");
        LoansGuaranteeDetails.INSERT(TRUE);
        */

    end;

    procedure fnApproveGuarantors(loanee: Code[60]; amount: Decimal; approval: Boolean; loanno: Code[60]; memberno: Code[50])
    begin
        /*
        LoansGuaranteeDetails.RESET;
        LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Loan No", loanno);
        LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Member No", loanee);
        LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Loanees  No", memberno);
        IF LoansGuaranteeDetails.FIND('-') THEN BEGIN
          LoansGuaranteeDetails.approved:=approval;
          LoansGuaranteeDetails."Amont Guaranteed":=amount;
          IF LoansGuaranteeDetails.approved=TRUE THEN BEGIN
            LoansGuaranteeDetails.VALIDATE(LoansGuaranteeDetails."Amont Guaranteed");
            LoansGuaranteeDetails.MODIFY;
            END
            ELSE BEGIN
            LoansGuaranteeDetails.DELETE;
            END;
        END;
        */

    end;

    procedure fnPendingGurarantorship(no: Code[60]) returnout: Text
    var
        gurantorCoutner: Integer;
    //loansreg: Record UnknownRecord170300;
    // jsonout: dotnet String;
    begin
        /*
        StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
          LoansGuaranteeDetails.RESET;
          LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Member No", no);

          LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails.approved, FALSE);

          IF LoansGuaranteeDetails.FIND('-') THEN BEGIN
         gurantorCoutner:=0;
             JSONTextWriter.WriteStartArray;
         REPEAT
           loansreg.RESET;
           loansreg.SETRANGE(loansreg."Loan  No.", LoansGuaranteeDetails."Loan No");
           loansreg.SETRANGE(loansreg."Loan Status",  loansreg."Loan Status"::Application);
           IF loansreg.FIND('-') THEN BEGIN

          // LoansGuaranteeDetails.CALCFIELDS("Outstanding Balance");
         //  IF LoansGuaranteeDetails."Outstanding Balance" <> 0 THEN BEGIN
           gurantorCoutner+=1;
            JSONTextWriter.WriteStartObject;
           JSONTextWriter.WritePropertyName('id');
           JSONTextWriter.WriteValue(gurantorCoutner);
           CreateJsonAttribute('memberNo', loansreg."Client Code");
           CreateJsonAttribute('name', loansreg."Client Name");
           CreateJsonAttribute('loanNo', LoansGuaranteeDetails."Loan No");
           JSONTextWriter.WritePropertyName('guaranteedAmount');
           JSONTextWriter.WriteValue(LoansGuaranteeDetails.RequestedGuarantee);
           JSONTextWriter.WritePropertyName('loanAmount');
           JSONTextWriter.WriteValue(loansreg."Requested Amount");
           CreateJsonAttribute('type', 'Guaranteed');
           JSONTextWriter.WriteEndObject;
          // END;
           END;
         UNTIL LoansGuaranteeDetails.NEXT=0;
         JSONTextWriter.WriteEndArray;
         END;
         jsonout:=StringBuilder.ToString;
         returnout:=FORMAT(jsonout);
         */

    end;












    /* procedure Fnlogin(MemberNo: Code[20]; IDNumber: Code[20]; password: Text) LoggedIn: Boolean
    begin
        LoggedIn := false;
        OnlineUsers.Reset;
        OnlineUsers.SetRange(OnlineUsers."Member No.", MemberNo);
        OnlineUsers.SetRange("ID Number", IDNumber);
        OnlineUsers.SetRange(Password, password);
        OnlineUsers.SetRange("Changed Password", true);
        if OnlineUsers.Find('-') then begin
            LoggedIn := true;
            exit(LoggedIn);
        end
        else
            exit(LoggedIn);
    end; */


    procedure FnCommitteeLogin(MemberNo: Code[20]; IDNumber: Code[20]; password: Text) LoggedIn: Boolean
    begin
        LoggedIn := false;
        OnlineCommitteUsers.Reset;
        OnlineCommitteUsers.SetRange(OnlineCommitteUsers."Member No.", MemberNo);
        OnlineCommitteUsers.SetRange("ID Number", IDNumber);
        OnlineCommitteUsers.SetRange(Password, password);
        OnlineCommitteUsers.SetRange("Changed Password", true);
        if OnlineCommitteUsers.Find('-') then begin
            LoggedIn := true;
            exit(LoggedIn);
        end
        else
            exit(LoggedIn);
    end;

    procedure FnGetCommitteeApprovalLoans() loans: Text
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Loanperiod := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetFilter("Loan Product Type", objLoanRegister."Loan Product Type");
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        objLoanRegister.SetRange(Posted, false);
        objLoanRegister.SetRange("Committee Approval", objLoanRegister."Committee Approval"::Pending);
        if objLoanRegister.Find('-') then begin
            repeat
                loans := loans + objLoanRegister."Loan  No." + ':' + objLoanRegister."Client Code" + ':' + objLoanRegister."Client Name" + ':' +
                 objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Requested Amount") + ':' + Format(objLoanRegister."Approved Amount") + ':' + Format(objLoanRegister.Installments) + ':'
                + Format(objLoanRegister.Interest) + ':' + Format(objLoanRegister."Current Shares") + '::';
            until objLoanRegister.Next() = 0;
        end;
    end;

    procedure FnGetApprovedLoans() loans: Text
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Loanperiod := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetFilter("Loan Product Type", objLoanRegister."Loan Product Type");
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        objLoanRegister.SetRange(Posted, false);
        objLoanRegister.SetRange("Committee Approval", objLoanRegister."Committee Approval"::Approved);
        if objLoanRegister.Find('-') then begin
            repeat
                loans := loans + objLoanRegister."Loan  No." + ':' + objLoanRegister."Client Code" + ':' + objLoanRegister."Client Name" + ':' +
                 objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Requested Amount") + ':' + Format(objLoanRegister."Approved Amount") + ':' + Format(objLoanRegister.Installments) + ':'
                + Format(objLoanRegister.Interest) + ':' + Format(objLoanRegister."Current Shares") + '::';
            until objLoanRegister.Next() = 0;
        end;
    end;

    procedure FnGetRejectedLoans() loans: Text
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Loanperiod := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetFilter("Loan Product Type", objLoanRegister."Loan Product Type");
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        objLoanRegister.SetRange(Posted, false);
        objLoanRegister.SetRange("Committee Approval", objLoanRegister."Committee Approval"::Rejected);
        if objLoanRegister.Find('-') then begin
            repeat
                loans := loans + objLoanRegister."Loan  No." + ':' + objLoanRegister."Client Code" + ':' + objLoanRegister."Client Name" + ':' +
                 objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Requested Amount") + ':' + Format(objLoanRegister."Approved Amount") + ':' + Format(objLoanRegister.Installments) + ':'
                + Format(objLoanRegister.Interest) + ':' + Format(objLoanRegister."Current Shares") + '::';
            until objLoanRegister.Next() = 0;
        end;
    end;


    procedure FnViewCommitteeApprovalLoan(LoanNo: Code[50]) loans: Text
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Loanperiod := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Loan  No.", LoanNo);
        objLoanRegister.SetFilter("Loan Product Type", objLoanRegister."Loan Product Type");
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        objLoanRegister.SetRange(Posted, false);
        objLoanRegister.SetRange("Committee Approval", objLoanRegister."Committee Approval"::Pending);
        if objLoanRegister.Find('-') then begin
            repeat
                loans := loans + objLoanRegister."Loan  No." + ':' + objLoanRegister."Client Code" + ':' + objLoanRegister."Client Name" + ':' +
                 objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Requested Amount") + ':' + Format(objLoanRegister."Approved Amount") + ':' + Format(objLoanRegister.Installments) + ':'
                + Format(objLoanRegister.Interest) + ':' + objLoanRegister."Committee Approval Comments" + ':' + Format(objLoanRegister."Committee Approval") + '::';
            until objLoanRegister.Next() = 0;
        end;
    end;

    procedure fnRegisterCommitee(IDNumber: Code[15]; MemberNo: Code[10]) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
        otp: Text;
        objMember2: Record InsiderLending;
    begin
        Registered := false;

        objMember2.Reset();
        objMember2.SetRange("ID No.", IDNumber);
        objMember2.SetRange(objMember2."Member No", MemberNo);
        // objMember2.SetRange("Position Held", objMember2."Position Held"::"Credit Committee");
        if objMember2.Find('-') then begin
            //Register Committee In Online Table    
            otp := Format(Random(10000));
            OnlineCommitteUsers.Init();
            OnlineCommitteUsers."Member No." := objMember2."Member No";
            OnlineCommitteUsers."Member Name" := objMember2."Member Name";
            OnlineCommitteUsers."ID Number" := objMember2."ID No.";
            OnlineCommitteUsers.Password := otp;
            OnlineCommitteUsers."Changed Password" := false;
            OnlineCommitteUsers."Email Address" := objMember2."E-Mail";
            OnlineCommitteUsers."Date Created" := Today;
            if OnlineCommitteUsers.Insert(true) then
                smtpc.Create(objMember2."E-Mail", 'Airport Sacco Credit Portal OTP', 'Your one time password to access Airport Sacco portal is: ' + otp, true);
            smtp.Send(smtpc, Enum::"Email Scenario"::Default);
            Registered := true;
            exit(Registered);
        end else
            Error('You are currently not registered as Credit Commitee of Airport Sacco! Please contact Airport Sacco');
    end;

    procedure FnCommiteeChangePassword(memberNumber: Code[100]; currentPass: Text; newPass: Text) updated: Boolean
    var
        EncryptionManagement: Codeunit "Cryptography Management";
        InStream: InStream;
        PasswordText: Text;
        OutStream: OutStream;
        DecryptPassword: Text;
    begin
        updated := false;
        OnlineCommitteUsers.reset;
        OnlineCommitteUsers.SetRange("Member No.", memberNumber);
        OnlineCommitteUsers.SetRange(Password, currentPass);
        if OnlineCommitteUsers.FindFirst() then begin
            OnlineCommitteUsers.Password := newPass;
            OnlineCommitteUsers."Changed Password" := true;
            if OnlineCommitteUsers.Modify(true) then
                updated := true;
            exit(updated);
        end;
    end;

    procedure fnInsertCommitteOTP(MemberNo: Code[10]; OTP: Integer; OTPMode: Text) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineCommitteUsers.Reset;
        OnlineCommitteUsers.SetRange("Member No.", MemberNo);
        if OnlineCommitteUsers.Find('-') then begin
            OnlineComitteOTP.Reset();
            OnlineComitteOTP.SetRange("Member No", OnlineCommitteUsers."Member No.");
            if OnlineComitteOTP.FindSet() then begin
                OnlineComitteOTP."Member No" := OnlineCommitteUsers."Member No.";
                OnlineComitteOTP."Member Name" := OnlineCommitteUsers."Member Name";
                OnlineComitteOTP.OTP := OTP;
                OnlineComitteOTP.Authenticated := false;
                if OnlineComitteOTP.Modify(true) then
                    smtpc.Create(OnlineCommitteUsers."Email Address", 'Airport Sacco Credit Portal Login OTP', 'Your One Time Password To Access Airport Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end else begin
                OnlineComitteOTP.Init();
                OnlineComitteOTP."Member No" := OnlineCommitteUsers."Member No.";
                OnlineComitteOTP."Member Name" := OnlineCommitteUsers."Member Name";
                OnlineComitteOTP.OTP := OTP;
                OnlineComitteOTP.Authenticated := false;
                if OnlineComitteOTP.Insert(true) then
                    smtpc.Create(OnlineCommitteUsers."Email Address", 'Airport Sacco Credit Portal Login OTP', 'Your One Time Password To Access Airport Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end;
        end;
    end;

    procedure fnResendCommitteeOTP(MemberNo: Code[10]; OTP: Integer; OTPMode: Text) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineCommitteUsers.Reset;
        OnlineCommitteUsers.SetRange("Member No.", MemberNo);
        if OnlineCommitteUsers.Find('-') then begin
            OnlineComitteOTP.Reset();
            OnlineComitteOTP.SetRange("Member No", OnlineCommitteUsers."Member No.");
            if OnlineComitteOTP.FindSet() then begin
                OnlineComitteOTP."Member No" := OnlineCommitteUsers."Member No.";
                OnlineComitteOTP."Member Name" := OnlineCommitteUsers."Member Name";
                OnlineComitteOTP.OTP := OTP;
                OnlineComitteOTP.Authenticated := false;
                if OnlineComitteOTP.Modify(true) then
                    smtpc.Create(OnlineCommitteUsers."Email Address", 'Airport Sacco Credit Portal Password Reset OTP', 'Your One Time Password To Access Airport Sacco portal is: ' + Format(OTP), true);
                smtp.Send(smtpc, Enum::"Email Scenario"::Default);
                Registered := true;
                exit(Registered);
            end;

        end;
    end;

    procedure fnVerifyCommitteeOTP(MemberNo: Code[10]; OTP: Integer) Registered: Boolean
    var
        smtpc: Codeunit "Email Message";
        smtp: Codeunit Email;
    begin
        Registered := false;
        OnlineComitteOTP.Reset();
        OnlineComitteOTP.SetRange("Member No", MemberNo);
        OnlineComitteOTP.SetRange(OnlineComitteOTP.Authenticated, false);
        if OnlineComitteOTP.FindFirst then begin
            OnlineComitteOTP.Authenticated := true;
            if OnlineComitteOTP.Modify(true) then
                Registered := true;
            exit(Registered);
        end;
    end;

    procedure fnConfirmCommiteeRegistration(MemberNo: Code[40]; otp: Text; newpassword: Text) status: Boolean
    begin
        status := false;
        OnlineCommitteUsers.Reset;
        OnlineCommitteUsers.SetRange(OnlineCommitteUsers."Member No.", MemberNo);
        OnlineCommitteUsers.SetRange(OnlineCommitteUsers."Changed Password", false);
        if OnlineCommitteUsers.Find('-') then begin
            OnlineCommitteUsers.Password := newpassword;
            OnlineCommitteUsers."Changed Password" := true;
            if OnlineCommitteUsers.Modify(true) then
                status := true;
            exit(status);
        end
        else
            exit(status);
    end;

    procedure fnLoanAppraisal(LoanNo: Code[50]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        LoanAppraisal: Report 50084;
        Base64Convert: Codeunit "Base64 Convert";
        LoansRegister: Record "Loans Register";

    begin


        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        if LoansRegister.Find('-') then begin
            LoanAppraisal.SetTableView(LoansRegister);
            TempBlob.CreateOutStream(StatementOutstream);
            if LoanAppraisal.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure fnApproveLoan(LoanNo: Code[50]; Comments: Text[2048]) Approved: Boolean
    begin
        Approved := false;
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        if LoansRegister.Find('-') then begin
            LoansRegister."Committee Approval" := LoansRegister."Committee Approval"::Approved;
            LoansRegister."Committee Approval Comments" := Comments;
            if LoansRegister.Modify(true) then
                approved := True;
            exit(Approved);
        end;

    end;

    procedure fnRejectLoan(LoanNo: Code[50]; Comments: Text[2048]) Rejected: Boolean
    begin
        Rejected := false;
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        if LoansRegister.Find('-') then begin
            LoansRegister."Committee Approval" := LoansRegister."Committee Approval"::Rejected;
            LoansRegister."Committee Approval Comments" := Comments;
            if LoansRegister.Modify(true) then
                Rejected := True;
            exit(Rejected);
        end;

    end;

}



