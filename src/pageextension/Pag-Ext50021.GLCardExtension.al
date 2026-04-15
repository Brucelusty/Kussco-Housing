//************************************************************************
pageextension 50021 "GLCardExtension" extends "G/L Account Card"
{
    layout
    {
        addafter("No.")
        {
            field("Old No."; Rec."Old No.") { ApplicationArea = All; }

        }
        // Add changes to page layout here
        addlast(General)
        {
            field("Budget Controlled"; Rec."Budget Controlled") { ApplicationArea = All; }

        }
        addafter("Cost Accounting")
        {
            group("Sasra Setup")
            {
                Caption = 'Sasra Setup Controls';
                field(StatementOfFP; Rec.StatementOfFP)
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                    Caption = 'Statement of Financial Position';
                }
                field("Form2F(Statement of C Income)"; Rec."Form2F(Statement of C Income)")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                    Caption = 'Statement of Comprehensive Income';

                }
                field("Capital adequecy"; Rec."Capital adequecy")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
                field(Liquidity; Rec.Liquidity)
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;

                }
                field("Form 2H other disc"; Rec."Form 2H other disc")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                    Caption = 'Form 2H Other disclosures';
                }
                field("Form2E(investment)"; Rec."Form2E(investment)")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
                field("Form2E(investment)Land"; Rec."Form2E(investment)Land")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
                field("Form2E(investment)New"; Rec."Form2E(investment)New")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


