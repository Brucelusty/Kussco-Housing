//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50730 "FOSA Statistics FactBox"
{
    ApplicationArea = All;
    Caption = 'Account Statistics FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Vendor;

    layout
    {
        area(content)

        {

            field("No."; Rec."No.")
            {
                Caption = 'Account No.';
            }
            field(Name; Rec.Name)
            {
                Caption = 'Account Name';
            }
            field("ID No."; Rec."ID No.")
            {
            }
            field("Mobile Phone No"; Rec."Mobile Phone No")
            {
            }
            group("Balance Statistics")
            {
                Caption = 'Balance Statistics';
                //Visible=false;
                field("Balance (LCY)"; (Rec."Balance (LCY)"))
                {
                    Caption = 'Book Balance';
                    StyleExpr = FieldStyle;
                }

                field("Available Balance"; Rec.GetAvailableBalance())
                {
                    Caption = 'Available Balance';
                    StyleExpr = FieldStyle;
                    Visible = false;
                }
                field(MinBalance; MinBalance)
                {
                    Visible = false;
                    Caption = 'Min Balance';
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        transPage: Page "Posted Cashier Transactions";
                    begin
                        trans.Reset();
                        trans.SetRange("Account No", Rec."No.");
                        trans.SetRange(Posted, true);
                        trans.SetRange("Cheque Processed", false);
                        trans.SetRange("Type _Transactions", trans."Type _Transactions"::"Cheque Deposit");
                        if trans.FindSet() then begin
                            transPage.SetTableView(trans);
                            transPage.RunModal();
                        end;
                    end;
                }
                field("Cheque Discounted"; Rec."Cheque Discounted")
                {
                    Caption = 'Discounted Cheques';
                    Visible = false;
                }
                field("Frozen Amount"; Rec."Amount to freeze")
                {
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        frozenPage: Page "Member Account Freeze Subpage";
                    begin
                        froze.Reset();
                        froze.SetRange("Account No", Rec."No.");
                        froze.SetRange(Frozen, true);
                        if froze.FindSet() then begin
                            frozenPage.SetTableView(froze);
                            frozenPage.RunModal();
                        end;
                    end;
                }
                // field("Balance (LCY)"; decimal)
                // {
                //     Caption = 'Withdrawable Balance';
                //     Style = StrongAccent;
                //     StyleExpr = FieldStyle;
                // }
                field("Pending MPesa Withdrawals"; Rec."Pending MPesa Withdrawals")
                {
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        mpesaPage: Page "MPESA Withdrawal Buffer";
                    begin
                        mpesa.Reset();
                        mpesa.SetRange("Vendor No", Rec."No.");
                        mpesa.SetRange(Posted, false);
                        mpesa.SetRange(Reversed, false);
                        if mpesa.FindSet() then begin
                            mpesaPage.SetTableView(mpesa);
                            mpesaPage.RunModal();
                        end;
                    end;
                }
                field("EFT Transactions"; Rec."EFT Transactions")
                {
                    Caption = 'Pending EFT/RTGS Transactions';
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        eftPage: Page "EFT/RTGS Details";
                    begin
                        efts.Reset();
                        efts.SetRange("Account No", Rec."No.");
                        efts.SetRange(Transferred, false);
                        if efts.FindSet() then begin
                            eftPage.SetTableView(efts);
                            eftPage.RunModal();
                        end;
                    end;
                }
                field("ATM Transactions"; Rec."ATM Transactions")
                {
                    Caption = 'Pending ATM Transactions';
                    Visible = false;

                    // trigger OnDrillDown()
                    // var
                    // frozenPage: Page 172358;
                    // begin
                    //     atm.Reset();
                    //     atm.SetRange("Account No", Rec."No.");
                    //     atm.SetRange(Posted, false);
                    //     if atm.FindSet() then begin
                    //         frozenPage.SetTableView(atm);
                    //         frozenPage.RunModal();
                    //     end;
                    // end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ChangeCustomer;
        GetLatestPayment;
        CalculateAging;

        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;
        SetFieldStyle;

        MinBalance := 0;
        if AccountType.Get(Rec."Account Type") then
            MinBalance := AccountType."Minimum Balance";
    end;

    trigger OnOpenPage()
    begin
        // Default the Aging Period to 30D
        Evaluate(AgingPeriod, '<30D>');
        // Initialize Record Variables
        LatestCustLedgerEntry.Reset;
        LatestCustLedgerEntry.SetCurrentkey("Document Type", "Customer No.", "Posting Date");
        LatestCustLedgerEntry.SetRange("Document Type", LatestCustLedgerEntry."document type"::Payment);
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            CustLedgerEntry[I].Reset;
            CustLedgerEntry[I].SetCurrentkey("Customer No.", Open, Positive, "Due Date");
            CustLedgerEntry[I].SetRange(Open, true);
        end;
    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';
        MinBalance: Decimal;
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        AccountType: Record "Account Types-Saving Products";
        trans: Record Transactions;
        froze: Record "Member Account Freeze Details";
        mpesa: Record "Mpesa Withdawal Buffer";
        efts: Record "EFT/RTGS Details";
        atm: Record "ATM Log Entries3";
        FieldStyleL: Text;


    procedure CalculateAgingForPeriod(PeriodBeginDate: Date; PeriodEndDate: Date; Index: Integer)
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        NumDaysToBegin: Integer;
        NumDaysToEnd: Integer;
    begin
        // Calculate the Aged Balance for a particular Date Range
        if PeriodEndDate = 0D then
            CustLedgerEntry[Index].SetFilter("Due Date", '%1..', PeriodBeginDate)
        else
            CustLedgerEntry[Index].SetRange("Due Date", PeriodBeginDate, PeriodEndDate);

        CustLedgerEntry2.Copy(CustLedgerEntry[Index]);
        CustLedgerEntry[Index]."Remaining Amt. (LCY)" := 0;
        if CustLedgerEntry2.Find('-') then
            repeat
                CustLedgerEntry2.CalcFields("Remaining Amt. (LCY)");
                CustLedgerEntry[Index]."Remaining Amt. (LCY)" :=
                  CustLedgerEntry[Index]."Remaining Amt. (LCY)" + CustLedgerEntry2."Remaining Amt. (LCY)";
            until CustLedgerEntry2.Next = 0;

        if PeriodBeginDate <> 0D then
            NumDaysToBegin := WorkDate - PeriodBeginDate;
        if PeriodEndDate <> 0D then
            NumDaysToEnd := WorkDate - PeriodEndDate;
        if PeriodEndDate = 0D then
            AgingTitle[Index] := Text002
        else
            if PeriodBeginDate = 0D then
                AgingTitle[Index] := StrSubstNo(Text003, NumDaysToEnd - 1)
            else
                AgingTitle[Index] := StrSubstNo(Text004, NumDaysToEnd, NumDaysToBegin);
    end;


    procedure CalculateAging()
    begin
        // Calculate the Entire Aging (four Periods)
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            case I of
                1:
                    begin
                        PeriodEnd := 0D;
                        PeriodStart := WorkDate;
                    end;
                ArrayLen(CustLedgerEntry):
                    begin
                        PeriodEnd := PeriodStart - 1;
                        PeriodStart := 0D;
                    end;
                else begin
                    PeriodEnd := PeriodStart - 1;
                    PeriodStart := CalcDate('-' + Format(AgingPeriod), PeriodStart);
                end;
            end;
            CalculateAgingForPeriod(PeriodStart, PeriodEnd, I);
        end;
    end;


    procedure GetLatestPayment()
    begin
        // Find the Latest Payment
        if LatestCustLedgerEntry.FindLast then
            LatestCustLedgerEntry.CalcFields("Amount (LCY)")
        else
            LatestCustLedgerEntry.Init;
    end;


    procedure ChangeCustomer()
    begin
        // Change the Customer Filters
        LatestCustLedgerEntry.SetRange("Customer No.", Rec."No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do
            CustLedgerEntry[I].SetRange("Customer No.", Rec."No.");
    end;


    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Balance (LCY)");
        if Rec."Balance (LCY)" < 0 then
            FieldStyle := 'Attention';

        FieldStyleL := '';
        if Rec."Account Special Instructions" <> '' then
            FieldStyleL := 'Attention';
    end;
}






