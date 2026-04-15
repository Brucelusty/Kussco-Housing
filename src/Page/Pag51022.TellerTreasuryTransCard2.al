page 51022 "Teller & Treasury Trans Card2"
{
    ApplicationArea = All;
    Caption = 'Teller & Treasury Trans Card';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Treasury Transactions";
    // SourceTableView = WHERE(requested=filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No;Rec.No)
                {
                    Editable = false;
                }
                field(Teller;Rec."To Account")
                {
                    Caption = 'Teller';
                }
                field("Amount to request";Rec."Amount to request")
                {
                    Caption = 'Amount to Request';
                }
                field("Date Requested";Rec."Requested Date")
                {
                    Caption = 'Date Requested';
                    Editable = false;
                }
                field("Time Requested";Rec."Requested Time")
                {
                    Caption = 'Time Requested';
                    Editable = false;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                }
                field(Requested;Rec.Requested)
                {
                    Caption = 'Requested';
                    Editable = false;
                    Enabled = false;
                }
                field("Destination Account Balance";Rec."Destination Account Balance")
                {
                    Editable = false;
                    // Enabled = false;
                }
            }
            part("Treasury Denominations"; "Treasury Denominations")
            {
                SubPageLink = No=FIELD(No);
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Payment Receipts';
                SubPageLink = "Table ID" = const(Database::"Treasury Transactions"), "No." = field("No");
                Enabled = pettyCash;
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(Attachment)
            {
                Caption = 'Receipts';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Promoted = true;
                PromotedCategory = Report;
                Enabled = pettyCash;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
        area(processing)
        {
            action(Request)
            {
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                noOfRecords: Integer;
                docFactbox: Record "Document Attachment";
                begin
                    if rec.requested = TRUE THEN ERROR('You have already requested for this funds');

                    if Rec."Amount to request" = 0 THEN ERROR('You cannot request a zero amount');

                    //Petty Cash Till Requisition
                    if Rec."Is Petty Cash" then begin
                        docFactbox.Reset();
                        docFactbox.SetRange("Table ID", Database::"Treasury Transactions");
                        docFactbox.SetRange("No.", Rec."No");
                        if docFactbox.FindSet() then begin
                            noOfRecords:= docFactbox.Count;
                        end;
                        if noOfRecords <= 0 then Error('Ensure that the receipts of the payments done are attached to this petty cash.');
                    end;
                    //
                    Coinage.RESET;
                    Coinage.SETRANGE(Coinage.No,Rec.No);
                    IF Coinage.FIND('-') THEN BEGIN
                        Rec.CALCFIELDS("Total Cash on Treasury Coinage");
                        IF Rec."Amount to request" <> Rec."Total Cash on Treasury Coinage" THEN BEGIN
                            ERROR('Amount must be equal before performing this operation');
                        END;
                        Rec.requested:=TRUE;
                        Rec.Requester:=USERID;
                        Rec."Requested Date":=TODAY;
                        Rec."Requested Time":=TIME;
                        Rec.MODIFY;
                    END;
                end;
            }
            action(Receive)
            {
                Caption = 'Receive';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Rec.Amount);
                    Rec.TESTFIELD(Rec."From Account");
                    Rec.TESTFIELD(Rec."To Account");
                    Rec.Approved:=TRUE;
                    GenSetup.GET;
                    
                    if Rec."Transaction Type"=Rec."Transaction Type"::"Issue From Bank" THEN
                    Rec.TESTFIELD(Rec."Cheque No.");
                    
                    CurrentTellerAmount:=0;
                    if Rec.Posted=TRUE THEN
                    ERROR('The transaction has already been received and posted.');
                    
                    if Rec."Transaction Type" = Rec."Transaction Type"::"Inter Teller Transfers" THEN BEGIN
                    if Rec.Approved = FALSE THEN
                    ERROR('Inter Teller Transfers must be approved.');
                    END;
                    
                    //IF ("Transaction Type"="Transaction Type"::"Return To Treasury") THEN
                    //ERROR('The issue has not yet been made and therefore you cannot continue with this transaction.');
                    
                    IF (Rec."Transaction Type"=Rec."Transaction Type"::"Issue To Teller") OR
                    (Rec."Transaction Type"=Rec."Transaction Type"::"Branch Treasury Transactions") OR
                    (Rec."Transaction Type"=Rec."Transaction Type"::"Inter Teller Transfers") THEN BEGIN
                    IF Rec.Issued=Rec.Issued::No THEN
                    ERROR('The issue has not yet been made and therefore you cannot continue with this transaction.');
                    
                    TellerTill.RESET;
                    //TellerTill.SETRANGE(TellerTill."Account Type",TellerTill."Account Type"::Cashier);
                    TellerTill.SETRANGE(TellerTill."No.",Rec."To Account");
                    IF TellerTill.FIND('-') THEN BEGIN
                    IF UPPERCASE(USERID) <> TellerTill.CashierID THEN
                    ERROR('You do not have permission to transact on this teller till/Account.');
                    
                    TellerTill.CALCFIELDS(TellerTill.Balance);
                    CurrentTellerAmount:=TellerTill.Balance;
                    IF CurrentTellerAmount+Rec.Amount>TellerTill."Maximum Teller Withholding" THEN
                    ERROR('The transaction will result in the teller having a balance more than the maximum allowable therefor terminated.');
                    
                    END;
                    END;
                    
                    /*//POLICE
                    Banks.RESET;
                    Banks.SETRANGE(Banks."No.","From Account");
                    IF Banks.FIND('-') THEN BEGIN
                    Banks.CALCFIELDS("Balance (LCY)");
                    IF Amount > Banks."Balance (LCY)" THEN
                    ERROR('You cannot receive more than balance in ' + "From Account")
                    END;
                    *///POLICE
                    
                    IF CONFIRM('Are you sure you want to make this receipt?',FALSE) = FALSE THEN
                    EXIT;
                    
                    //Delete any items present
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'FTRANS');
                    GenJournalLine.DELETEALL;
                    
                    IF DefaultBatch.GET('GENERAL','FTRANS') = FALSE THEN BEGIN
                    DefaultBatch.INIT;
                    DefaultBatch."Journal Template Name":='GENERAL';
                    DefaultBatch.Name:='FTRANS';
                    DefaultBatch.INSERT;
                    END;
                    
                    lines:=lines+10000;
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='FTRANS';
                    GenJournalLine."Document No.":=Rec.No;
                    GenJournalLine."Line No.":=lines;
                    GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                    GenJournalLine."Account No.":=Rec."From Account";
                    GenJournalLine."External Document No.":=Rec."Cheque No.";
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine.Description:=Rec.Description;
                    GenJournalLine."Currency Code":=Rec."Currency Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=-Rec.Amount;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                    GenJournalLine."Bal. Account No.":=Rec."To Account";
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                     /*
                    lines:=lines+10000;
                    //Post shortages/Excess
                    IF "Excess/Shortage Amount"<>0 THEN BEGIN
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='FTRANS';
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."Line No.":=lines;
                    GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                    GenJournalLine."Account No.":="From Account";
                    GenJournalLine."External Document No.":="Cheque No.";
                    GenJournalLine."Posting Date":=TODAY;
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine.Description:='Excess/Shortages';
                    GenJournalLine."Currency Code":="Currency Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:="Excess/Shortage Amount";
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    IF "Excess/Shortage Amount">0 THEN
                    GenJournalLine."Bal. Account No.":=GenSetup."Teller Shortage Account"
                    ELSE GenJournalLine."Bal. Account No.":=GenSetup."Teller Excess Account";
                    //GenJournalLine."Bal. Account No.":="To Account";
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;
                    END;
                    //Post shortages/Excess
                      */
                    
                    //Post
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                    GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                    END;
                    
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                    GenJournalLine.DELETEALL;
                    //Post
                    
                    //GenJournalLine.RESET;
                    //GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'GENERAL');
                    //GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'FTRANS');
                    //IF GenJournalLine.FIND('-') = FALSE THEN BEGIN
                    Rec.Posted:=TRUE;
                    Rec."Date Posted":=TODAY;
                    Rec."Time Posted":=TIME;
                    Rec."Posted By":=UPPERCASE(USERID);
                    
                    Rec.Received:=Rec.Received::Yes;
                    Rec."Date Received":=TODAY;
                    Rec."Time Received":=TIME;
                    Rec."Received By":=UPPERCASE(USERID);
                    Rec.MODIFY;
                    
                    //END;

                end;
            }
            action("EOD Report")
            {
                Caption = 'EOD Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                    var
                   transdate: date;
                begin
                    transdate := Today;
                    Trans.RESET;
                    Trans.SETRANGE("Posting Date",transdate);
                    //Trans.SETRANGE(Trans."Date Posted","Date Posted");
                    // IF Trans.FIND('-') THEN
                    REPORT.RUN(173040,TRUE,True,Trans)

                    
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;
        */
        
        /*
        IF Posted= TRUE THEN
        CurrPage.EDITABLE:=FALSE
        */

    end;

    trigger OnAfterGetCurrRecord() begin
        if rec."Is Petty Cash" then begin
            pettyCash := true;
        end else pettyCash := false;
    end;
    trigger OnAfterGetRecord() begin
        if rec."Is Petty Cash" then begin
            pettyCash := true;
        end else pettyCash := false;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        Banks: Record "Bank Account";
        BankBal: Decimal;
        TotalBal: Decimal;
        pettyCash: Boolean;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        Trans: Record "Bank Account Ledger Entry";
        UsersID: Record User;
        StatusPermissions: Record "Status Change Permision";
        "Gen-Setup": Record "Sacco General Set-Up";
        SendToAddress: Text[30];
        BankAccount: Record "Bank Account";
        MailContent: Text[150];
        SenderName: Code[20];
        TreauryTrans: Record "Treasury Transactions";
        Coinage: Record "Treasury Coinage";
        GenSetup: Record "Sacco General Set-Up";
        lines: Integer;
        MaxWithholding: Decimal;
        FrmAcc: Boolean;
        SMTPMAIL: Record "Email Account";

    procedure SENDMAIL()
    begin
        //sent mail on authorisation
        /*
        BankAccount.RESET;
        BankAccount.SETRANGE(BankAccount."No.","From Account");
        IF BankAccount.FIND('-') THEN BEGIN
        SenderName:=BankAccount.Name;
        END;
        
        BankAccount.RESET;
        BankAccount.SETRANGE(BankAccount."No.","To Account");
        IF BankAccount.FIND('-') THEN BEGIN
         MailContent:='You have received Kshs.'+' '+FORMAT(Amount)+' '+'from'+ ' '+SenderName+
         ' '+ 'the transaction type is' + ', '+ FORMAT("Transaction Type")+ ', ' +'TR.No' +' '+No+
         ' '+ 'Date'+ ' '+FORMAT("Transaction Date")+'.';
        
        REPEAT
        "Gen-Setup".GET();
        SMTPMAIL.NewMessage("Gen-Setup"."Sender Address",'TELLER & TEASURY TRANSACTIONS'+''+'');
        SMTPMAIL.SetWorkMode();
        SMTPMAIL.ClearAttachments();
        SMTPMAIL.ClearAllRecipients();
        SMTPMAIL.SetDebugMode();
        SMTPMAIL.SetFromAdress("Gen-Setup"."Sender Address");
        SMTPMAIL.SetHost("Gen-Setup"."Outgoing Mail Server");
        SMTPMAIL.SetUserID("Gen-Setup"."Sender User ID");
        SMTPMAIL.AddLine(MailContent);
        SendToAddress:=BankAccount."E-Mail";
        SMTPMAIL.SetToAdress(SendToAddress);
        SMTPMAIL.Send;
        UNTIL BankAccount.NEXT=0;
        END;
        */

    end;
}

