page 51027 "Defauter Notification Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field("Client Code";Rec."Client Code")
                {
                    Editable = false;
                }
                field("Client Name";Rec."Client Name")
                {
                }
                field("Staff No";Rec."Staff No")
                {
                    Editable = false;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Oustanding Interest";Rec."Outstanding Interest")
                {
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                }
                field("Loans Category";Rec."Loans Category")
                {
                    Editable = false;
                }
                field("Loans Category-SASRA";Rec."Loans Category-SASRA")
                {
                    Editable = false;
                }
                field("Issued Date";REc."Issued Date")
                {
                    Editable = false;
                }
                field("Defaulted Balance";Rec."Defaulted Balance")
                {
                    Editable = false;
                }
                field("Debtor Collection Status";Rec."Debtor Collection Status")
                {
                }
                field("Debt Collectors Name";Rec."Debt Collector Name")
                {
                }
                field("Debt Collector Commission";Rec."Debt Collector Commission")
                {
                    Editable = false;
                }
                field("VAT on Commission";Rec."VAT on Commission")
                {
                    Editable = false;
                }
                field("Total Collection Amount";Rec."Total Collection Amount")
                {
                    Editable = false;
                }
                field("Agreed Instalments";Rec."Agreed Instalments")
                {
                }
                field("Payment Date";Rec."Payment Date")
                {
                    Caption = 'Agreed Payment Start Date';
                }
                field("Agreed Amount";Rec."Agreed Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action("Send Message")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to send SMS?',TRUE,FALSE) THEN BEGIN
                    IF SMS.FINDLAST THEN
                    IEntryNo:=SMS."Entry No"+1
                    ELSE
                    IEntryNo:=1;

                    SMS.INIT;
                    SMS."Entry No":=IEntryNo;
                    SMS.Source:='DEFAULTER';
                    SMS."Telephone No":=Rec."Phone No.";
                    SMS."Account No":=Rec."Account No";
                    SMS."Document No":=Rec."Loan  No.";
                    SMS."Sent To Server":=SMS."Sent To Server"::No;
                    SMS."Date Entered":=TODAY;
                    SMS."SMS Message":='Dear, '+Rec."Client Name"+' Kindly clear your Telepost debt of amount Ksh'+FORMAT(Rec."Agreed Amount")+' as promised earlier.Call 020-5029204.';
                    SMS."Time Entered":=TIME;
                    SMS."Entered By":=USERID;
                    SMS.INSERT(TRUE);
                    MESSAGE('Message Sent.');
                    END;
                end;
            }
            action("Recovery Notes")
            {
                Caption = 'Recovery Notes';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Recovery Notes List";
                RunPageLink = "Loan No"=FIELD("Loan  No.");
            }
            group(custstatement)
            {
                Visible = false;

                action(Statement)
                {
                    Caption = 'Member Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;


                    trigger OnAction()
                    begin
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.",Rec."BOSA No");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(51516223,TRUE,FALSE,Cust);
                    end;
                }
                action(Statement2)
                {
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;


                    trigger OnAction()
                    begin
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.",Rec."BOSA No");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(51516884,TRUE,FALSE,Cust);
                    end;
                }
            }
        }
    }

    var
        SMS: Record "SMS Messages";
        IEntryNo: Integer;
        Cust: Record "Members Register";
}




