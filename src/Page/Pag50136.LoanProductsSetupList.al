//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50136 "Loan Products Setup List"
{
    ApplicationArea = All;
    CardPageID = "Loan Products Setup Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";
    // SourceTableView = where(Code = filter(<> 'M_OD'));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Code"; rec.Code)
                {
                }
                field("Product Description"; Rec."Product Description")
                {
                }

                field("Interest rate"; Rec."Interest rate")
                {
                }

                field("Special Code"; Rec."Special Code")
                {
                }

                field("Repayment Method"; Rec."Repayment Method")
                {
                }

                field("Instalment Period"; Rec."Instalment Period")
                {
                }
                field("No of Installment"; Rec."No of Installment")
                {
                }

                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Deposit>Loan Analysis";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
}






