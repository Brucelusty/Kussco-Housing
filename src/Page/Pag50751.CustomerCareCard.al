//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50751 "Customer Care Card"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = "Members Register";

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = true;
                }
                field("FOSA Account No."; Rec."FOSA Account No.")
                {

                    trigger OnValidate()
                    begin

                        FosaName := '';

                        if Rec."FOSA Account No." <> '' then begin
                            if Vend.Get(Rec."FOSA Account No.") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }
                field(FosaName; FosaName)
                {
                    Caption = 'FOSA Account Name';
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'ID Number';
                    Editable = true;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    Editable = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Caption = 'Post Code';
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    Caption = 'Town';
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Home Address';
                }
                field("Home Postal Code"; Rec."Home Postal Code")
                {
                }
                field("Home Town"; Rec."Home Town")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Mobile No.';
                    Editable = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Caption = 'Employer';
                    Editable = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = false;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Recruited By"; Rec."Recruited By")
                {
                }
                field(Picture; Rec.Picture)
                {
                }
                field(Signature; Rec.Signature)
                {
                }
            }
            group("Savings Details")
            {
                Caption = 'Savings Details';
                field("Current Shares"; Rec."Current Shares")
                {
                    Caption = 'Deposits';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    Caption = 'Share Capital';
                }
                field("Insurance Fund"; Rec."Insurance Fund")
                {
                    Caption = 'Benevolent Fund';
                }
                field("FOSA  Account Bal"; Rec."FOSA  Account Bal")
                {
                    Editable = false;
                }
            }
            part(Control1000000013; "Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "BOSA No" = field("No.");
            }
            group("Loan Eligibility")
            {
                Caption = 'Loan Eligibility';
                field("Current Shares1"; Rec."Current Shares")
                {
                    Caption = 'Member Deposit';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                }
                field("Member Deposit Mult 3"; Rec."Member Deposit Mult 3")
                {
                }
                field("New loan Eligibility"; Rec."New loan Eligibility")
                {
                }
            }
            // part(Control1000000007;"Member Accounts List")
            // {
            //     Caption = 'Savings Product Details';
            //     SubPageLink = "BOSA Account No"=field("No.");
            // }
            group("Withdrawal Details")
            {
                Caption = 'Withdrawal Details';
                Editable = true;
                field("Withdrawal Application Date"; Rec."Withdrawal Application Date")
                {
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                }
                field("Status - Withdrawal App."; Rec."Status - Withdrawal App.")
                {
                }
                field("Active Loans Guarantor"; Rec."Active Loans Guarantor")
                {
                }
                field("Loans Guaranteed"; Rec."Loans Guaranteed")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                }
                action("Bank Account")
                {
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                }
                action(Contacts)
                {
                    Image = ContactPerson;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
            }
            group(ActionGroup1000000056)
            {
                action("Members Kin Details List")
                {
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Next of Kin List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    Caption = 'Signatories Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member card")
                {
                    Image = Account;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.FindFirst then begin
                            //      Report.Run(Report::Report51516279,true,false,Cust);
                        end;
                    end;
                }
                action("Members Statistics")
                {
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    Caption = 'Member is  a Guarantor';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172503, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172504, true, false, Cust);
                        //51516482
                    end;
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action("Detailed Statement")
                {
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172360, true, false, Cust);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Account Closure Slip")
                {
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172474, true, false, Cust);
                    end;
                }
                action("FOSA Statement")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    //RunObject = Report "FOSA Account Statement";

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."BOSA Account No", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172476, true, false, Vend);


                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        Report.run(172476,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("FOSA Loans Statement")
                {
                    Image = Report2;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172533, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    Image = report2;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172531, true, false, Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;
    end;

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record "Members Register";
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        UserSetup: Record "User Setup";
}






