report 50720 "Members without Default FOSA"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    // DefaultLayout = RDLC;
    // RDLCLayout = 'Layouts\MemberswithoutFOSADefaults.rdlc';
    
    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.";//

            DataItemTableView = where(ISNormalMember = const(true));
            column(Member_No;"No.")
            {}
            // column(lacks101;lacks101)
            // {}
            // column(lacks102;lacks102)
            // {}
            // column(lacks103;lacks103)
            // {}
            // column(vendNotPresent;vendNotPresent)
            // {}
            // column()
            // {}
            trigger OnAfterGetRecord() begin
                lacks101:= true;
                lacks102:= true;
                lacks103:= true;
                Customer.CalcFields(Customer."Share Capital Found",Customer."Deposits Found",Customer."Ordinary Found");

                if Customer."Ordinary Found"=true then
                CurrReport.Skip();
/*                 vend.Reset();
                vend.SetRange("BOSA Account No", Customer."No.");
                if vend.FindSET then begin
                    vendNotPresent:= false;
                    repeat
                        if vend."Account Type" = '101' then
                        begin
                            lacks101:= false;
                        end else if vend."Account Type" = '102' then
                        begin
                            lacks102:= false;
                        end else if vend."Account Type" = '103' then
                        begin
                            lacks103:= false;
                        end;
                    until vend.Next() = 0; */

                    // if Customer."Share Capital Found" = false then begin
                    //     fosaAcctypes.Get('101');
                    //     newFOSANo:= fosaAcctypes.Branch + '-' +Customer."No."+ '-' + fosaAcctypes."Product Code";
                    //     vends.Reset();
                    //     vends.SetRange(vends."No.", newFOSANo);
                    //     if not vends.Find('-') then begin
                    //         vend.Init;
                    //         vend."No." := newFOSANo;
                    //         vend."Account Type" := fosaAcctypes.Code;
                    //         vend."Account Type Name" := fosaAcctypes.Description;
                    //         vend."Vendor Posting Group" := fosaAcctypes."Posting Group";
                    //         vend."BOSA Account No":= Customer."No.";
                    //         vend."Creditor Type" := vend."Creditor Type"::"FOSA Account";
                    //         vend."Global Dimension 1 Code" := Format(fosaAcctypes."Activity Code");
                    //         if Customer."Account Category" = Customer."Account Category"::Joint then begin
                    //             vend."Account Category" := vend."Account Category"::"Corporate"
                    //         end else begin
                    //             vend."Account Category" := Customer."Account Category";
                    //         end;
                    //         vend."First Name":= Customer."First Name";
                    //         vend."Middle Name":= Customer."Middle Name";
                    //         vend."Last Name":= Customer."Last Name";
                    //         vend.Name := Customer.Name;
                    //         vend.Gender := Customer.Gender;
                    //         vend."Employer Code" := Customer."Employer Code";
                    //         vend."Reffered By Member No" := Customer."Reffered By Member No";
                    //         vend."E-mail" := Customer."E-mail";
                    //         vend."Address" := Customer."Address";
                    //         vend."ID No." := Customer."ID No.";
                    //         vend."KRA Pin" := Customer.Pin;
                    //         vend."Personal No." := Customer."Payroll No";
                    //         vend."Mobile Phone No" := Customer."Mobile Phone No";
                    //         vend."Date of Birth" := Customer."Date Of Birth";
                    //         vend.piccture := Customer.Piccture;
                    //         vend.Signature := Customer.Signature;
                    //         vend."ID Front" := Customer."ID Front";
                    //         vend."ID Back" := Customer."ID Back";
                    //         vend."Registration Date" := Customer."Registration Date";
                    //         vend."Created By" := UserId;
                    //         vend.Status := vend.Status::Active;
                    //         // if not vend.insert then 
                    //         vend.Insert;
                    //     end;
                    // end;
                    //  if Customer."Deposits Found" = false then begin
                    //     fosaAcctypes.Get('102');
                    //     newFOSANo:= fosaAcctypes.Branch + '-' +Customer."No."+ '-' + fosaAcctypes."Product Code";
                    //     vends.Reset();
                    //     vends.SetRange(vends."No.", newFOSANo);
                    //     if not vends.Find('-') then begin
                    //         vend.Init;
                    //         vend."No." := newFOSANo;
                    //         vend."Account Type" := fosaAcctypes.Code;
                    //         vend."Account Type Name" := fosaAcctypes.Description;
                    //         vend."Vendor Posting Group" := fosaAcctypes."Posting Group";
                    //         vend."BOSA Account No":= Customer."No.";
                    //         vend."Creditor Type" := vend."Creditor Type"::"FOSA Account";
                    //         vend."Global Dimension 1 Code" := Format(fosaAcctypes."Activity Code");
                    //         if Customer."Account Category" = Customer."Account Category"::Joint then begin
                    //             vend."Account Category" := vend."Account Category"::"Corporate"
                    //         end else begin
                    //             vend."Account Category" := Customer."Account Category";
                    //         end;
                    //         vend."First Name":= Customer."First Name";
                    //         vend."Middle Name":= Customer."Middle Name";
                    //         vend."Last Name":= Customer."Last Name";
                    //         vend.Name := Customer.Name;
                    //         vend.Gender := Customer.Gender;
                    //         vend."Employer Code" := Customer."Employer Code";
                    //         vend."Reffered By Member No" := Customer."Reffered By Member No";
                    //         vend."E-mail" := Customer."E-mail";
                    //         vend."Address" := Customer."Address";
                    //         vend."ID No." := Customer."ID No.";
                    //         vend."KRA Pin" := Customer.Pin;
                    //         vend."Personal No." := Customer."Payroll No";
                    //         vend."Mobile Phone No" := Customer."Mobile Phone No";
                    //         vend."Date of Birth" := Customer."Date Of Birth";
                    //         vend.piccture := Customer.Piccture;
                    //         vend.Signature := Customer.Signature;
                    //         vend."ID Front" := Customer."ID Front";
                    //         vend."ID Back" := Customer."ID Back";
                    //         vend."Registration Date" := Customer."Registration Date";
                    //         vend."Created By" := UserId;
                    //         vend.Status := vend.Status::Active;
                    //         // if not vend.insert then 
                    //         vend.Insert;
                    //     end;
                    // end;
                    if Customer."Ordinary Found" = false then begin
                        fosaAcctypes.Get('103');
                        newFOSANo:= fosaAcctypes.Branch + '-' +Customer."No."+ '-' + fosaAcctypes."Product Code";
                        vends.Reset();
                        vends.SetRange(vends."No.", newFOSANo);
                        if not vends.Find('-') then begin
                            vend.Init;
                            vend."No." := newFOSANo;
                            vend."Account Type" := fosaAcctypes.Code;
                            vend."Account Type Name" := fosaAcctypes.Description;
                            vend."Vendor Posting Group" := fosaAcctypes."Posting Group";
                            vend."BOSA Account No":= Customer."No.";
                            vend."Creditor Type" := vend."Creditor Type"::"FOSA Account";
                            vend."Global Dimension 1 Code" := Format(fosaAcctypes."Activity Code");
                            if Customer."Account Category" = Customer."Account Category"::Joint then begin
                                vend."Account Category" := vend."account category"::Corporate;
                                vend."Group Category" := vend."Group Category"::"Co-operate";
                            end else begin
                                vend."Account Category" := Customer."Account Category";
                            end;
                            vend."First Name":= Customer."First Name";
                            vend."Middle Name":= Customer."Middle Name";
                            vend."Last Name":= Customer."Last Name";
                            vend.Name := Customer.Name;
                            vend.Gender := Customer.Gender;
                            vend."Employer Code" := Customer."Employer Code";
                            vend."Reffered By Member No" := Customer."Reffered By Member No";
                            vend."E-mail" := Customer."E-mail";
                            vend."Address" := Customer."Address";
                            vend."ID No." := Customer."ID No.";
                            vend."KRA Pin" := Customer.Pin;
                            vend."Personal No." := Customer."Payroll No";
                            vend."Mobile Phone No" := Customer."Mobile Phone No";
                            vend."Date of Birth" := Customer."Date Of Birth";
                            vend.piccture := Customer.Piccture;
                            vend.Signature := Customer.Signature;
                            vend."ID Front" := Customer."ID Front";
                            vend."ID Back" := Customer."ID Back";
                            vend."Registration Date" := Customer."Registration Date";
                            vend."Created By" := UserId;
                            vend.Status := vend.Status::Active;
                            // if not vend.insert then 
                            vend.Insert;
                        end else begin
                            vend.Reset();
                            vend.SetRange("No.", newFOSANo);
                            if vend.Find('-') then begin
                                vend."BOSA Account No":= Customer."No.";
                                vend."Creditor Type" := vend."Creditor Type"::"FOSA Account";
                                vend."Global Dimension 1 Code" := Format(fosaAcctypes."Activity Code");
                                if Customer."Account Category" = Customer."Account Category"::Joint then begin
                                    vend."Account Category" := vend."account category"::Corporate;
                                    vend."Group Category" := vend."Group Category"::"Co-operate";
                                end else begin
                                    vend."Account Category" := Customer."Account Category";
                                end;
                                vend."First Name":= Customer."First Name";
                                vend."Middle Name":= Customer."Middle Name";
                                vend."Last Name":= Customer."Last Name";
                                vend.Name := Customer.Name;
                                vend.Gender := Customer.Gender;
                                vend."Employer Code" := Customer."Employer Code";
                                vend."Reffered By Member No" := Customer."Reffered By Member No";
                                vend."E-mail" := Customer."E-mail";
                                vend."Address" := Customer."Address";
                                vend."ID No." := Customer."ID No.";
                                vend."KRA Pin" := Customer.Pin;
                                vend."Personal No." := Customer."Payroll No";
                                vend."Mobile Phone No" := Customer."Mobile Phone No";
                                vend."Date of Birth" := Customer."Date Of Birth";
                                vend.piccture := Customer.Piccture;
                                vend.Signature := Customer.Signature;
                                vend."ID Front" := Customer."ID Front";
                                vend."ID Back" := Customer."ID Back";
                                vend."Registration Date" := Customer."Registration Date";
                                vend."Created By" := UserId;
                                vend.Status := vend.Status::Active;
                                vend.modify
                            end;
                        end;
                    end; 
                // end else begin
                //     vendNotPresent:= true;
                // end;
            end;
        }
    }
    
    var
    myInt: Integer;
    vend: Record Vendor;
    vends: Record Vendor;
    fosaAcctypes: Record "Account Types-Saving Products";
    lacks101: Boolean;
    lacks102: Boolean;
    lacks103: Boolean;
    vendNotPresent: Boolean;
    membNo: Code[20];
    newFOSANo: Code[20];

}
