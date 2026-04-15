//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50904 "Membership Application Saction"
{
    ApplicationArea = All;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Membership Reg Sactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Sanction Type";Rec."Sanction Type")
                {
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Name of Individual/Entity";Rec."Name of Individual/Entity")
                {
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                }
                field("Palace Of Birth";Rec."Palace Of Birth")
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Listing Information";Rec."Listing Information")
                {
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Control Date";Rec."Control Date")
                {
                }
            }
            group(Control3)
            {
                Visible = VarPepsVisible;
                field("County Code";Rec."County Code")
                {
                }
                field("County Name";Rec."County Name")
                {
                }
                field("Position Runing For";Rec."Position Runing For")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        VarAUSanctionVisible := false;
        VarPepsVisible := false;

        if Rec."Sanction Type" = Rec."sanction type"::"AU Sanction" then begin
            VarAUSanctionVisible := true;
        end;

        if Rec."Sanction Type" = Rec."sanction type"::PEPs then begin
            VarPepsVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        VarAUSanctionVisible := false;
        VarPepsVisible := false;

        if Rec."Sanction Type" = Rec."sanction type"::"AU Sanction" then begin
            VarAUSanctionVisible := true;
        end;

        if Rec."Sanction Type" = Rec."sanction type"::PEPs then begin
            VarPepsVisible := true;
        end;
    end;

    var
        VarAUSanctionVisible: Boolean;
        VarPepsVisible: Boolean;
}






