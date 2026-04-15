//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50513 "HR Transport Allocation"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Transport Allocations H";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transport Allocation No";Rec."Transport Allocation No")
                {
                    Importance = Promoted;
                }
                field("Destination(s)";Rec."Destination(s)")
                {
                    Importance = Promoted;
                }
                field("Vehicle Reg Number";Rec."Vehicle Reg Number")
                {
                    Importance = Promoted;
                }
                field("Passenger Capacity";Rec."Passenger Capacity")
                {
                    Importance = Promoted;
                }
                field("Assigned Driver";Rec."Assigned Driver")
                {
                }
                field("Driver Name";Rec."Driver Name")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Allocation";Rec."Date of Allocation")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Trip";Rec."Date of Trip")
                {
                    Importance = Promoted;
                }
                field("Time of Trip";Rec."Time of Trip")
                {
                    Importance = Promoted;
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Linked to Invoice No";Rec."Linked to Invoice No")
                {
                    Importance = Promoted;
                }
                field("<Invoice Posting Description>";Rec."Invoice Description")
                {
                    Caption = 'Invoice Posting Description';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            // part("Passenger List";"HR Transport Requisition Pass")
            // {
            //     Caption = 'Passenger List';
            //     SubPageLink = "Allocation No"=field("Transport Allocation No");
            // }
            group("Closing Remarks")
            {
                Caption = 'Closing Remarks';
                field("Opening Odometer Reading";Rec."Opening Odometer Reading")
                {
                    Importance = Promoted;
                }
                field("Closing Odometer Reading";Rec."Closing Odometer Reading")
                {
                    Importance = Promoted;
                }
                field("Journey Route";Rec."Journey Route")
                {
                    Importance = Promoted;
                }
                field("Time out";Rec."Time out")
                {
                    Importance = Promoted;
                }
                field("Time In";Rec."Time In")
                {
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Transport Alloc. Factbox")
            {
                Caption = 'HR Transport Allocations Factbox';
                SubPageLink = "Transport Allocation No" = field("Transport Allocation No");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRTransportAllocationsH.Reset;
                        HRTransportAllocationsH.SetRange(HRTransportAllocationsH."Transport Allocation No", Rec."Transport Allocation No");
                        if HRTransportAllocationsH.Find('-') then
                            Report.Run(55596, true, true, HRTransportAllocationsH);
                    end;
                }
                action("<Action1102755035>p")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Transport Allocation No :: :: has been Re-Opened', Rec."Transport Allocation No");
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Question := Text001;
                        if Confirm(Question) then begin
                            Rec.Status := Rec.Status::Released;
                            Rec.Modify;
                            Message('Transport Allocation No :: :: has been released', Rec."Transport Allocation No");
                        end else begin
                            Message('You selected :: NO :: Release Cancelled');
                        end;
                    end;
                }
            }
        }
    }

    var
        HRTransportAllocationsH: Record "HR Transport Allocations H";
        Text19021002: label 'Passenger List';
        Text001: label 'Are you sure you want to Release this Document?';
        Question: Text;
}






