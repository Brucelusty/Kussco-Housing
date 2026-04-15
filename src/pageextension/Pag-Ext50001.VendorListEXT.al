pageextension 50001 "Vendor List EXT" extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("VendorPostingGroup";Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Rec.SetFilter("Account Type", '<>%1&<>%2&<>%3', '101', '102', '103');
    end;

}
