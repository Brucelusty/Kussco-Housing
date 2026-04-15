//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50997 "Loan Demand Notices Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Default Notices Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = true;
                }
                field("Loan In Default"; Rec."Loan In Default")
                {
                    Editable = true;
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    Editable = false;
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                    Editable = false;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    Editable = false;
                }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                {
                    Editable = false;
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                    Editable = true;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                }
                field("Loan Outstanding Balance"; Rec."Loan Outstanding Balance")
                {
                    Editable = false;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    Editable = true;

                    trigger OnValidate()
                    begin
                        FnenableVisbility();
                    end;
                }
                group("Auctioneer Details")
                {
                    Visible = VarAuctioneerDetailsVisible;
                    field("Auctioneer No"; Rec."Auctioneer No")
                    {
                    }
                    field("Auctioneer  Name"; Rec."Auctioneer  Name")
                    {
                        Editable = false;
                    }
                    field("Auctioneer Address"; Rec."Auctioneer Address")
                    {
                        Editable = false;
                    }
                    field("Auctioneer Mobile No"; Rec."Auctioneer Mobile No")
                    {
                        Editable = false;
                    }
                    field("Auctioneer Email"; Rec."Auctioneer Email")
                    {
                        Editable = false;
                    }
                }
                field("Demand Notice Date"; Rec."Demand Notice Date")
                {
                    Editable = DemandNoticeDateEditable;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Email Sent"; Rec."Email Sent")
                {
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Demand Letters")
            {
                action("Demand Notice Letter 1")
                {
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    begin

                        /*ObjLoans.RESET;
                        ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        IF ObjLoans.FINDSET THEN BEGIN
                          Report.run(172925,TRUE,TRUE,ObjLoans);
                          END;*/

                        ObjDemandNotice.Reset;
                        ObjDemandNotice.SetRange(ObjDemandNotice."Document No", Rec."Document No");
                        if ObjDemandNotice.FindSet then begin
                            Report.run(172925, true, true, ObjDemandNotice);
                        end;


                    end;
                }
                action("Demand Notice Letter 2")
                {
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    begin

                        /*ObjLoans.RESET;
                        ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        IF ObjLoans.FINDSET THEN BEGIN
                          Report.run(172925,TRUE,TRUE,ObjLoans);
                          END;*/

                        /*  Cust.Reset;
                         Cust.SetRange(Cust."ID No.", Rec."Member ID No");
                         if Cust.FindSet then begin
                             Report.run(173001, true, true, ObjDemandNotice);
                         end; */
                        ObjDemandNotice.Reset;
                        ObjDemandNotice.SetRange(ObjDemandNotice."Document No", Rec."Document No");
                        if ObjDemandNotice.FindSet then begin
                            Report.run(173001, true, true, ObjDemandNotice);
                        end;


                    end;
                }
                 action("Guarantor Demand Notice Letter 2")
                {
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    begin

                        /*ObjLoans.RESET;
                        ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        IF ObjLoans.FINDSET THEN BEGIN
                          Report.run(172925,TRUE,TRUE,ObjLoans);
                          END;*/

                        /*  Cust.Reset;
                         Cust.SetRange(Cust."ID No.", Rec."Member ID No");
                         if Cust.FindSet then begin
                             Report.run(173001, true, true, ObjDemandNotice);
                         end; */
                        ObjDemandNotice.Reset;
                        ObjDemandNotice.SetRange(ObjDemandNotice."Document No", Rec."Document No");
                        if ObjDemandNotice.FindSet then begin
                            Report.run(173002, true, true, ObjDemandNotice);
                        end;


                    end;
                }
                action("CRB Demand Letter")
                {
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //Visible = VarCRBNoticeVisible;

                    trigger OnAction()
                    begin

                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.run(172926, true, true, ObjLoans);
                        end;
                    end;
                }
                action("Debt Collector Demand Letter")
                {
                    Caption = 'Debt Collector Demand Letter';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //Visible = VarDebtCollectorVisible;

                    trigger OnAction()
                    var
                        Loans: Record "Loans Register";
                    begin
                        Loans.reset;
                        Loans.SetRange(loans."Loan  No.", Rec."Loan In Default");
                        if loans.FindFirst() then begin
                            Report.run(172925, true, true, Loans);
                        end;

                    end;
                }
                action("Send Demand Notice Via Mail")
                {
                    Caption = 'Send Demand Notice Letter Via Mail';
                    Enabled = EnableSendNotice;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    var
                        Filename: Text[100];
                        //SMTPSetup: Record "SMTP Mail Setup";
                        //SMTPMail: Codeunit "SMTP Mail";
                        VarMemberEmail: Text[50];
                        ObjMember: Record "Members Register";
                        Attachment: Text[250];
                        ObjLoanType: Record "Loan Products Setup";
                        VarProductDescription: Code[50];
                        VarMemberName: Text[250];
                    begin
                        if Confirm('Confirm Action', false) = true then begin

                            //  SMTPSetup.Get();

                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                            if ObjLoans.FindSet then begin
                                if ObjMember.Get(Rec."Member No") then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");
                                end;
                                Filename := '';
                                //Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
                                //Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
                                if ObjLoanType.Get(Rec."Loan Product") then begin
                                    VarProductDescription := ObjLoanType."Product Description";
                                end;

                                //===========================================Get House Leaders Mails And Department Mail to Cc.
                                ObjGensetup.Get();
                                VarDepartmentMail := ObjGensetup."Credit Department E-mail";
                                if ObjHouseGroup.Get(Rec."Member House Group") then begin
                                    VarHouseLeaderMail := ObjHouseGroup."Group Leader Email";
                                    VarAssHouseLeaderMail := ObjHouseGroup."Assistant Group Leader Email";
                                end;
                                //===========================================End Get House Leaders Mails And Department Mail to Cc.

                                if ObjLoanType.Get(Rec."Loan Product") then begin
                                    VarLoanProductName := ObjLoanType."Product Description";
                                end;

                                VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec."Member Name");

                                VarEmailSubject := 'Loan Demand Notice - ' + Rec."Loan In Default";
                                VarEmailBody := 'Kindly find attached a Loan Demand Notice for your ' + VarProductDescription + ' Account No. ' + Rec."Loan In Default" + ' that is in default.';

                                // EnableSend := SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', VarDepartmentMail + ';' + VarHouseLeaderMail + ';' + VarAssHouseLeaderMail);

                                if Rec."Notice Type" = Rec."notice type"::"2nd Demand Notice" then begin
                                    FnRunSendCopyGuarantors(Rec."Loan In Default", Rec."Member Name");
                                end;
                            end;
                        end;
                    end;
                }
                action("Send CRB Demand Via Mail")
                {
                    Caption = 'Send CRB Notice Letter Via Mail';
                    Enabled = EnableSendNotice;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    //    Visible = VarCRBNoticeVisible;

                    trigger OnAction()
                    var
                        Filename: Text[100];
                        //SMTPSetup: Record "SMTP Mail Setup";
                        // SMTPMail: Codeunit "SMTP Mail";
                        VarMemberEmail: Text[50];
                        ObjMember: Record "Members Register";
                        Attachment: Text[250];
                        ObjLoanType: Record "Loan Products Setup";
                        VarProductDescription: Code[50];
                        VarMemberName: Text[250];
                    begin
                        if Confirm('Confirm Action', false) = true then begin
                            // SMTPSetup.Get();

                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                            if ObjLoans.FindSet then begin
                                if ObjMember.Get(Rec."Member No") then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");
                                end;
                                Filename := '';
                                // Filename := SMTPSetup."Path to Save Report" + 'CRBNotice.pdf';
                                // Report.SaveAsPdf(Report::"Loan CRB Notice", Filename, ObjLoans);

                                if ObjLoanType.Get(Rec."Loan Product") then begin
                                    VarProductDescription := ObjLoanType."Product Description";
                                end;

                                //===========================================Get House Leaders Mails And Department Mail to Cc.
                                ObjGensetup.Get();
                                VarDepartmentMail := ObjGensetup."Credit Department E-mail";
                                if ObjHouseGroup.Get(Rec."Member House Group") then begin
                                    VarHouseLeaderMail := ObjHouseGroup."Group Leader Email";
                                    VarAssHouseLeaderMail := ObjHouseGroup."Assistant Group Leader Email";
                                end;
                                VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec."Member Name");
                                //===========================================End Get House Leaders Mails And Department Mail to Cc.

                                VarEmailSubject := 'Loan CRB Listing Notice - ' + Rec."Loan In Default";
                                VarEmailBody := 'Kindly find attached a CRB Listing Notice for your ' + VarProductDescription + ' Account No. ' + Rec."Loan In Default" + ' that is in default.';

                                // EnableSend := SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'CRBNotice.pdf', VarDepartmentMail);


                            end;
                        end;
                    end;
                }
                action("Send DebtCollector Demand  Mail")
                {
                    Caption = 'Send Debt Collector Demand Letter Via Mail';
                    Enabled = EnableSendNotice;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    //Visible = VarDebtCollectorVisible;

                    trigger OnAction()
                    var
                        Filename: Text[100];
                        //SMTPSetup: Record "SMTP Mail Setup";
                        //SMTPMail: Codeunit "SMTP Mail";
                        VarMemberEmail: Text[50];
                        ObjMember: Record "Members Register";
                        Attachment: Text[250];
                        ObjLoanType: Record "Loan Products Setup";
                        VarProductDescription: Code[50];
                        ObjDemandNotices: Record "Default Notices Register";
                        VarMemberName: Text[250];
                    begin
                        if Confirm('Confirm Action', false) = true then begin
                            //   SMTPSetup.Get();

                            ObjDemandNotices.Reset;
                            ObjDemandNotices.SetRange(ObjDemandNotices."Document No", Rec."Document No");
                            if ObjDemandNotices.FindSet then begin
                                if ObjMember.Get(Rec."Member No") then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");
                                end;
                                Filename := '';
                                //Filename := SMTPSetup."Path to Save Report" + 'DebtCollectorNotice.pdf';
                                //  Report.SaveAsPdf(Report::"Loan Debt Collector Notice", Filename, ObjDemandNotices);


                                if ObjLoanType.Get(Rec."Loan Product") then begin
                                    VarProductDescription := ObjLoanType."Product Description";
                                end;

                                //===========================================Get House Leaders Mails And Department Mail to Cc.
                                ObjGensetup.Get();
                                VarDepartmentMail := ObjGensetup."Credit Department E-mail";
                                if ObjHouseGroup.Get(Rec."Member House Group") then begin
                                    VarHouseLeaderMail := ObjHouseGroup."Group Leader Email";
                                    VarAssHouseLeaderMail := ObjHouseGroup."Assistant Group Leader Email";
                                end;

                                VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec."Member Name");
                                //===========================================End Get House Leaders Mails And Department Mail to Cc.

                                VarEmailSubject := 'INSTRUCTIONS TO FULLY RECOVER DEFAULTED LOAN ' + Rec."Loan In Default";
                                VarEmailBody := 'Kindly find attached Instructions to Fully Recover a ' + VarProductDescription + ' Account No. ' + Rec."Loan In Default" + ' that is in default.';
                                VarCCEmails := VarMemberEmail + ';' + VarDepartmentMail;

                                //EnableSend := SurestepFactory.FnSendStatementViaMail("Auctioneer  Name", VarEmailSubject, VarEmailBody,Rec."Auctioneer Email", 'DebtCollectorNotice.pdf', VarCCEmails);

                            end;
                        end;
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                    end;
                    // var
                    //     ApprovalEntries: Page "Approval Entries";
                    // begin
                    //     DocumentType := Documenttype::DemandNotice;
                    //     ApprovalEntries.Setfilters(Database::"Default Notices Register", DocumentType,Rec."Document No");
                    //     ApprovalEntries.Run;
                    // end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if WorkflowIntegration.CheckDemandNoticeApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntegration.OnSendDemandNoticeForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /* IF ApprovalsMgmt.CheckDemandNoticeApprovalsWorkflowEnabled(Rec) THEN
                           ApprovalsMgmt.OnCancelDemandNoticeApprovalRequest(Rec);*/

                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            WorkflowIntegration.OnCancelDemandNoticeApprovalRequest(Rec);


                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        IF Rec.Status=Status::Approved THEN BEGIN
          OpenApprovalEntriesExist:=FALSE;
          CanCancelApprovalForRecord:=FALSE;
          EnabledApprovalWorkflowsExist:=FALSE;
          END;
          */

    end;

    trigger OnAfterGetRecord()
    begin
        FnenableVisbility;
        FNenableEditing;
        FnRunShowRelevantButton;

        EnableSendNotice := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableSendNotice := true;
    end;

    trigger OnOpenPage()
    begin
        FnenableVisbility;
        FNenableEditing;
        FnRunShowRelevantButton;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SurestepFactory: Codeunit "Au Factory";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        DocNo: Code[20];
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Enum "Gen. Journal Account Type";
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;

        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjDemands: Record "Default Notices Register";
        VarAuctioneerDetailsVisible: Boolean;
        // SMTPSetup: Record "SMTP Mail Setup";
        ObjHouseGroup: Record "Member House Groups";
        EnableSendNotice: Boolean;
        MemberNoEditable: Boolean;
        LoanInDefaultEditable: Boolean;
        NoticeTypeEditable: Boolean;
        DemandNoticeDateEditable: Boolean;
        EnableSend: Boolean;
        VarEmailSubject: Text[200];
        VarEmailBody: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarLoanProductName: Text[50];
        ObjGensetup: Record "Sacco General Set-Up";
        VarDepartmentMail: Text[50];
        VarHouseLeaderMail: Text[50];
        VarAssHouseLeaderMail: Text[50];
        VarDemandNoticeVisible: Boolean;
        VarCRBNoticeVisible: Boolean;
        VarDebtCollectorVisible: Boolean;
        VarCCEmails: Text;
        ObjDemandNotice: Record "Default Notices Register";
        WorkflowIntegration: codeunit WorkflowIntegration;
        Cust: Record Customer;
        Name: text;
        PhoneNo: Text;
        Address: Text;

    local procedure FnenableVisbility()
    begin
        VarAuctioneerDetailsVisible := false;

        if Rec."Notice Type" = Rec."notice type"::"Debt Collector Notice" then begin
            VarAuctioneerDetailsVisible := true;
        end
    end;

    local procedure FNenableEditing()
    begin
        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            LoanInDefaultEditable := true;
            NoticeTypeEditable := true;
            DemandNoticeDateEditable := true
        end else
            MemberNoEditable := false;
        LoanInDefaultEditable := false;
        NoticeTypeEditable := false;
        DemandNoticeDateEditable := false;
    end;

    local procedure FnRunSendCopytoHouseGroupLeader(VarDemandNoticeNo: Code[30]; VarHouseGroup: Code[50]; VarMemberName: Text[100])
    var
        Filename: Text[100];
        // SMTPSetup: Record "SMTP Mail Setup";
        //  SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record "Members Register";
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
    begin
        //================================================Send to Group Leader
        // SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin
            if ObjHouseGroup.Get(VarHouseGroup) then begin
                VarMemberEmail := Lowercase(ObjHouseGroup."Group Leader Email");
                LeaderName := Lowercase(ObjHouseGroup."Group Leader Name");
            end;
            Filename := '';
            // Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
            // Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);

            if ObjLoanType.Get(Rec."Loan Product") then begin
                VarLoanProductName := ObjLoanType."Product Description";
            end;

            VarEmailSubject := 'Loan Demand Notice';
            VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + Rec."Loan In Default" + ' defaulted by ' + Rec."Member Name" + ' a member of your House Group';

            //EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

        end;


        //==============================================Send to Assistant Group Leader
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin
            if ObjHouseGroup.Get(VarHouseGroup) then begin
                VarMemberEmail := Lowercase(ObjHouseGroup."Assistant Group Leader Email");
                LeaderName := Lowercase(ObjHouseGroup."Assistant Group Name");
            end;
            Filename := '';
            //  Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
            //  Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);

            if ObjLoanType.Get(Rec."Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;

            VarEmailSubject := 'Loan Demand Notice';
            VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + Rec."Loan In Default" + ' defaulted by ' + Rec."Member Name" + ' a member of your House Group';

            // EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');
        end;
    end;

    local procedure FnRunSendCopyGuarantors(VarLoanNo: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        // SMTPSetup: Record "SMTP Mail Setup";
        //SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record "Members Register";
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        MemberName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
    begin
        // SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", VarLoanNo);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                        VarMemberEmail := Lowercase(ObjMember."E-Mail");
                        MemberName := Lowercase(ObjMember.Name);
                    end;

                    Filename := '';
                    //  Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
                    // Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
                    if ObjLoanType.Get(Rec."Loan Product") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;

                    if ObjLoanType.Get(Rec."Loan Product") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;

                    VarEmailSubject := 'Loan Demand Notice';
                    VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + Rec."Loan In Default" + ' defaulted by ' + Rec."Member Name";

                //  EnableSend := SurestepFactory.FnSendStatementViaMail(MemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

                until ObjLoanGuarantors.Next = 0;
            end;
        end;
    end;

    local procedure FnRunSendDemandNoticeCopyDepartment(VarDemandNoticeNo: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        //  SMTPSetup: Record "SMTP Mail Setup";
        //SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record "Members Register";
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        // SMTPSetup.Get();
        ObjGensetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin

            if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
                LeaderName := 'Credit Team';
            end;
            Filename := '';
            //  Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
            // Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
            if ObjLoanType.Get(Rec."Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;


            if ObjLoanType.Get(Rec."Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;

            VarEmailSubject := 'Loan Demand Notice';
            VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + Rec."Loan In Default" + ' defaulted by ' + Rec."Member Name";

            //  EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

        end;
    end;

    local procedure FnRunSendCRBNoticeCopyDepartment(VarLoanDefaulted: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        // SMTPSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record "Members Register";
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        //    SMTPSetup.Get();
        ObjGensetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanDefaulted);
        if ObjLoans.FindSet then begin

            if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
                LeaderName := 'Credit Team';
            end;
            Filename := '';
            // Filename := SMTPSetup."Path to Save Report" + 'CRBNotice.pdf';
            //Report.SaveAsPdf(Report::"Loan CRB Notice", Filename, ObjLoans);

            if ObjLoanType.Get(Rec."Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;


            VarEmailSubject := 'Loan CRB Notice';
            VarEmailBody := 'Please find attached a CRB notice for a ' + VarLoanProductName + 'Loan Account ' + Rec."Loan In Default" + ' defaulted by ' + Rec."Member Name";

            //  EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'CRBNotice.pdf', '');

        end;
    end;

    local procedure FnRunSendAuctioneerNoticeCopyDepartment(VarDemandNoticeNo: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        //  SMTPSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record "Members Register";
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        //  SMTPSetup.Get();
        ObjGensetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", VarDemandNoticeNo);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                        VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
                        LeaderName := Lowercase(ObjMember.Name);
                    end;
                    Filename := '';
                    //  Filename := SMTPSetup."Path to Save Report" + 'AuctioneerNotice.pdf';
                    // Report.SaveAsPdf(Report::"Loan Debt Collector Notice", Filename, ObjLoans);
                    if ObjLoanType.Get(Rec."Loan Product") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;

                    VarEmailSubject := 'Loan Auctioneer Notice';
                    VarEmailBody := 'Please find attached Auctioneer notice for a ' + VarLoanProductName + 'Loan Account ' + Rec."Loan In Default" + ' defaulted by ' + Rec."Member Name";

                //   EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'AuctioneerNotice.pdf', '');
                until ObjLoanGuarantors.Next = 0;
            end;
        end;
    end;

    local procedure FnRunShowRelevantButton()
    begin
        VarDemandNoticeVisible := false;
        VarCRBNoticeVisible := false;
        VarDebtCollectorVisible := false;

        if (Rec."Notice Type" = Rec."notice type"::"1st Demand Notice") or (Rec."Notice Type" = Rec."notice type"::"2nd Demand Notice") then begin
            VarDemandNoticeVisible := true;
        end;

        if Rec."Notice Type" = Rec."notice type"::"CRB Notice" then begin
            VarCRBNoticeVisible := true;
        end;

        if Rec."Notice Type" = Rec."notice type"::"Debt Collector Notice" then begin
            VarDebtCollectorVisible := true;
        end;
    end;
}






