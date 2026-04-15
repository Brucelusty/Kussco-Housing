//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50106 "Members List"
{
    ApplicationArea = All;
    Caption = 'Member List';
    CardPageID = "Member Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Customer;
SourceTableView =
    sorting("No.") 
    where(
        ISNormalMember = const(true),
        "Account Category" = filter(<> 'Corporate'),
        "Employer Code" = filter(<> 'STAFF')
    );



    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                }
                field("FOSA Account No."; Rec."FOSA Account No.")
                {
                    Visible = false;
                }
                field("Old Ordinary Account NAV2016"; Rec."Old Ordinary Account NAV2016")
                {
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Visible = false;
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    Visible = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                }
                // field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                // {
                //     Caption = 'E-Mail';
                // }
                field(Status; Rec.Status)
                {
                }
                field("Membership Status"; Rec."Membership Status")
                {
                }
                field("Recruited Members"; Rec."Recruited Members")
                {
                    Style = StrongAccent;
                    Visible = false;
                }
                field("Total Interest Income"; Rec."Total Interest Income")
                {
                    Style = Subordinate;
                    Visible = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    Style = Strong;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    Caption = 'Member Deposits';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    Caption = 'Share Capital';
                }
                field("Ordinary Savings"; Rec."Ordinary Savings")
                {
                    Visible = false;
                }

            }
        }
        area(factboxes)
        {
            part(Control14; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';//
                SubPageLink = "No." = field("No.");
            }
            part(Control13; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
                //    Visible=false;
            }
            part(Control12; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
                //  Visible=false;
            }
            part(Control555; "Member FrontID-Uploaded")
            {
                Caption = 'Front ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control556; "Member BackID-Uploaded")
            {
                Caption = 'Back ID';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Process)
            {
                action(Dimensions)
                {
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                action("Member Accounts")
                {
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("No.");
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
                action("Import MembersM")
                {
                    Caption = 'Import Members';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    RunObject = xmlport "Import MembersM";
                    // ToolTip = 'Import Multiple Customer Pictures';


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
                action(ImportMultipleCustomerFRONTID)
                {
                    Caption = 'Import Multiple Customer Front ID';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Multiple Customer Front ID';

                    trigger OnAction()
                    begin
                        ImportMultipleCustomerFrontIDFromZip();
                    end;
                }
                action(ImportMultipleCustomerBACKID)
                {
                    Caption = 'Import Multiple Customer Back ID';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Multiple Customer Back ID';

                    trigger OnAction()
                    begin
                        ImportMultipleCustomerBackIDFromZip();
                    end;
                }
                action("CRB Query Charge")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("No.");
                    Visible = false;
                }
            }
            group("Issued Documents")
            {
                Caption = 'Issued Documents';
                Visible = false;
                action("Loans Guaranteed")
                {
                    Caption = 'Loans Guarantors';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.", Rec."No.");
                        IF Cust.FIND('-') THEN
                            //REPORT.RUN(,TRUE,FALSE,Cust);

                            Message('home');
                    end;
                }
                action("Loans Guarantors")
                {
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", Rec."No.");
                        if LGurantors.Find('-') then begin
                            Report.Run(172504, true, false, Cust);
                        end;

                    end;
                }
            }
            group(ActionGroup1102755013)
            {
                action("Members Kin Details List")
                {
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Next of Kin List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");

                    trigger OnAction()
                    begin
                        //SFactory."FnRunGetMembersLoanDue&ArrearsAmount"("No.");
                    end;
                }
                action("Members Guaranteed")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loans Guarantee Details";
                    RunPageLink = Name = field(Name);
                    RunPageMode = View;

                    trigger OnAction()
                    begin
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", Rec."No.");
                        if LGurantors.Find('-') then begin
                            Report.Run(172504, true, false, Cust);
                        end;
                    end;
                }
                separator(Action1102755008)
                {
                }
            }
            group(ActionGroup1102755007)
            {
                action("Member Statement")
                {
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(50049, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80027, true, false, Cust);

                    end;
                }
                action("Account Closure Slip")
                {
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(80008, true, false, Cust);
                    end;
                }
                action("Group Statement")
                {
                    Caption = 'House Group Statement  Internal';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.run(172920, true, false, ObjCellGroups);
                    end;
                }
                action(HouseGroupStatement)
                {
                    Caption = 'House Group Statement';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.run(172946, true, false, ObjCellGroups);
                    end;
                }
                action("Send Member Statement")
                {
                    Caption = 'Send Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172073, true, false, Cust);
                    end;
                }
            }
        }
    }

    //validating membership status
    trigger OnAfterGetRecord()
    Var
        Vend: Record Vendor;
    begin
        // Vend.Reset();
        // Vend.SetRange(Vend."BOSA Account No", Rec."No.");
        // if Vend.Find('-') then begin
        //     // Rec."Membership Status" := Vend."Membership Status";
        // end;

        //MemberLiability:=SFactory.FnGetMemberLiability("No.");
    end;

    var
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        UserSetup: Record "User Setup";
        MemberLiability: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjCellGroups: Record "Member House Groups";

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
        Cust: Record Customer;

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
            Cust.SETRANGE(Cust."No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust.Piccture);
                Cust.Piccture.ImportStream(EntryInStream, FileName);
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
        Cust: Record Customer;

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
            Cust.SETRANGE(Cust."No.", FileName);
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

    local procedure ImportMultipleCustomerFrontIDFromZip()
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
        Cust: Record Customer;

        //DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 Front ID imported successfully.';
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
            Cust.SETRANGE(Cust."No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust."ID Front");
                Cust."ID Front".ImportStream(EntryInStream, FileName);
                Cust.Modify(true);
                FileCount += 1;
            END;

        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;



    local procedure ImportMultipleCustomerBackIDFromZip()
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
        Cust: Record Customer;

        //DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 Back ID imported successfully.';
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
            Cust.SETRANGE(Cust."No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust."ID Back");
                Cust."ID Back".ImportStream(EntryInStream, FileName);
                Cust.Modify(true);
                FileCount += 1;
            END;

        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;



    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        /*CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
          Cust.FIND('-');
          WHILE CustCount > 0 DO BEGIN
            CustCount := CustCount - 1;
            Cust.MARKEDONLY(FALSE);
            FirstCust := Cust."No.";
            LastCust := FirstCust;
            More := (CustCount > 0);
            WHILE More DO
              IF Cust.NEXT = 0 THEN
                More := FALSE
              ELSE
                IF NOT Cust.MARK THEN
                  More := FALSE
                ELSE BEGIN
                  LastCust := Cust."No.";
                  CustCount := CustCount - 1;
                  IF CustCount = 0 THEN
                    More := FALSE;
                END;
            IF SelectionFilter <> '' THEN
              SelectionFilter := SelectionFilter + '|';
            IF FirstCust = LastCust THEN
              SelectionFilter := SelectionFilter + FirstCust
            ELSE
              SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
            IF CustCount > 0 THEN BEGIN
              Cust.MARKEDONLY(TRUE);
              Cust.NEXT;
            END;
          END;
        END;
        EXIT(SelectionFilter);
        */

    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        //CurrPage.SETSELECTIONFILTER(Cust);
    end;
}






