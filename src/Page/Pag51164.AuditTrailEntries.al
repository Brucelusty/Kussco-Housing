page 51204 "Audit Trail Entries"
{
    ApplicationArea = All;
    PageType = list;
    UsageCategory = Administration;
    SourceTable = "Audit Trail";
    
    layout
    {
        area(Content)
        {
            repeater(AuditTrailList)
            {
                field(EntryNo;Rec.EntryNo)
                {
                    
                }
                field("User Id";Rec."User Id")
                {
                }
                 field(UserName;Rec.UserName)
                {
                }
                 field("Transaction Type";Rec."Transaction Type")
                {
                }
                 field(Amount;Rec.Amount)
                {
                }
                 field(Source;Rec.Source)
                {
                }
                field(Date;Rec.Date)
                {
                }
                
                field(Time;Rec.Time)
                {
                }
                
                 field("Loan Number";Rec."Loan Number")
                {
                }
                 field("Document Number";Rec."Document Number")
                {
                }
                 field("Account Number";Rec."Account Number")
                {
                }
                 field("ATM Card";Rec."ATM Card")
                {
                }
                field("Computer Name";Rec."Computer Name")
                {
                }
                field("IP Address";Rec."IP Address")
                {
                }
                

                
                
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}


