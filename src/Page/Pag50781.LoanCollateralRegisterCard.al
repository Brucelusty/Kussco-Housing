//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50781 "Loan Collateral Register Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loan Collateral Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    Editable = false;
                }
                field("Collateral Code"; Rec."Collateral Code")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        landDet := false;
                        vehicleDet := false;
                        if rec."Collateral Security" = rec."Collateral Security"::"Log BooK" then begin
                            landDet := false;
                            vehicleDet := true;
                        end else if rec."Collateral Security" = rec."Collateral Security"::"Title Deed" then begin
                            vehicleDet := false;
                            landDet := true;
                        end;
                    end;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                }
                field("CollateralSecurity Description"; Rec."CollateralSecurity Description")
                {
                }
                field("Collateral Category"; Rec."Collateral Category")
                {
                }
                field("Collateral Security"; Rec."Collateral Security")
                {
                    Visible = false;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    Visible = false;
                }
                field("Collateral Posting Group"; Rec."Collateral Posting Group")
                {
                    Visible = false;
                    ShowMandatory = true;
                    Editable = false;
                }



                field("Date Received"; Rec."Date Received")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Received By"; Rec."Received By")
                {
                }

                field(Picture; Rec.Picture)
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }

                field("Percentage Value"; Rec."Percentage Value")
                {
                }

                field("Guaranteed Amount"; Rec."Guaranteed Amount")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            group("Physical & Technical Attributes")
            {
                field("Property Status"; Rec."Property Status")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                    Visible = false;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Property Location"; Rec."Property Location")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Property Location Description"; Rec."Property Location Description")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Land Size"; Rec."Land Size")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Land Topology"; Rec."Land Topology")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Type Of Soil"; Rec."Type Of Soil")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }


            }

            group("Valuation Findings")
            {

                field("Search No"; Rec."Search No")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("IR No"; Rec."IR No")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Registered Owner ID"; Rec."Registered Owner ID")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Registered Owner KRA Pin"; Rec."Registered Owner KRA Pin")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Registered Owner Phone"; Rec."Registered Owner Phone")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }

                field("Registered Owner E-mail"; Rec."Registered Owner E-mail")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Registered Owner Location"; Rec."Registered Owner Location")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Reference No"; Rec."Registration/Reference No")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }
                field("Market Value"; Rec."Market Value")
                {
                    ShowMandatory = True;
                    Editable = not rec.Bonded;
                }
                field("Forced Sale Value"; Rec."Forced Sale Value")
                {
                    ShowMandatory = true;
                    Editable = not rec.Bonded;
                }

            }
            part(Control3; "Collateral Valuations")
            {
                // Visible = false;
                Caption = 'Loan Collateral  Valuations';
                SubPageLink = "Collateral ID" = field("Document No");
            }
            group("Collateral Release Details")
            {
                field("Date Released"; Rec."Date Released")
                {
                    Editable = false;
                }
                field("Released By"; Rec."Released By")
                {
                    Editable = false;
                }


            }

            group("Insurance Details")
            {
                Visible = false;
                field("Insurance Effective Date"; Rec."Insurance Effective Date")
                {
                    Editable = not rec.Bonded;
                }
                field("Insurance Expiration Date"; Rec."Insurance Expiration Date")
                {
                    Editable = not rec.Bonded;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    Editable = not rec.Bonded;
                }
                field("Insurance Annual Premium"; Rec."Insurance Annual Premium")
                {
                    Editable = not rec.Bonded;
                }
                field("Policy Coverage"; Rec."Policy Coverage")
                {
                    Editable = not rec.Bonded;
                }
                field("Total Value Insured"; Rec."Total Value Insured")
                {
                    Editable = not rec.Bonded;
                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    Editable = not rec.Bonded;
                }
                field("Insurance Vendor No."; Rec."Insurance Vendor No.")
                {
                    Editable = not rec.Bonded;
                }
                field("Insurance Vendor Name"; Rec."Insurance Vendor Name")
                {
                    Caption = 'Insurance Vendor Name';
                    Editable = false;
                }
            }
            group("Depreciation Details")
            {
                Visible = false;
                field("Asset Value"; Rec."Asset Value")
                {
                    Editable = false;
                }
                field("Depreciation Completion Date"; Rec."Depreciation Completion Date")
                {
                    Caption = 'Expected Date of Loan Complition';
                    Editable = false;
                }
                field("Depreciation Percentage"; Rec."Depreciation Percentage")
                {
                    Editable = false;
                }
                field("Collateral Depreciation Method"; Rec."Collateral Depreciation Method")
                {
                    Editable = false;
                }
                field("Asset Depreciation Amount"; Rec."Asset Depreciation Amount")
                {
                    Editable = false;
                }
                field("Asset Value @Loan Completion"; Rec."Asset Value @Loan Completion")
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
            action(CollateralAttachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CollateralAttachments: Page "Collateral Attachments";
                begin
                    CollateralAttachments.SetLoanNo(Rec."Document No");
                    CollateralAttachments.RunModal();
                end;
            }
            action("Calculate Depreciation")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                begin

                    VarNoofYears := ROUND((Rec."Depreciation Completion Date" - Today) / 365, 1, '>');

                    //===========Update Year 1 Depreciation==================================
                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindSet = false then begin
                        VarDepreciationValue := Rec."Asset Value" * (Rec."Depreciation Percentage" / 100);

                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', Today);
                        ObjCollateralDeprReg."Transaction Description" := 'Year 1 Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := Rec."Asset Value" - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;

                    end;
                    //=============End of Update Year 1 Depreciation==========================


                    //===========Update Year 2 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;

                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 2 Depreciation==========================

                    //===========Update Year 3 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 3 Depreciation==========================

                    //===========Update Year 4 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 4 Depreciation==========================

                    //===========Update Year 5 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 5 Depreciation==========================

                    //===========Update Year 6 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 6 Depreciation==========================
                end;
            }
            action("Depreciation Schedule")
            {
                Image = Form;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Collateral Depr. Schedule";
                RunPageLink = "Document No" = field("Document No");
            }
            action("New Collateral Action")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                RunObject = Page "Collateral Movement List";
                RunPageLink = "Collateral ID" = field("Document No");

            }
            action("Register Collateral")
            {
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if rec."Member No." = '' then Error('Kindly fill in the member details.');
 
            
/*                     if (rec."Valuer Name" = '') or (rec."Valuer Address" = '') or (rec."Valuer Phone No" = '') then Error('Kindly fill in the Valuer''s information.');
                    if rec."Market Value" = 0 then Error('Kindly fill in the market value of the collateral.');
                    if rec."Forced Sale Value" = 0 then Error('Kindly fill in the forced sale value of the collateral.'); */

                    if Confirm('Do you wish to register this collateral?', true) = false then exit;

                    rec.Bonded := true;
                    rec."Date Bonded" := Today;
                    rec."Bonded By" := UserId;
                    rec.modify;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnGetVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        FnGetVisibility();
    end;

    var
        ObjCollateralDeprReg: Record "Collateral Depr Register";
        ObjCollateralDetails: Record "Loan Collateral Details";
        VarNoofYears: Integer;
        VarDepreciationValue: Decimal;
        ObjDepreciationRegister: Record "Collateral Depr Register";
        VarDepreciationNo: Integer;
        ObjDeprCollateralMaster: Record "Collateral Depr Register";
        VarCurrentNBV: Decimal;
        ReceivedAtHQVisible: Boolean;
        StrongRoomVisible: Boolean;
        LawyerVisible: Boolean;
        InsuranceAgentVisible: Boolean;
        BranchVisible: Boolean;
        IssuetoMemberVisible: Boolean;
        IssuetoAuctioneerVisible: Boolean;
        SafeCustodyVisible: Boolean;
        landDet: Boolean;
        vehicleDet: Boolean;

    local procedure FnGetVisibility()
    begin
        if Rec.Action = Rec.Action::"Receive at HQ" then begin
            ReceivedAtHQVisible := true;
        end;
        if (Rec.Action = Rec.Action::"Dispatch to Branch") or (Rec.Action = Rec.Action::"Receive at Branch") then begin
            BranchVisible := true;
        end;
        if (Rec.Action = Rec.Action::"Issue to Lawyer") or (Rec.Action = Rec.Action::"Receive From Lawyer") then begin
            LawyerVisible := true;
        end;
        if Rec.Action = Rec.Action::"Issue to Auctioneer" then begin
            IssuetoAuctioneerVisible := true;
        end;
        if Rec.Action = Rec.Action::"Issue to Insurance Agent" then begin
            InsuranceAgentVisible := true;
        end;
        if Rec.Action = Rec.Action::"Release to Member" then begin
            IssuetoMemberVisible := true;
        end;
        if Rec.Action = Rec.Action::"Retrieve From Strong Room" then begin
            SafeCustodyVisible := true;
        end;

        landDet := false;
        vehicleDet := false;
        if rec."Collateral Security" = rec."Collateral Security"::"Log BooK" then begin
            landDet := false;
            vehicleDet := true;
        end else if rec."Collateral Security" = rec."Collateral Security"::"Title Deed" then begin
            vehicleDet := false;
            landDet := true;
        end;
    end;

}






