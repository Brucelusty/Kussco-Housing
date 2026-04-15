//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50611 "Group Members Applications"
{

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if "No" <> xRec."No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Group Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Group Name"; Code[30])
        {
        }
        field(3; "Member Name"; Code[30])
        {
        }
        field(4; "Member ID No"; Code[20])
        {
        }
        field(5; "Member Phone No"; Code[20])
        {
        }
        field(6; "Member Designation"; Code[20])
        {
        }
        field(7; "Account Category"; Option)
        {
            OptionCaption = ' ,Group, Chamaa, Co-operate';
            OptionMembers = " ",Group,Chamaa,"Co-operate";
        }

        field(8; "Name of the Group/Corporate"; Text[50])
        {
            trigger OnValidate()
            begin
                "Name of the Group/Corporate" := UpperCase("Name of the Group/Corporate");
                Name := "Name of the Group/Corporate";
            end;
        }
        field(9; Name; Text[50])
        {

        }
        field(10; Address; Text[50])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin
                Address := UpperCase(Address);
            end;
        }

        field(11; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; No, "Member Name", "Member ID No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        UserMgt: Codeunit "User Management";
        UserSetup: Record "User Setup";
    begin

        if "No" = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Group Application Nos");
            NoSeriesMgt.GetNextNo(SalesSetup."Group Application Nos");
        end;//
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";

}




