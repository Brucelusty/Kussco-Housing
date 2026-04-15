#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50100 "Guarantorship Sub List"
{
    ApplicationArea = All;
    CardPageID = "Guarantor Sub Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Guarantorship Substitution H";
    SourceTableView = where(Substituted = filter(false));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Loanee Member No"; Rec."Loanee Member No")
                {
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                }
                field("Loan Guaranteed"; Rec."Loan Guaranteed")
                {
                }
                field("Substituting Member"; Rec."Substituting Member")
                {
                }
                field("Substituting Member Name"; Rec."Substituting Member Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Substituted By"; Rec."Substituted By")
                {
                }
                field("Date Substituted"; Rec."Date Substituted")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Substituted; Rec.Substituted)
                {
                }
            }
        }
    }

    actions
    {
    }
}



