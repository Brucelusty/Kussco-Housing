page 51064 "Interest On Savings List"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interest On Savings Prog";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FOSA Account";Rec."FOSA Account")
                {
                }
                field("Member No";rec."Member No")
                {
                }
                field("PF No";rec."PF No")
                {
                }
                field("Member Name";rec."Member Name")
                {
                }
                field("Account Type Name";Rec."Account Type Name")
                {
                }
                field("FOSA Balance";Rec."FOSA Balance")
                {
                }
                field(Date;rec.Date)
                {
                }
                field(Period;Rec.Period)
                {
                }
                field(Year;Rec.Year)
                {
                }
                field("First Interest";Rec."First Interest")
                {
                }
                field("Second Interest";Rec."Second Interest")
                {
                }
                field("Third Interest";Rec."Third Interest")
                {
                }
                field("Gross Interest";rec."Gross Interest")
                {
                }
                field(Posted;Rec.Posted)
                {
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Interest Generation")
            {
                Caption = 'Process Interest';
                Image = CalculateSalesTax;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Generate Interest On Savings";
            }
            action("Interest Transfer")
            {
                Caption = 'Transfer Interest';
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction() 
                var
                intTransfer: Codeunit "Transfer Int on FOSA Sav";
                done: Boolean;
                begin
                    if Confirm('Do you wish to proceed with populating the journal lines?', true) = false then exit;
                    done := intTransfer.transferIntonFOSA(rec."Start Date", rec."End Date");
                    if done then Message('Done') else Error('Failed');
                end;
            }

            action("interest On Savings Report")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                Visible = false;
                Caption = 'Interest On Savings Report';
                RunObject = Report "Interest On Savings";
            }
        }
    }
}

