//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50078 "Mobile Loans Pending"
{
    ApplicationArea = All;
    CardPageID = "Mobile Card(Pending)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Loans Register";
    // SourceTableView = where(Posted = filter(false),
    //                         "Approval Status" = filter(Pending),"Requires Guarantors Mobile"=filter(true),"Archive Loan"=filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Caption = 'Loan Product';
                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member  No';
                }
                field("Client Name"; Rec."Client Name")
                {
                    Caption = 'Member Name';
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Branch Code"; Rec."Branch Code")
                {
                }
                field("Loan Status"; Rec."Loan Status")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field("Issued Date"; Rec."Issued Date")
                {
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                }
                field(Installments; Rec.Installments)
                {
                }
                field(Repayment; Rec.Repayment)
                {
                }
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Client Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        //IF UserSet.GET(USERID) THEN BEGIN
        //SETRANGE("Captured By",USERID);
        //END;
    end;

    var
        UserSet: Record User;
}






