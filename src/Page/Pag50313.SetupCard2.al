Page 50313 "SetupCard 2"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Sms Setup 2";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User id"; Rec."User id")
                {
                    Editable = false;
                    Enabled = false;
                }
                field(Vendor; Rec.Vendor)
                {
                }
                field("Price per sms"; Rec."Price per sms")
                {
                    Enabled = false;
                }
                field("Sms balance"; Rec."Sms balance")
                {
                    Enabled = false;
                }
                field(Package; Rec.Package)
                {
                    Enabled = false;
                }
            }
            group("Set up")
            {
                field("Authenticatio Mode"; Rec."Authenticatio Mode")
                {
                }
                field("EndPoint link"; Rec."EndPoint link")
                {
                }
                field(Username; Rec.Username)
                {
                }
                field(Password; Rec.Password)
                {
                }
                field("Jwt Token"; Rec."Jwt Token")
                {
                }
                field("Api Key"; Rec."Api Key")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Test connection")
            {
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                   // smsManagement.SendSmsResponse('+254720667019', 'This is a test sms Live');
                  //  smsManagement.TestConnection(Rec);
                   // Rec.Modify;
                end;
            }


            action("Refresh balance")
            {
                Image = RefreshDiscount;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    smsManagement.RefreshBalance(Rec);
                    Rec.Modify;
                end;
            }

            action("Test SMS")
            {
                Image = RefreshDiscount;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //smsManagement.SendSmsResponse('+254718842259', 'This is a test sms Live');
                     
                end;
            }
        }
    }

    var
        smsManagement: Codeunit "Sms Management";
}



