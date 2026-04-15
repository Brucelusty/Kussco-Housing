//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50645 "Loans Rejected List"
{
    ApplicationArea = All;
    CardPageID = "Loans Rejected Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loans Register";
    SourceTableView = where("Approval Status" = const(Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Caption = 'Loan Product';
                }
                field("Client Code";Rec."Client Code")
                {
                    Caption = 'Member No';
                }
                field("Client Name";Rec."Client Name")
                {
                    Caption = 'Member Name';
                }
                field("Application Date";Rec."Application Date")
                {
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                }
                field(Interest; Rec.Interest)
                {
                }
                field(Insurance; Rec.Insurance)
                {
                }
                field("Source of Funds";Rec."Source of Funds")
                {
                }
                field("Client Cycle";Rec."Client Cycle")
                {
                }
                field("Loan Status";Rec."Loan Status")
                {
                }
                field("Issued Date";Rec."Issued Date")
                {
                }
                field(Installments; Rec.Installments)
                {
                }
                field("Rejected By";Rec."Rejected By")
                {
                }
                field("Rejection  Remark";Rec."Rejection  Remark")
                {
                }
            }
        }
    }

    actions
    {
    }
}






