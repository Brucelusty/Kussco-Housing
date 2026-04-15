report 50735 "Mdosi Jr DoBs"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = where("Account Type" = filter('109'));
            RequestFilterFields = "No.";
            column(No_;"No.")
            {}
            trigger OnAfterGetRecord() begin
                if childDoB >= Today then Error('The inputted date of birth cannot be in the future.');

                if vend.Get(Vendor."No.") then begin
                    if vend."Account Type" <> '109' then Error('The inputted account %1 is not a Mdosi Junior account.', Vendor."No.");
                end;

                vend.Reset();
                vend.SetRange("No.", Vendor."No.");
                if vend.Find('-') then begin
                    vend."Child DOB" := childDoB;
                    vend.Modify;
                end;
            end;
        }
    }
    
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Child Date of Birth"; childDoB)
                    {
                    ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    

    }
    
    var
    myInt: Integer;
    vend: Record Vendor;
    childDoB: Date;
}



