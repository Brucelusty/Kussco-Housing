//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50877 "Product Deposit>Loan Analysis"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Product Deposit>Loan Analysis";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code";Rec."Product Code")
                {
                    Editable = loanSetupEditor;
                }
                field("Deposit Multiplier";Rec."Deposit Multiplier")
                {
                    Editable = loanSetupEditor;
                }
                field("Minimum Deposit";Rec."Minimum Deposit")
                {
                    Editable = loanSetupEditor;
                }
                field("Minimum Share Capital";Rec."Minimum Share Capital")
                {
                    Editable = loanSetupEditor;
                }
                field("Minimum No of Membership Month";Rec."Minimum No of Membership Month")
                {
                    Editable = loanSetupEditor;
                }
            }
        }
    }

    actions
    {
    }
    var
    loanSetupEditor: Boolean;
    user: Record "User Setup";
    trigger
    OnOpenPage()
    begin
        user.Reset();
        user.SetRange("User ID", UserId);
        if user.Find('-') then
        begin
            if user."Loan Product Setup" = true
            then
            begin
                loanSetupEditor:= true;
            end;
        end;
    end;
}






