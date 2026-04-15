//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50882 "Cheque B. Applications SubPage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Book Ordered"; Rec."Cheque Book Ordered")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Ordered On"; Rec."Ordered On")
                {
                }
                field("Received On"; Rec."Received On")
                {
                }
                field(Destroyed; Rec.Destroyed)
                {
                }
                field(Collected; Rec.Collected)
                {
                }
            }
        }
    }

    actions
    {
    }
}






