//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50669 "Member Accounts List"
{
    ApplicationArea = All;
    CardPageID = "Member Account Card View";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type" = filter("FOSA Account"), Status = filter(Active), "Employer Code" = filter(<>'STAFF'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Account No';
                }
                field("Account Type Name"; Rec."Account Type Name")
                {
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    Caption = 'Member No';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Account Name';
                }
                field("Personal No."; Rec."Personal No.")
                {
                    Caption = 'Payroll Number';
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                }
                field("ATM No.";Rec."ATM No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Last Account Trans";Rec."Last Account Trans")
                {
                    Caption = 'Last Transaction Date';
                }
                field(Balance; Rec.Balance)
                {
                    StyleExpr = CoveragePercentStyle;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "FOSA Statistics FactBox")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action1102755228)
                {
                }
                separator(Action1102755226)
                {
                }
                separator(Action1102755225)
                {
                }
                action("Member Details")
                {
                    Caption = 'Member Details';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                separator(Action1102755222)
                {
                }
                action("ATM Cards Linked")
                {
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "ATM Card Nos Buffer";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    Caption = 'Account Signatories';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Signatories Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    Caption = 'Account Agents';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Agent List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Charge Statement Fee")
                {
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ObjAccount.Reset;
                        ObjAccount.SetRange(ObjAccount."No.", Rec."No.");
                        if ObjAccount.Find('-') then
                            Report.run(172142, true, false, ObjAccount)
                    end;
                }
                action(ImportMultipleCustomerPictures)
                {
                    Caption = 'Import Multiple Customer Pictures';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Multiple Customer Pictures';

                    trigger OnAction()
                    begin
                        ImportMultipleCustomerPicturesFromZip();
                    end;
                }


                action(ImportMultipleCustomerSignatures)
                {
                    Caption = 'Import Multiple Customer Signatures';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Multiple Customer Signatures';

                    trigger OnAction()
                    begin
                        ImportMultipleCustomerSignaturesFromZip();
                    end;
                }
            }
            group(ActionGroup1102755220)
            {
                action("Nominee Details")
                {
                    Caption = 'Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755217)
                {
                }
                action("Member Statement")
                {
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        /*IF ("Assigned System ID"<>'')  THEN BEGIN //AND ("Assigned System ID"<>USERID)
                          IF UserSetup.GET(USERID) THEN
                          BEGIN
                            IF UserSetup."View Special Accounts"=FALSE THEN ERROR ('You do not have permission to view this account Details, Contact your system administrator! ')
                          END;
                        END;*/
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(172886, true, false, Cust);

                    end;
                }
                action("Page Vendor Statement")
                {
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172476, true, false, Vend)
                    end;
                }
                action("Accounts Balances")
                {
                    Caption = 'Accounts Balances';
                    Image = GLAccountBalance;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = report "Accounts Balances";
                }
                action("Members Account Balance")
                {
                    Caption = 'Full Member Account Balances';
                    Image = CalculateBalanceAccount;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = report "Member Accounts Bal Listing";
                }
                action("Accounts Listing")
                {
                    Caption = 'Accounts Listing';
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = report "Accounts Listing";
                }
                action("New Accounts")
                {
                    Caption = 'New Accounts';
                    Image = NewChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = report "New Accounts Report";
                }
                action("Dormant Accounts")
                {
                    Caption = 'Dormant Accounts';
                    Image = StopPayment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = report "Dormant Accounts Report";
                }
                action("Page Vendor Statistics")
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    Visible = false;
                }
                action("Members Statistics")
                {
                    Caption = 'Member Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                separator(Action12)
                {
                }
                action("Send Member Statement")
                {
                    Caption = 'Send Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(172073, true, false, Cust);
                    end;
                }
                action("Send Account Statement")
                {
                    Caption = 'Send Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            //Report.run(172890,TRUE,FALSE,Vend);
                            Report.run(172072, true, false, Vend);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles;
        vendLedger.Reset();
        vendLedger.SetRange("Posting Date", Rec."Last Account Trans");
        vendLedger.SetRange("Vendor No.", Rec."No.");
        if vendLedger.FindLast() then begin
            vendLedger.CalcFields(Amount);
            Rec."Transaction Amount" := vendLedger.Amount * -1;
            Rec."Last Transaction" := vendLedger.Description;
            Rec.Modify();
        end;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Global Dimension 1 Code",'FOSA');
    end;

    local procedure ImportMultipleCustomerPicturesFromZip()
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        SelectZIPFileMsg: Label 'Select ZIP File';
        FileCount: Integer;
        Cust: Record Vendor;

        //DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 pictures imported successfully.';
    begin
        //Upload zip file
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        //Extract zip file and store files to list type
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;

        //Loop files from the list type
        foreach EntryListKey in EntryList do begin
            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            //Import each file where you want
            //if not Cust.Find('=') then
            //  Error(NoCustError, FileName);
            Cust.SETRANGE(Cust."ID No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust.Image);
                Cust.Image.ImportStream(EntryInStream, FileName);
                Cust.Modify(true);
                FileCount += 1;
            END;

        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;

    local procedure ImportMultipleCustomerSignaturesFromZip()
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        SelectZIPFileMsg: Label 'Select ZIP File';
        FileCount: Integer;
        Cust: Record Vendor;

        //DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 signatures imported successfully.';
    begin
        //Upload zip file
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        //Extract zip file and store files to list type
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;

        //Loop files from the list type
        foreach EntryListKey in EntryList do begin
            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            //Import each file where you want
            //if not Cust.Find('=') then
            //  Error(NoCustError, FileName);
            Cust.SETRANGE(Cust."ID No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust.Signature);
                Cust.Signature.ImportStream(EntryInStream, FileName);
                Cust.Modify(true);
                FileCount += 1;
            END;

        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;

    var
        Cust: Record "Members Register";
        Vend: Record Vendor;
        CoveragePercentStyle: Text;
        MinimumBalance: Decimal;
        ObjAccount: Record Vendor;
        vendLedger: Record "Vendor Ledger Entry";

    local procedure SetStyles()
    begin
        MinimumBalance := 1000;
        if Rec.Balance = 0 then
            CoveragePercentStyle := 'Strong'
        else
            if Rec.Balance < MinimumBalance then
                CoveragePercentStyle := 'Unfavorable'
            else
                CoveragePercentStyle := 'Favorable';
    end;
}






