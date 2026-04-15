namespace KUSCCOHOUSING.KUSCCOHOUSING;

page 65740 "Cue Setup"
{
    ApplicationArea = All;
    Caption = 'Cue Setup';
    PageType = Card;
    SourceTable = "Cue Sacco Roles";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.', Comment = '%';
                }

                field("Application Loans"; Rec."Application Loans")
                {
                    ToolTip = 'Specifies the value of the Application Loans field.', Comment = '%';
                }
                field("Appraisal Loans"; Rec."Appraisal Loans")
                {
                    ToolTip = 'Specifies the value of the Appraisal Loans field.', Comment = '%';
                }
                field("Approved  Petty Cash"; Rec."Approved  Petty Cash")
                {
                    ToolTip = 'Specifies the value of the Approved  Petty Cash field.', Comment = '%';
                }
                field("Approved Accounts Opening"; Rec."Approved Accounts Opening")
                {
                    ToolTip = 'Specifies the value of the Approved Accounts Opening field.', Comment = '%';
                }
                field("Approved Loan Batches"; Rec."Approved Loan Batches")
                {
                    ToolTip = 'Specifies the value of the Approved Loan Batches field.', Comment = '%';
                }
                field("Approved Loans"; Rec."Approved Loans")
                {
                    ToolTip = 'Specifies the value of the Approved Loans field.', Comment = '%';
                }
                field("Approved Payment Voucher"; Rec."Approved Payment Voucher")
                {
                    ToolTip = 'Specifies the value of the Approved Payment Voucher field.', Comment = '%';
                }
                field("Open Account Opening"; Rec."Open Account Opening")
                {
                    ToolTip = 'Specifies the value of the Open Account Opening field.', Comment = '%';
                }
                field("Open Member Applications"; Rec."Open Member Applications")
                {
                    ToolTip = 'Specifies the value of the Open Member Applications field.', Comment = '%';
                }
                field("Pending Account Opening"; Rec."Pending Account Opening")
                {
                    ToolTip = 'Specifies the value of the Pending Account Opening field.', Comment = '%';
                }
                field("Pending Loan Batches"; Rec."Pending Loan Batches")
                {
                    ToolTip = 'Specifies the value of the Pending Loan Batches field.', Comment = '%';
                }
                field("Pending Member Applications"; Rec."Pending Member Applications")
                {
                    ToolTip = 'Specifies the value of the Pending Member Applications field.', Comment = '%';
                }
                field("Pending Payment Voucher"; Rec."Pending Payment Voucher")
                {
                    ToolTip = 'Specifies the value of the Pending Payment Voucher field.', Comment = '%';
                }
                field("Pending Petty Cash"; Rec."Pending Petty Cash")
                {
                    ToolTip = 'Specifies the value of the Pending Petty Cash field.', Comment = '%';
                }

                field("Rejected Loans"; Rec."Rejected Loans")
                {
                    ToolTip = 'Specifies the value of the Rejected Loans field.', Comment = '%';
                }
                field("Rejected Member Applications"; Rec."Rejected Member Applications")
                {
                    ToolTip = 'Specifies the value of the Rejected Member Applications field.', Comment = '%';
                }

                field("Total Corporate Members"; Rec."Total Corporate Members")
                {
                    ToolTip = 'Specifies the value of the Total Corporate Members field.', Comment = '%';
                }
                field("Total Female Members"; Rec."Total Female Members")
                {
                    ToolTip = 'Specifies the value of the Total Female Members field.', Comment = '%';
                }
                field("Total Individual Members"; Rec."Total Individual Members")
                {
                    ToolTip = 'Specifies the value of the Total Individual Members field.', Comment = '%';
                }
                field("Total Joint Members"; Rec."Total Joint Members")
                {
                    ToolTip = 'Specifies the value of the Total Joint Members field.', Comment = '%';
                }
                field("Total Leads"; Rec."Total Leads")
                {
                    ToolTip = 'Specifies the value of the Total Leads field.', Comment = '%';
                }
                field("Total Male Members"; Rec."Total Male Members")
                {
                    ToolTip = 'Specifies the value of the Total Male Members field.', Comment = '%';
                }
                field("Total Members"; Rec."Total Members")
                {
                    ToolTip = 'Specifies the value of the Total Members field.', Comment = '%';
                }
                field("Unassigned Leads"; Rec."Unassigned Leads")
                {
                    ToolTip = 'Specifies the value of the Unassigned Leads field.', Comment = '%';
                }
            }
        }
    }
}


