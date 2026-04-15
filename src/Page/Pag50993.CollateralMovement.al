//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50993 "Collateral Movement"
{
    ApplicationArea = All;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Collateral Movement  Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                }
                field("Action Application date";Rec."Action Application date")
                {
                }
                field("Action Type";Rec."Action Type")
                {
                }
                field("Actioned By(Custodian 1)";Rec."Actioned By(Custodian 1)")
                {
                }
                field("Actioned By(Custodian 2)";Rec."Actioned By(Custodian 2)")
                {
                }
                field("Actioned On(Custodian 1)";Rec."Actioned On(Custodian 1)")
                {
                }
                field("Actioned On(Custodian 2)";Rec."Actioned On(Custodian 2)")
                {
                }
                field("Lawyer Code";Rec."Lawyer Code")
                {
                }
                field("Lawyer Name";Rec."Lawyer Name")
                {
                }
                field("Insurance Agent Code";Rec."Insurance Agent Code")
                {
                }
                field("Insurance Agent Name";Rec."Insurance Agent Name")
                {
                }
                field("Action Branch";Rec."Action Branch")
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
        CustodiansDetailsvisible := false;
        LawyersDetailsvisible := false;
        InsuranceDetailsvisible := false;
        BranchDetailsvisible := false;
        Auctioneervisible := false;

        if ObjCollateralActions.Get(Rec."Action Type") then begin
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                LawyersDetailsvisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                InsuranceDetailsvisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Auctioneer then begin
                Auctioneervisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                BranchDetailsvisible := true;
            end;
            if ObjCollateralActions."No Of Users to Effect Action" = ObjCollateralActions."no of users to effect action"::Dual then begin
                CustodiansDetailsvisible := true;
            end;
        end;
    end;

    var
        CustodiansDetailsvisible: Boolean;
        LawyersDetailsvisible: Boolean;
        InsuranceDetailsvisible: Boolean;
        BranchDetailsvisible: Boolean;
        Auctioneervisible: Boolean;
        ObjCollateralActions: Record "Collateral Movement Actions";
        ObjCustodians: Record "Safe Custody Custodians";
}






