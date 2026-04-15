//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50768 "Loans Appeal  List"
{
    ApplicationArea = All;
    //CardPageID = "Loan Appeal Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            "Loan to Appeal" = filter(<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                }
                field("Client Code";Rec."Client Code")
                {
                    Caption = 'Member  No';
                }
                field("Group Code";Rec."Group Code")
                {
                }
                field("Client Name";Rec."Client Name")
                {
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                }
                field("Loan to Appeal";Rec."Loan to Appeal")
                {
                }
                field("Loan to Appeal Approved Amount";Rec."Loan to Appeal Approved Amount")
                {
                }
                field("Loan to Appeal issued Date";Rec."Loan to Appeal issued Date")
                {
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                }
                field("Loan Status";Rec."Loan Status")
                {
                }
                field("Issued Date";Rec."Issued Date")
                {
                }
                field("Expected Date of Completion";Rec."Expected Date of Completion")
                {
                }
                field(Installments; Rec.Installments)
                {
                }
                field(Repayment; Rec.Repayment)
                {
                }
                field("Rejection  Remark";Rec."Rejection  Remark")
                {
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                }
                field("Outstanding Interest";Rec."Outstanding Interest")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
    }
}






