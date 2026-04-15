//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50381 "Staff Claim Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Staff Claim Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Advance Type";Rec."Advance Type")
                {
                }
                field(No; Rec.No)
                {
                    Editable = true;
                    Visible = false;
                }
                field("Account No:";Rec."Account No:")
                {
                    Editable = true;
                }
                field("Account Name";Rec."Account Name")
                {
                    Caption = 'Description';
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {

                    trigger OnValidate()
                    begin
                        /*{Get the total amount paid}
                        Bal:=0;
                        
                        PayHeader.RESET;
                        PayHeader.SETRANGE(PayHeader."Line No.",No);
                        IF PayHeader.FINDFIRST THEN
                          BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No,PayHeader."Line No.");
                            IF PayLine.FIND('-') THEN
                              BEGIN
                                REPEAT
                                  Bal:=Bal + PayLine."Pay Mode";
                                UNTIL PayLine.NEXT=0;
                              END;
                          END;
                        //Bal:=Bal + Amount;
                        
                        IF Bal > PayHeader.Amount THEN
                          BEGIN
                            ERROR('Please ensure that the amount inserted does not exceed the amount in the header');
                          END;
                          */

                    end;
                }
                field("Claim Receipt No";Rec."Claim Receipt No")
                {
                }
                field("Expenditure Date";Rec."Expenditure Date")
                {
                }
                field(Purpose; Rec.Purpose)
                {
                    Caption = 'Expenditure Description';
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code";Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        PayHeader: Record "Pending Vch. Surr. Line";
        PayLine: Record "Receipt Line";
        Bal: Decimal;
}






