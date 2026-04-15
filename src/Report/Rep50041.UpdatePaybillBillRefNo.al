report 50041 "Update Paybill Bill Ref No"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Paybill Transactions"; "Paybill Transactions")
        {
            RequestFilterFields = TransID;
            DataItemTableView = where(Status = filter(Pending));

            column(TransID; TransID)
            { }

            trigger OnPreDataItem()
            begin
                if newReffNo = '' then Error('Ensure the new reference number has a value.');
            end;

            trigger OnAfterGetRecord()
            begin
                "Paybill Transactions".BillRefNumber := newReffNo;
                "Paybill Transactions".Modify;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(newReffNo; newReffNo)
                    {
                        ShowMandatory = true;
                        Caption = 'New Reference No';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        myInt: Integer;
        newReffNo: Code[20];
}


