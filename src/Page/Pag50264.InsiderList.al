page 50264 "Insider List"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = InsiderLending;
    // DeleteAllowed = false;
    // Editable = false;
    // InsertAllowed = false;
    PromotedActionCategories = 'New,Report,Process,Insider Details';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No";Rec."Member No")
                {

                }
                field("Member Name";Rec."Member Name")
                {
                    Editable = false;
                }
                field("ID No.";Rec."ID No.")
                {
                    Editable = false;
                }
                field("E-Mail";Rec."E-Mail")
                {
                    Editable = false;
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                    Editable = false;
                }
                field(Employer;Rec.Employer)
                {
                    Editable = false;
                    Style = Strong;
                }
                field("Position Held";Rec."Position Held")
                {
                    StyleExpr = insiderType;
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(BOSA)
            {
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Caption = 'BOSA Details';
                Image = Customer;
                trigger OnAction()
                begin
                    cust.Reset();
                    cust.SetRange("No.", Rec."Member No");
                    if cust.Find('-') then begin
                        Page.Run(50012, cust);
                    end;
                end;
            }
            action(FOSA)
            {
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Caption = 'FOSA Details';
                Image = VendorContact;
                trigger OnAction()
                begin
                    vend.Reset();
                    vend.SetRange("BOSA Account No", Rec."Member No");
                    vend.SetRange("Account Type", '103');
                    if vend.Find('-') then begin
                        Page.Run(172436, vend);
                    end;
                end;
            }
        }
    }

    var
    myInt: Integer;
    insiderType: Text[500];
    cust: Record Customer;
    vend: Record Vendor;

    trigger OnAfterGetRecord()
    begin
        FnGetInsiderType();
    end;
    trigger OnAfterGetCurrRecord()
    begin
        FnGetInsiderType();
    end;

    local procedure FnGetInsiderType()
    var
        myInt: Integer;
    begin
        if Rec."Position Held" = rec."Position Held"::Employee then begin
            insiderType := 'Favorable';
        end else if Rec."Position Held" = rec."Position Held"::Director then begin
            insiderType := 'StrongAccent';
        end else if Rec."Position Held" = rec."Position Held"::Delegate then begin
            insiderType := 'Subordinate';
        end else begin
            insiderType := 'Standard';
        end;
    end;
}


