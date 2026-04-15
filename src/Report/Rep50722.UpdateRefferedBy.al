report 50722 "Update Reffered By"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.";
            column(No_;"No.")
            {}
            trigger OnAfterGetRecord() begin
                cust.Reset();
                cust.SetRange("No.", Customer."No.");
                if cust.Find('-') then begin
                    if (cust."Reffered By Member No" = '') or (cust."Reffered By Member Name" = '') then
                    begin
                        membApp.Reset();
                        membApp.SetRange("ID No.", Customer."ID No.");
                        if membApp.Find('-') then begin
                            if membApp."Referee ID No" <> '' then begin
                                custom.Reset();
                                custom.SetRange("ID No.", membApp."Referee ID No");
                                if custom.Find('-') then begin
                                    cust."Reffered By Member No" := custom."No.";
                                    cust."Reffered By Member Name" := custom.Name;
                                    cust.modify;

                                    vend.Reset();
                                    vend.SetRange("BOSA Account No", cust."No.");
                                    if vend.Find('-') then begin
                                        vend."Reffered By Member No" := custom."No.";
                                        vend."Reffered By Member No" := custom.Name;
                                        vend.modify;
                                    end;
                                end;
                            end else if membApp."Reffered By Member No" <> '' then begin
                                cust."Reffered By Member No" := membApp."Reffered By Member No";
                                cust."Reffered By Member Name" := membApp."Reffered By Member Name";
                                cust.modify;

                                vend.Reset();
                                vend.SetRange("BOSA Account No", cust."No.");
                                if vend.Find('-') then begin
                                    vend."Reffered By Member No" := membApp."Reffered By Member No";
                                    vend."Reffered By Member Name" := membApp."Reffered By Member Name";
                                    vend.modify;
                                end;
                            end;
                        end;
                    end;  
                end;
            end;
        }
    }
    
    var
    myInt: Integer;
    cust: Record Customer;
    custom: Record Customer;
    vend: Record Vendor;
    membApp: Record "Membership Applications";
}
