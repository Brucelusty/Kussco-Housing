//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50435 "Store Requisition Line"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Store Requistion Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Remark';
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Qty in store"; Rec."Qty in store")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity To Issue';
                }
                field("Issuing Store";Rec."Issuing Store")
                {
                }
                field("Bin Code";Rec."Bin Code")
                {
                    Visible = false;
                }
                field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Item Status";Rec."Item Status")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Lot No.";Rec."Lot No.")
                {
                    Editable = true;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        //Rec.OpenItemTrackingLines;
                    end;
                }
            }
        }
    }
}






