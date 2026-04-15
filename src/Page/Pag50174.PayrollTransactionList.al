//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50174 "Payroll Transaction List."
{
    ApplicationArea = All;
    CardPageID = "payroll Transaction Code.";
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payroll Transaction Code.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                }
                field("Is Formulae";Rec."Is Formulae")
                {
                }
                field(Formulae; Rec.Formulae)
                {
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    Editable = true;
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("G/L Account";Rec."G/L Account")
                {
                    Caption = 'Debit Account';
                }
                field("G/L Account Name";Rec."G/L Account Name")
                {
                    Caption = 'Debit Account Name';
                }
                field("Credit Account";Rec."Credit Account")
                {
                    Caption = 'Credit Account';
                }
                field("Credit Account Name";Rec."Credit Account Name")
                {
                }
                field("IsCo-Op/LnRep";Rec."IsCo-Op/LnRep")
                {
                    Caption = 'Is Sacco Deduction';
                }
                field("Loan Product";Rec."Loan Product")
                {
                }
                field("Loan Product Name";Rec."Loan Product Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}






