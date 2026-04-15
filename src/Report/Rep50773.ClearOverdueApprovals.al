report 50773 "Clear Overdue Approvals"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    
    dataset
    {
        dataitem("Approval Entry";"Approval Entry")
        {
            RequestFilterFields = "Table ID", "Document No.";
            column(Table_ID;"Table ID")
            {}
            column(Document_No_;"Document No.")
            {}
            trigger OnAfterGetRecord() begin
                approvalEntry.Reset();
                approvalEntry.SetRange("Table ID", "Approval Entry"."Table ID");
                approvalEntry.SetRange("Document No.", "Approval Entry"."Document No.");
                if approvalEntry.Find('-') then begin
                    repeat
                        if (approvalEntry."Due Date" > refDate) then begin
                            approvalEntry.Delete;
                        end;
                    until approvalEntry.Next()= 0;
                end;
            end;

        }
    }

    trigger OnInitReport() begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture, "CEO Signature");
        refDate := CalcDate('<-1W>', Today);
    end;
    
    var
        myInt: Integer;
        refDate: Date;
        approvalEntry: Record "Approval Entry";
        companyInfo: Record "Company Information";
}
