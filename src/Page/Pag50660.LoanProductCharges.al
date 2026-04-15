//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50660 "Loan Product Charges"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loan Product Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    Editable = loanSetupEditor;
                }
                field("Code"; Rec.Code)
                {
                    Editable = loanSetupEditor;
                }
                field(Description; Rec.Description)
                {
                    Editable = loanSetupEditor;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = loanSetupEditor;
                }
                field(Percentage; Rec.Percentage)
                {
                    Editable = loanSetupEditor;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Editable = loanSetupEditor;
                }
                field("Use Perc"; Rec."Use Perc")
                {
                    Editable = loanSetupEditor;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    Editable = loanSetupEditor;
                }
                field("Deduction Type"; Rec."Deduction Type")
                {
                    Editable = loanSetupEditor;
                }
                field("Loan Charge Type"; Rec."Loan Charge Type")
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






