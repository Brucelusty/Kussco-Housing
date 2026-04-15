page 51050 "ATM Log Entries"
{
    ApplicationArea = All;
    Caption = 'ATM Log Entries';
    PageType = List;
    SourceTable = "ATM Log Entries3";
    // Editable = false;
    SourceTableView = sorting("Entry No") order(descending);
    //ModifyAllowed = false;
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Date Time"; Rec."Date Time")
                { }
                field("Posted Date"; Rec."Posted Date")
                { }
                field("Posted Time"; Rec."Posted Time")
                { }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the Member''s Account No.';
                }
                field("Account Name"; Rec."Account Name")
                { }
                field("Message ID"; Rec."Message ID")
                { }
                field("Transaction Type"; Rec."Transaction Type")
                { }
                field("ATM No"; Rec."ATM No")
                {
                    ToolTip = 'Specifies the Member''s ATM No.';
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the Member''s ATM No.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Account Balance";Rec."Account Balance")
                {
                }
                field("Trace ID"; Rec."Trace ID")
                {
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("institution Name"; Rec."institution Name")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                { }
                field("Connection Mode";Rec."Connection Mode")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field(Reversed;Rec.Reversed)
                { }
                field("Bank Doc_No";Rec."Bank Doc_No")
                { }
                
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        ATMLog: Record "ATM Log Entries3";
        Vend: Record Vendor;
        postedDate: Date;
        postedTime: Time;
    begin
        Vend.Reset();
        Vend.SetRange("No.", rec."Account No");
        if Vend.FindSet() then begin
            Rec."Account Name" := Vend.Name;
        end;

        postedDate := DT2Date(Rec."Date Time");
        postedTime := DT2Time(Rec."Date Time");
        Rec."Posted Date" := postedDate;
        Rec."Posted Time" := postedTime;
    end;
}


