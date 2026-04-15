//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50108 "Members Statistics"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    Editable = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                }

                field("Current Shares"; Rec."Current Shares")
                {
                    Editable = false;
                    Visible = false;
                }

                field("Dividend Amount"; Rec."Dividend Amount")
                {
                    Editable = false;
                    // Visible = false;
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                }
                group("Share Capital")
                {
                    Caption = 'Share Capital';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                }

                group(LoanAnalysis)
                {
                    field(LoanUderDoubtfulLoass; LoanUderDoubtfulLoass)
                    {
                        Editable = false;
                        StyleExpr = FieldStyle;
                        trigger OnValidate()
                        begin
                            LoanUderDoubtfulLoass := auFactory.LoanPerformance(Rec."No.", Today);

                        end;
                    }
                    field(LoanunderDoubtfulandloss; LoanunderDoubtfulandloss)
                    {
                        Editable = false;

                        Caption = 'Loan under Loss and Doubtful Balance';
                    }
                    field("Member Deposit"; Rec."Current Shares")
                    {
                        Editable = false;
                    }
                    field(LoanCreditScore; LoanCreditScore)
                    {
                        Editable = false;
                        StyleExpr = FieldStyle;
                    }

                }


            }
            part(Control7; "Loans Sub-Page List")
            {
                Editable = false;
                SubPageLink = "Client Code" = field("No.");
            }
            part("Member Accounts"; "Member Accounts")
            {
                Editable = false;
                SubPageLink = "BOSA Account No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Recovery Logs")
            {
                Image = Form;
                Promoted = true;
                //     RunObject = Page "Loan Recovery Logs List";
                //     RunPageLink = "Member No" = field("No."),
                //                   "Member Name" = field(Name);
                //
            }

            action("Guarantor Recovery Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record "Members Register";
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.run(172951, true, false, ObjCust);
                end;
            }
            action("BOSA Account Recovery Report")
            {
                Caption = 'BOSA Account Recovery Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record "Members Register";
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.run(172068, true, false, ObjCust);
                end;
            }
            action("Loan Recovery Log Report")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.run(172963, true, false, ObjCust);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("Client Code","No.");
        IF ObjLoans.FIND('-') THEN
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(ObjLoans)-ObjLoans."Interest Paid";*/

    end;

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'') AND ("Assigned System ID"<>USERID) THEN BEGIN
          ERROR('You do not have permission to view this account Details');
          END;*/

        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;
        end;


        LoanUderDoubtfulLoass := auFactory.LoanPerformance(Rec."No.", Today);
        LoanunderDoubtfulandloss := auFactory.LoanUnderLossBlance(Rec."No.", Today);
        if Rec."Current Shares" > LoanunderDoubtfulandloss then begin
            LoanCreditScore := 10;

        end else begin
            LoanCreditScore := 0;

        end;
        if LoanCreditScore = 0 then
            FieldStyle := 'Attention';
        if LoanCreditScore = 1 then
            FieldStyle := 'Favorable';

        SetFieldStyle;
    end;

    var
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;

        LoanCreditScore: Integer;
        auFactory: Codeunit "Au Factory";
        LoanunderDoubtfulandloss: Decimal;
        LoanUderDoubtfulLoass: Integer;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Un-allocated Funds");
        if Rec."Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
        if LoanCreditScore = 0 then
            FieldStyle := 'Attention';
        if LoanCreditScore = 1 then
            FieldStyle := 'Favorable';
    end;
}






