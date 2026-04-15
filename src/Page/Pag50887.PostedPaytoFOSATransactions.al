page 50887 "Posted PaytoFOSA Transactions"
{
    ApplicationArea = All;
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Lists;
    SourceTable ="Paybill Transactions";
    SourceTableView = where(Status = filter(Posted), MSIDN = filter('0124A062563600'));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Paybill)
            {
                field(TransID;Rec.TransID)
                {
                    Editable=false;
                    
                }
                field(TransactionType;Rec.TransactionType)
                {
                    Editable=false;
                    
                }
                field(TransTime;Rec.TransTime)
                {
                    Editable=false;
                    
                }
                field("Posted Date";Rec."Posted Date")
                {
                    Editable=false;
                }
                field("Posted Time";Rec."Posted Time")
                {
                    Editable=false;
                }
                field(TransAmount;Rec.TransAmount)
                {
                    Editable=false;
                    
                }
                field(BusinessShortCode;Rec.BusinessShortCode)
                {
                    Editable=false;
                    
                }
                field(BillRefNumber;Rec.BillRefNumber)
                {
                    
                }

                field(InvoiceNumber;Rec.InvoiceNumber)
                {
                    Editable=false;
                }
                field(OrgAccountBalance;Rec.OrgAccountBalance)
                {
                    Editable=false;
                    
                }
                field(ThirdPartyTransID;Rec.ThirdPartyTransID)
                {
                    Editable=false;
                    
                }
                field(MSIDN;Rec.MSIDN)
                {
                    Editable=false;
                    
                }
                field(Status;Rec.Status)
                {
                    // Editable=false;
                    
                }
                field(FirstName;Rec.FirstName)
                {
                    Editable=false;
                    
                }
                field(TransType;Rec.TransType)
                {
                    Editable=false;
                    
                }
                field(IDNo;Rec.IDNo)
                {
                    // Editable=false;
                    
                }
                field("Posting Location";Rec."Posting Location")
                {
                    // Editable=false;
                    
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        postedDate: Date;
        postedTime: Time;
    begin

        postedDate := DT2Date(Rec.TransTime);
        postedTime := DT2Time(Rec.TransTime);
        Rec."Posted Date" := postedDate;
        Rec."Posted Time" := postedTime;
    end;
}


