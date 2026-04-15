namespace TelepostSacco.TelepostSacco;
using Microsoft.Sales.Customer;

page 51179 "Pay Staff Marketing"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Staff Marketing Payment";
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Report,Process,Approvals';
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Member No";Rec."Member No")
                {
                    // Editable = false;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Payment Date";Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Payment By";Rec."Payment By")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
            }
            part("Reffered Members"; "Staff Recuited Members")
            {
                SubPageLink = "Reffered By Member No" = field("Member No");
            }
            
            part("Introduced Salaries"; "Staff Recruited Salaries")
            {
                SubPageLink = "Staff No." = field("Staff No."), Status = filter(Approved);
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post Bonus';
                Image = PostedVendorBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction() begin
                    hrSetup.Get();
                    introMembers := 0;
                    introSalaries := 0;

                    cust.Reset();
                    cust.SetRange("Reffered By Member No", Rec."Member No");
                    cust.SetRange("Staff Paid", false);
                    if cust.FindSet() then begin
                        introMembers := cust.Count;
                    end;
                    Message('Pending Development');
                end;
            }
        }
        area(Navigation)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction() begin
                    Rec.TestField("Membership Rate");
                    Rec.TestField("Salary Rate");
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                    Message('The record has been approved');
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction() begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('The approval request has been canceled');
                end;
            }
            action(Approvals)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction() begin
                    Message('There exists no ongoing approval instances for this record.');
                end;
            }
        }
        area(Reporting)
        {
            action(Report)
            {
                Caption = 'Review Report';
                Image = ReviewWorksheet;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;

                trigger OnAction() begin
                    Message('Pending Development');
                end;
            }
        }
    }

    var
    introMembers: Integer;
    introSalaries: Integer;
    hrSetup: Record "HR Setup";
    cust: Record Customer;
    salaries: Record "Register Salary Accounts";

}


