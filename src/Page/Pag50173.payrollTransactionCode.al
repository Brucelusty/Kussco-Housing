//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50173 "payroll Transaction Code."
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Payroll Transaction Code.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field("Loan Product"; Rec."Loan Product")
                {
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                }
                label(Control1102756006)
                {
                    CaptionClass = Text19065628;
                }
                group("Select one")
                {
                    Caption = 'Select one';
                    field("Transaction Type"; Rec."Transaction Type")
                    {
                    }
                }
                group(Control1102756039)
                {
                    Caption = 'Select one';
                    field(Frequency; Rec.Frequency)
                    {
                        ValuesAllowed = Fixed, Varied;
                    }
                }
                label(Control1102756010)
                {
                    CaptionClass = Text19046900;
                }
                group(Control1102756044)
                {
                    Caption = 'Select one';
                    field("Balance Type"; Rec."Balance Type")
                    {
                        ValuesAllowed = None, Increasing, Reducing;
                    }
                }
                field("Transaction Type1"; Rec."Transaction Type")
                {
                    Caption = 'Amount Preference';
                    ValuesAllowed = Income;
                }
                group(Control1102756049)
                {
                    Caption = 'Select one';
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                }
                field("Is Cash"; Rec."Is Cash")
                {
                }
                field("Is Pension"; Rec."Is Pension")
                {
                }
                field("is Housing Levy"; Rec."is Housing Levy")
                {
                }

                field("Housing Levy%"; Rec."Housing Levy%")
                {
                }
                field("Is Formulae"; Rec."Is Formulae")
                {
                    Caption = 'Is Formula';
                }
                field(Formulae; Rec.Formulae)
                {
                    Caption = 'Formula';
                }
                label(Control1102756053)
                {
                    CaptionClass = Text19025872;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                }
                field("Formulae for Employer"; Rec."Formulae for Employer")
                {
                    Caption = 'Formula for Employer';
                }
                label(Control1102756054)
                {
                    CaptionClass = Text19080001;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Caption = 'Debit Account';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    Caption = 'Debit Account Name';
                }
                field("Credit Account"; Rec."Credit Account")
                {
                    Caption = 'Credit Account';
                }
                field("Credit Account Name"; Rec."Credit Account Name")
                {
                    Caption = 'Credit Account Name';
                    Editable = false;
                }
                field(SubLedger; Rec.SubLedger)
                {
                    Caption = 'Posting to Subledger';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }
                group(Control1102756055)
                {
                    Caption = 'Select one';
                    field("Special Transaction"; Rec."Special Transaction")
                    {
                    }
                }
                group(Control1102756068)
                {
                    Caption = 'Select one';
                    field("Special Transactions1"; Rec."Special Transaction")
                    {
                        ValuesAllowed = "Life Insurance";
                    }
                    field("Deduct Premium"; Rec."Deduct Premium")
                    {
                    }
                }
                group(Control1102756074)
                {
                    Caption = 'Select one';
                    field("Special Transactions2"; Rec."Special Transaction")
                    {
                        ValuesAllowed = "Staff Loan";
                    }
                    group(Control1102756085)
                    {
                        Caption = 'Select one';
                        field("Repayment Method"; Rec."Repayment Method")
                        {
                            ValuesAllowed = Reducing, "Straight line";
                        }
                    }
                    field("Fringe Benefit"; Rec."Fringe Benefit")
                    {
                    }
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("Repayment Method1"; Rec."Repayment Method")
                {
                    ValuesAllowed = Amortized;
                }
                group("Sacco Deduction Settings")
                {
                    Caption = 'Sacco Deduction Settings';
                    field("Co-Op Parameters"; Rec."Co-Op Parameters")
                    {
                        Caption = 'Sacco Deduction Type';
                    }
                    field("IsCo-Op/LnRep"; Rec."IsCo-Op/LnRep")
                    {
                        Caption = 'Is Sacco Deduction';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //CurrPage.EDITABLE:=FALSE;
    end;

    var
        Text19065628: label 'Transaction Type';
        Text19046900: label 'Balance Type';
        Text19025872: label 'E.g ([005]+[020]*[24])/2268';
        Text19080001: label 'E.g ([005]+[020]*[24])/2268';
        Text19015031: label '%';
}






