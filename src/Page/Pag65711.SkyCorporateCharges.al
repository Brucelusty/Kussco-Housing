page 65711 "Sky Corporate Charges"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "AU Safcom Corporate Charges";
   

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Minimum;rec.Minimum)
                {
                }
                field(Maximum;rec.Maximum)
                {
                }
                field(Charge;rec.Charge)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        Permission.RESET;
        Permission.SETRANGE("User ID",USERID);
        Permission.SETRANGE("Sky Mobile Setups",TRUE);
        IF NOT Permission.FINDFIRST THEN
          ERROR('You do not have the following permission: "Sky Mobile Setups"');
    end;

    var
        Permission: Record //"51516702"
        "AU Permissions";
}




