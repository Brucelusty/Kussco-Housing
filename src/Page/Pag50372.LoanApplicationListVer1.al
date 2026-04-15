//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50372 "Loan Application List Ver1"
{
    ApplicationArea = All;
    // CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            "Approval Status" = filter(Open));

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
                field("Requested Amount";Rec."Requested Amount")
                {
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                }
                field(Interest; Rec.Interest)
                {
                }
                field("Client Name";Rec."Client Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}






