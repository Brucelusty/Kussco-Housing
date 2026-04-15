//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50753 "Customer Care Log"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Customer Care Logs";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Calling As";Rec."Calling As")
                {

                    trigger OnValidate()
                    begin


                        if Rec."Calling As" = Rec."calling as"::"As Member" then
                            Page.Run(39004305, Rec);
                    end;
                }
                field("Member No";Rec."Member No")
                {
                }
                field("Member Name";Rec."Member Name")
                {
                }
                field("Contact Mode";Rec."Contact Mode")
                {
                }
                field("Calling For";Rec."Calling For")
                {
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                    Editable = false;
                }
                field("Current Deposits";Rec."Current Deposits")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("ID No";Rec."ID No")
                {
                }
                field("Phone No";Rec."Phone No")
                {
                    Caption = 'Mobile No';
                }
                field("Passport No";Rec."Passport No")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Query Code";Rec."Query Code")
                {
                }
                field("Share Capital";Rec."Share Capital")
                {
                    Editable = false;
                }
                field(Source; Rec.Source)
                {
                    Editable = false;
                }
                field("No. Series";Rec."No. Series")
                {
                }
                field("Application User";Rec."Application User")
                {
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    Editable = false;
                }
                field("Application Time";Rec."Application Time")
                {
                    Editable = false;
                }
                field("Receive User";Rec."Receive User")
                {
                    Editable = false;
                }
                field("Receive date";Rec."Receive date")
                {
                    Editable = false;
                }
                field("Receive Time";Rec."Receive Time")
                {
                    Editable = false;
                }
                field("Resolved User";Rec."Resolved User")
                {
                    Editable = false;
                }
                field("Resolved Date";Rec."Resolved Date")
                {
                    Editable = false;
                }
                field("Resolved Time";Rec."Resolved Time")
                {
                    Editable = false;
                }
                field("Received From";Rec."Received From")
                {
                    Editable = false;
                }
                field("Caller Reffered To";Rec."Caller Reffered To")
                {
                }
                field("Date Sent";Rec."Date Sent")
                {
                    Editable = false;
                }
                field("Time Sent";Rec."Time Sent")
                {
                    Editable = false;
                }
                field("Sent By";Rec."Sent By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Detailed Member Page")
            {
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Member Account Card";
                RunPageLink = "No." = field("Member No");
            }
            action("Send To")
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Caller Reffered To");
                    Rec."Date Sent" := WorkDate;
                    Rec."Time Sent" := Time;
                    Rec."Sent By" := UserId;
                    Rec.Modify;
                end;
            }
            action(Receive)
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Receive User" := UserId;
                    Rec."Receive date" := WorkDate;
                    Rec."Receive Time" := Time;
                    Rec.Modify;
                end;
            }
            action(Reselved)
            {
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Rec.Status = Rec.Status::Resolved then begin
                        Error('Customer query has already been %1', Rec.Status);
                    end;



                    //TO ENABLE RESOLUTION OF CUSTOMER QUERIES LOGGED INTO THE SYSTEM
                    CustCare.SetRange(CustCare.No, Rec.No);
                    if CustCare.Find('-') then begin
                        CustCare.Status := CustCare.Status::Resolved;
                        CustCare."Resolved User" := UserId;
                        CustCare."Resolved Date" := WorkDate;
                        CustCare."Resolved Time" := Time;
                        CustCare.Modify;
                    end;

                    CurrPage.Editable := false;
                    /*
                    CQuery.RESET;
                    CQuery.SETRANGE(CQuery.No,No);
                    IF CQuery.FIND('-') THEN BEGIN
                    REPORT.RUN(39004018,TRUE,FALSE,CQuery);
                    END;
                         */

                end;
            }
        }
    }

    var
        Cust: Record "Members Register";
        PvApp: Record "Responsibility Center BR";
        CustCare: Record "Customer Care Logs";
        CQuery: Record "Customer Care Logs";
}






