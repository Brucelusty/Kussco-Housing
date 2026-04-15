page 51030 "UFAA List"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "UFAA Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Members Name"; Rec."Members Name")
                {
                }
                field("Member PF"; Rec."Member PF")
                {
                    caption = 'Payroll No';
                }
                field("ID Number"; Rec."ID Number")
                { }
                field("Mobile Number"; Rec."Mobile Number")
                { }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(EmployerCode; Rec.EmployerCode) { }
                field(Source; Rec.Source)
                {
                }
                field(Shares; Rec.Shares)
                {
                    caption = 'Share Capital';
                }
                field("Last Transaction Date_Shares";Rec."Last Transaction Date_Shares")
                {
                    Caption = 'Share-Capital Last Transaction';
                    Visible = false;
                }
                field(Deposits; Rec.Deposits)
                {
                    Caption = 'Member Deposit';
                }
                field("Fosa Balance"; Rec."Fosa Balance")
                {
                    Caption = 'Ordinary Savings';
                }
                field("School Fees Deposits"; Rec."School Fees Deposits")
                {
                    Caption = 'ESS Shares';
                }
                field(Chamaa; Rec.Chamaa) { Caption = 'Chamaa'; }
                field(Jibambe; Rec.Jibambe) { Caption = 'Jibambe'; }
                field(Wezesha; Rec.Wezesha) { Caption = 'Wezesha'; }
                field(FixedDep; Rec.FixedDep) { Caption = 'Fixed Deposits'; }
                field(Mdosi; Rec.Mdosi) { Caption = 'Mdosi Junior'; }
                field(PensionAkiba; Rec.PensionAkiba) { Caption = 'Pension Akiba'; }
                field(BusinessAct; Rec.BusinessAct) { Caption = 'Business Account'; }
                field("Last Transaction Date"; Rec."Last Transaction Date")
                {
                }
                field("Withdrawal Notice Date";Rec."Withdrawal Notice Date"){Caption = 'Exit Notice Date';}
                // field(TransactionType;TransactionType){}
                field(Activity;Rec.Activity)
                {
                    caption = 'Transaction Type';
                }
                field("Last Transact Date_Ordinary";Rec."Last Transact Date_Ordinary")
                {
                }
                field("Last Ord Transact Description";Rec."Last Ord Transact Description")
                {
                }
                field("Old Fosa No";Rec."Old Fosa No")
                {
                }
                field("Old Last Date";Rec."Old Last Date")
                {
                }
                field("Old Last Description";Rec."Old Last Description")
                {
                }

                
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate UFAA List")
            {
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                
                // PromotedIsBig = true;

                trigger OnAction()
                var
                    LineNo: Integer;
                begin
                    IF CONFIRM('Do you want to generate Ufaa list?', TRUE, FALSE) = TRUE THEN BEGIN
                        UFAABuffer.DELETEALL;
                        Gsetup.GET();
                        LineNo := 1;

                        Members.RESET;
                        Members.SETAUTOCALCFIELDS(Members."Last Deposit Date Deposit", Members."Current Shares",Members."Shares Retained", Members."FOSA  Account Bal",Members."School Fees Shares",Members."Chamaa Savings",Members."Jibambe Savings",Members."Wezesha Savings",Members."Fixed Deposit",Members."Mdosi Junior",Members."Fixed Deposit",Members."Business Account");
                        Members.SETFILTER(Members."Last Deposit Date Deposit", '<>%1', 0D);
                        Members.SETFILTER(Members."Current Shares", '>%1', 0);
                        IF Members.FindSet() THEN BEGIN
                            REPEAT
                                // cust.Reset();
                                // cust.SetRange("Old Ordinary Account NAV2016", );
                                // Members.CALCFIELDS(Members."Last Deposit Date Deposit");

                                IF (Members."Last Deposit Date Deposit" < CALCDATE(FORMAT('-') + FORMAT(Gsetup."UFAA Duration"), TODAY)) THEN BEGIN
                                // IF (Members."Last Deposit Date Deposit" < CALCDATE(FORMAT('-') + FORMAT(Gsetup."UFAA Duration"), TODAY)) THEN BEGIN
                                    // MESSAGE('No%1',Members."No.");
                                    UFAABuffer.INIT;
                                    UFAABuffer.No := LineNo;
                                    UFAABuffer."Member No" := Members."No.";
                                    UFAABuffer."Member PF" := Members."Payroll No";
                                    UFAABuffer."FOSA Account" := Members."FOSA Account";
                                    UFAABuffer."Members Name" := Members.Name;
                                    UFAABuffer."Mobile Number" := Members."Mobile Phone No";
                                    UFAABuffer.EmployerCode := Members."Employer Code";
                                    UFAABuffer.shares := Members."Shares Retained";
                                    UFAABuffer.Deposits := Members."Current Shares";
                                    UFAABuffer."Fosa Balance" := Members."FOSA  Account Bal";
                                    UFAABuffer."School Fees Deposits" := Members."School Fees Shares";
                                    UFAABuffer.Chamaa := Members."Chamaa Savings";
                                    UFAABuffer.Jibambe := Members."Jibambe Savings";
                                    UFAABuffer.Wezesha := Members."Fixed Deposit";
                                    UFAABuffer.Mdosi := Members."Mdosi Junior";
                                    UFAABuffer.PensionAkiba := Members."Pension Akiba";
                                    UFAABuffer.BusinessAct := Members."Business Account";
                                    UFAABuffer."Mobile Number" := Members."Mobile Phone No";
                                    UFAABuffer."ID Number" := Members."ID No."; 
                                    UFAABuffer."Last Transaction Date" := Members."Last Deposit Date Deposit";

                                    UFAABuffer."Old Fosa No":= Members."Old Ordinary Account NAV2016";
                                    if oldVend.Get(Members."Old Ordinary Account NAV2016") then begin
                                        UFAABuffer."Old Last Date":= oldVend."last Trans Date";
                                        UFAABuffer."Old Last Description":= oldVend."last Trans Text";
                                    end;


                                    Vend.Reset();
                                    Vend.SetRange(Vend."BOSA Account No", Members."No.");
                                    vend.SetRange(Vend."Account Type", '101');
                                    Vend.SetAutoCalcFields(Vend."Last Account Trans");
                                    Vend.SETFILTER(Vend."Last Account Trans", '<>%1', 0D);
                                    if Vend.Find('-') then begin
                                        repeat
                                        Vend.CALCFIELDS(Vend."Last Account Trans");
                                        If (Vend."Last Account Trans" < CALCDATE(FORMAT('-') + FORMAT(Gsetup."UFAA Duration"), TODAY)) THEN BEGIN
                                            UFAABuffer."Last Transaction Date_Shares":= Vend."Last Account Trans";
                                        end;                        
                                        until Vend.Next() = 0;
                                    end;

                                    Vend.Reset();
                                    vend.SetRange("BOSA Account No", Members."No.");
                                    vend.SetRange("Account Type", '103');
                                    Vend.SetAutoCalcFields("Last Account Trans");
                                    if Vend.Find('-') then begin
                                        repeat
                                            UFAABuffer."Last Transact Date_Ordinary" := Vend."Last Account Trans";
                                            UFAABuffer."Last Ord Transact Description":= Vend."Last Transaction";
                                        until vend.Next()=0;
                                    end;

                                    Notice.RESET;
                                    Notice.SetRange(Notice."Member No.", Members."No.");
                                    Notice.SETRANGE(Notice."Member No.", UFAABuffer."Member No");
                                    IF Notice.FindSet() THEN BEGIN
                                    repeat
                                        NoticeDate := 0D;
                                        NoticeDate := Notice."Exit Notice Date";
                                        UFAABuffer."Withdrawal Notice Date" := NoticeDate;
                                        until Notice.Next() = 0;
                                    END;

                                    // UFAABuffer."Withdrawal Notice Date" := NoticeDate;
                                    UFAABuffer.Source := UFAABuffer.Source::BOSA;
                                    // UFAABuffer."Last Transaction Date" := Members."Last Deposit Date Deposit";
                                    UFAABuffer.INSERT;
                                    LineNo := LineNo + 1;
                                END;
                            UNTIL Members.NEXT = 0;
                           
                            
                        END;


                    END;
                end;
            }
             action("UFAA List")
            {
                Visible = false;
                Image = ListPage;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Generate UFAA List';
                // RunObject = report "UFAA Procesing Report";

                trigger OnAction()
                begin

                end;
            }
            action("Ufaa Listing Report")
            {
                Caption = 'Ufaa Listing Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report 50058;

                trigger OnAction()
                var
                    LineNo: Integer;
                begin
                end;
            }
        }
    }

    var
        UFAABuffer: Record "UFAA Buffer";
        Members: Record Customer;
        cust: Record Customer;
        Vend: Record "Vendor";
        Gsetup: Record "Sacco General Set-Up";
        Notice: Record "Membership Exist";
        NoticeDate: Date;
        TransactionType: Enum FOSATransactionTypesEnum;
        oldVend: Record "Old Vendor Details";
}

