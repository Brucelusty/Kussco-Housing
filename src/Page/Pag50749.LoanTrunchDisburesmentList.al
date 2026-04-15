//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50749 "Loan Trunch Disburesment List"
{
    ApplicationArea = All;
    CardPageID = "Loan Trunch Disburesment";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan trunch Disburesment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Loan No";Rec."Loan No")
                {
                }
                field("Issue Date";Rec."Issue Date")
                {
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                }
                field("Disbursed Amount";Rec."Disbursed Amount")
                {
                }
                field("Balance Outstanding";Rec."Balance Outstanding")
                {
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                }
                field("Amount to Disburse";Rec."Amount to Disburse")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID";Rec."User ID")
                {
                }
                field("FOSA Account";Rec."FOSA Account")
                {
                }
                field("Mode of Disbursement";Rec."Mode of Disbursement")
                {
                }
                field("Cheque No/Reference No";Rec."Cheque No/Reference No")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posting Date";Rec."Posting Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}






