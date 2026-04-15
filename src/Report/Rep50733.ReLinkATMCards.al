report 50733 "Re-Link ATM Cards"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = where("Account Type" = filter('103'));
            RequestFilterFields = "No.";
            column(No_;"No.")
            {}
            trigger OnAfterGetRecord() begin
                if vend.Get(Vendor."No.") then begin
                    if vend."Account Type" <> '103' then Error('The inputted account %1 is not an Ordinary Savings account.');
                end;
                
                vend.Reset();
                vend.SetRange("ATM No.", ATMNo);
                if vend.Find('-') then begin
                    Error('The inputted ATM No. %1 already exists.', ATMNo);
                end;

                vend.Reset();
                vend.SetRange("No.", Vendor."No.");
                if vend.Find('-') then begin
                    vend."ATM No." := ATMNo;
                    vend."Atm card ready" := true;
                    vend."ATM Enabled" := true;
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
                    field("ATM No."; ATMNo)
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
    ATMNo: Code[20];
}



