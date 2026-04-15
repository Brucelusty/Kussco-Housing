page 51045 "MPESA Mobile Transactions"
{
    ApplicationArea = All;
    Caption = 'MPESA Mobile Transactions';
    PageType = List;
    SourceTable = "MOBILE MPESA Trans";
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.';
                }
                field("Posted Time";Rec."Posted Time")
                {
                    Caption = 'Document Time';
                }
                field(Trace; Rec.Trace)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Telephone; Rec.Telephone)
                {
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }

                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                    // Visible=false;
                }


                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }

                field("Transaction Found"; Rec."Transaction Found")
                {
                    ToolTip = 'Specifies the value of the Net Salary field.';
                    Visible=false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        postedDate: Date;
        postedTime: Time;
    begin
        postedTime := (DT2Time(Rec.SystemCreatedAt));
        Rec."Posted Time" := postedTime;
    end;
}


