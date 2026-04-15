page 51119 "BD Partner Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "BD Partner";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Partner No."; Rec."Partner No.") { Editable = false; }
                field("Partner Name"; Rec."Partner Name") { }
                field("Partner Type"; Rec."Partner Type") { }
                field(Status; Rec.Status) { }
                field("Region Code"; Rec."Region Code") { }
                field("Assigned BD Officer"; Rec."Assigned BD Officer") {  }
            }

            group(Details)
            {
                field("Activation Date"; Rec."Activation Date") { }
                field("Last Activity Date"; Rec."Last Activity Date") { }
                field(Dormant; Rec.Dormant) { }
                field(Notes; Rec.Notes) { MultiLine = true; }
            }
            part(Control34; "BD Activity Log")
            {

                Caption = 'BD Activity Log';
                SubPageLink = "Partner No." = field("Partner No."), "BD Officer" = field("Assigned BD Officer");
            }
        }

        area(factboxes)
        {
            part(Opportunities; "BD Opportunity List")
            {
                SubPageLink = "Partner No." = field("Partner No.");
            }
        }
    }
}


