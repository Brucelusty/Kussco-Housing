//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50118 "BOSA Receipts List"
{
    ApplicationArea = All;
    CardPageID = "BOSA Receipt Card";
    Editable = false;
    PageType = List;
    Caption='Member Receipts List';
    UsageCategory = Lists;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(false), Source = filter(BOSA));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No."; Rec."Transaction No.")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field(Name; rec.Name)
                {
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                }
                field("Employer No."; Rec."Employer No.")
                {
                    Caption = 'Receipting Bank';
                }
                field(Amount; rec.Amount)
                {
                }
                field(Posted; rec.Posted)
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ObjUserSetup.Reset;
        ObjUserSetup.SetRange("User ID", UserId);
        if ObjUserSetup.Find('-') then begin
            if ObjUserSetup."Approval Administrator" <> true then
                rec.SetRange(rec."User ID", UserId);
        end;
    end;

    var
        ObjUserSetup: Record "User Setup";
}






