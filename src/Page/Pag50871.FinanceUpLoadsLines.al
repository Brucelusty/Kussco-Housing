//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50871 "Finance UpLoads Lines"
{
    ApplicationArea = All;
    DelayedInsert = false;
    PageType = ListPart;
    SourceTable = "Finance Uploads Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Debit Account Type";Rec."Debit Account Type")
                {
                }
                field("Debit Account No";Rec."Debit Account No")
                {
                    StyleExpr = CoveragePercentStyle;
                }
                field("Debit Narration";Rec."Debit Narration")
                {
                }
                field("Debit Account Balance Status";Rec."Debit Account Balance Status")
                {
                    StyleExpr = CoveragePercentStyle;
                }
                field("Debit Account Status";Rec."Debit Account Status")
                {
                    Editable = false;
                    StyleExpr = CoveragePercentStyleII;
                }
                field("Reference No";Rec."Reference No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Credit Account Type";Rec."Credit Account Type")
                {
                }
                field("Credit Account No";Rec."Credit Account No")
                {
                }
                field("Credit Narration";Rec."Credit Narration")
                {
                }
                field("Credit Account Status";Rec."Credit Account Status")
                {
                    Editable = false;
                    StyleExpr = CoveragePercentStyleIII;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;

    var
        CoveragePercentStyle: Text;
        CoveragePercentStyleII: Text;
        CoveragePercentStyleIII: Text;

    local procedure SetStyles()
    begin
        if Rec."Debit Account Balance Status" = Rec."debit account balance status"::" " then
            CoveragePercentStyle := 'Strong';
        if Rec."Debit Account Balance Status" = Rec."debit account balance status"::"Insufficient Balance" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Debit Account Balance Status" = Rec."debit account balance status"::"Sufficient Balance" then
            CoveragePercentStyle := 'Favorable';

    end;

    local procedure SetStylesII()
    begin
        CoveragePercentStyleII := 'Strong';
        if Rec."Debit Account Status" <> Rec."debit account status"::Active then
            CoveragePercentStyleII := 'Unfavorable';
        if Rec."Debit Account Status" = Rec."debit account status"::Active then
            CoveragePercentStyleII := 'Favorable';

    end;

    local procedure SetStylesIII()
    begin
        CoveragePercentStyleIII := 'Strong';
        if Rec."Credit Account Status" <> Rec."credit account status"::Active then
            CoveragePercentStyleIII := 'Unfavorable';
        if Rec."Credit Account Status" = Rec."credit account status"::Active then
            CoveragePercentStyleIII := 'Favorable';

    end;
}






