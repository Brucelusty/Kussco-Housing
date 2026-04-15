page 65710 "AU Mobile Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "AU Mobile Setup";
   // "AU Mobile Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Disable; rec.Disable)
                {
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                }
                field("Vendor Commission Account"; rec."Vendor Commission Account")
                {
                }
                field("Vendor Charge Type"; rec."Vendor Charge Type")
                {
                }
                field("% Charge"; rec."% Charge")
                {
                }
                field("Vendor Commission"; rec."Vendor Commission")
                {
                }
                field("Vendor Staggered Code"; rec."Vendor Staggered Code")
                {
                }
                field("Charge From Sacco"; rec."Charge From Sacco")
                {
                }
                field("VAT %"; rec."VAT %")
                {
                }
                field("Sacco Fee Account"; rec."Sacco Fee Account")
                {
                }
                field("Sacco Charge Type"; rec."Sacco Charge Type")
                {
                }
                field("Sacco Fee"; rec."Sacco Fee")
                {
                }
                field("Sacco Staggered Code"; rec."Sacco Staggered Code")
                {
                }
                field("Safaricom Account"; rec."Safaricom Account")
                {
                }
                field("Bank Account"; rec."Bank Account")
                {
                }
                field("Network Service Provider"; rec."Network Service Provider")
                {
                }
                field("Safaricom Fee"; rec."Safaricom Fee")
                {
                    Visible = false;
                }
                field("3rd Party Charge Type"; rec."3rd Party Charge Type")
                {
                }
                field("3rd Party Staggered Code"; rec."3rd Party Staggered Code")
                {
                }
                field("Pre-Payment Account"; rec."Pre-Payment Account")
                {
                    Visible = false;
                }
                field("SMS Charge"; rec."SMS Charge")
                {
                }
                field("SMS Account"; rec."SMS Account")
                {
                }
                field("Transaction Limit"; rec."Transaction Limit")
                {
                }
                field("Non-Member Debit Account"; rec."Non-Member Debit Account")
                {
                }
                field("Daily Limit"; rec."Daily Limit")
                {
                }
                field("Weekly Limit"; rec."Weekly Limit")
                {
                }
                field("Monthly Limit"; rec."Monthly Limit")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update MPESA")
            {

                trigger OnAction()
                var
                    Acc: Code[20];
                    Phone: Code[20];
                begin

                    Acc := '5000017665000';
                    Phone := '+254722346758';

                    Savings.GET(Acc);
                    Savings.//"Transactional Mobile No" 
                    "Mobile Phone No." := Phone;
                    Savings.Status := Savings.Status::Closed;
                    Savings.Blocked := Savings.Blocked::" ";
                    Savings.MODIFY;

                    IF NOT Auth.GET(Phone) THEN BEGIN
                        Auth.INIT;
                        Auth."Mobile No." := Phone;
                        Auth."Account No." := Acc;
                        Auth.INSERT;
                    END;

                    Auth.RESET;
                    Auth.SETRANGE("Account No.", Savings."No.");
                    IF Auth.FINDFIRST THEN BEGIN
                        //Auth."Mobile No." := Savings."Transactional Mobile No";
                        //Auth.MODIFY;
                        Auth.RENAME(Savings.//"Transactional Mobile No"
                        "Mobile Phone No.");
                        // SkyMbanking.GenerateNewPin(COPYSTR(Savings.//"Transactional Mobile No"
                        // "Mobile Phone No.",2,12));
                    END;
                    MESSAGE('Updated');
                end;
            }
            action("Reset Pin")
            {

                trigger OnAction()
                begin

                    Savings.GET('5000000127000');
                    Savings.//"Transactional Mobile No" 
                    "Mobile Phone No." := '+254706405989';
                    Savings.Status := Savings.Status::Closed;
                    Savings.Blocked := Savings.Blocked::" ";
                    Savings.MODIFY;

                    Auth.RESET;
                    Auth.SETRANGE("Account No.", Savings."No.");
                    IF Auth.FINDFIRST THEN BEGIN
                        //Auth."Mobile No." := Savings."Transactional Mobile No";
                        //Auth.MODIFY;
                        Auth.RENAME(Savings.//"Transactional Mobile No"
                        "Mobile Phone No.");
                        Auth."Reset PIN" := TRUE;
                        Auth.MODIFY;

                        // SkyMbanking.PinReset;
                    END;
                    MESSAGE('Updated');
                end;
            }
            action("Activate Bosa")
            {

                trigger OnAction()
                begin

                    Cust.GET('0019558');
                    Cust.Status := Cust.Status::Archived;
                    Cust.MODIFY;

                    Savings.GET('5000000127000');
                    Savings."Registration Date" := 20010117D;
                    // Was 010117D
                    Savings.MODIFY;

                    MESSAGE('Updated');
                end;
            }
        }
    }

    trigger OnInit()
    begin
        // Permission.RESET;
        // Permission.SETRANGE("User ID",USERID);
        // Permission.SETRANGE("Sky Mobile Setups",TRUE);
        // IF NOT Permission.FINDFIRST THEN
        //   ERROR('You do not have the following permission: "Sky Mobile Setups"');
    end;

    var
        Savings: Record 23;
        Auth: Record //"51516709"
        "AU USSD Auth";
        //  SkyMbanking: Codeunit 
        //  "Sky Mbanking";
        Cust: Record Customer;
        Permission: Record //"51516702"
        "AU Permissions";
}




