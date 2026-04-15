page 50375 atmLogentries
{
    ApplicationArea = All;
    Caption = 'atmLogentries';
    PageType = List;
    SourceTable = "ATM Log Entries";
    UsageCategory = Lists;

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
                {
                    ToolTip = 'Specifies the value of the Date Time field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("ATM No"; Rec."ATM No")
                {
                    ToolTip = 'Specifies the value of the ATM No field.';
                }
                field("ATM Location"; Rec."ATM Location")
                {
                    ToolTip = 'Specifies the value of the ATM Location field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Return Code"; Rec."Return Code")
                {
                    ToolTip = 'Specifies the value of the Return Code field.';
                }
                field("Trace ID"; Rec."Trace ID")
                {
                    ToolTip = 'Specifies the value of the Trace ID field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Card No."; Rec."Card No.")
                {
                    ToolTip = 'Specifies the value of the Card No. field.';
                }
                field("ATM Amount"; Rec."ATM Amount")
                {
                    ToolTip = 'Specifies the value of the ATM Amount field.';
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                {
                    ToolTip = 'Specifies the value of the Withdrawal Location field.';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}


