page 50042 "ESS Refund Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "ESS Refund";
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("ESSRef No.";Rec."ESSRef No.")
                {
                    
                }
                field("Member No";Rec."Member No")
                {
                    
                }
                field("Member Name";Rec."Member Name")
                {
                    
                }
                field("PF No";Rec."PF No")
                {
                    
                }
                field("Early Refund";Rec."Early Refund")
                {
                    
                }
                field("Captured On";Rec."Captured On")
                {
                    
                }
                field("Registered On";Rec."Registered On")
                {
                    
                }
                field("Maturing On";Rec."Maturing On")
                {
                    
                }
                field("Has Active ESS Loan";Rec."Has Active ESS Loan")
                {
                    
                }
                field("ESS Refund";Rec."ESS Refund")
                {
                    
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Register)
            {
                Caption = 'Register';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction() begin
                    if cust.Get(Rec."Member No") then begin
                        Rec.TestField("ESS Refund");
                        loansReg.Reset();
                        loansReg.SetRange("Client Code", Rec."Member No");
                        loansReg.SetRange("Loan Product Type", 'L04');
                        loansReg.SetFilter("Outstanding Balance", '>%1',0);
                        if loansReg.Find('-') then begin
                            loansReg.CalcFields("Outstanding Balance");
                            if loansReg."Outstanding Balance" > 0 then begin
                                Error('The member has an ESS loan: %1, with an outstanding balance of %2.', loansReg."Loan  No.", loansReg."Outstanding Balance");
                            end;
                        end;

                        vend.Reset();
                        vend.SetRange("BOSA Account No", Rec."Member No");
                        vend.SetRange("Account Type", '104');
                        if vend.Find('-') then begin
                            vend.CalcFields(Balance);
                            if vend.Balance <= 0 then Error('The member has no amount in their ESS Savings Account.');
                        end else Error('The selected member has no ESS Savings Account.');
                        
                        // rec."Registered On":= Today;
                        rec.Validate("Registered On");
                        rec.Registered:= true;
                        rec.modify;
                        Message('The ESS refund has been successfully registered.');
                    end;
                end;
            }
        }
    }
    var
    cust: Record Customer;
    vend: Record Vendor;
    loansReg: Record "Loans Register";
}


