//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50260 "Loans  List All"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loans Register";
    SourceTableView = where("Loan Status" = filter(Disbursed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Client Code";Rec."Client Code")
                {
                    Caption = 'Member  No';
                    Editable = false;
                }
                field("Client Name";Rec."Client Name")
                {
                    Editable = false;
                }
                field("Staff No";Rec."Staff No")
                {
                    Caption = 'Payroll No.';
                }
                field("ID NO";Rec."ID NO")
                {
                }
                field("Account No";Rec."Account No")
                {
                    Caption = 'FOSA Account No.';
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Loan Status";Rec."Loan Status")
                {
                    Editable = false;
                }
                field("Issued Date";Rec."Issued Date")
                {
                    Editable = false;
                }
                field("Expected Date of Completion";Rec."Expected Date of Completion")
                {
                    Editable = false;
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Outstanding Interest";Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field(Deductible; Rec.Deductible)
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001;"Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
    }
}






