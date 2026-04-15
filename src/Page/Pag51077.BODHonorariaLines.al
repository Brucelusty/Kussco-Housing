page 51077 "BOD Honoraria Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "BOD Honoraria Lines";
    DeleteAllowed = false;
    InsertAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(BOD;Rec.BOD)
                {
                    ShowMandatory = True;
                }
                field("BOD Name";Rec."BOD Name")
                {
                }
                field("FOSA Account";Rec."FOSA Account")
                {
                }
                field(Amount;Rec.Amount)
                {
                    ShowMandatory = true;
                }
                field("PAYE Amount";Rec."PAYE Amount")
                {
                }
                field("Net Amount";Rec."Net Amount")
                {
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(UploadBoard)
            {
                Caption = 'Upload Board Members';
                Image = Loaners;
                
                trigger OnAction()
                begin
                    insider.Reset();
                    insider.SetRange("Position Held", insider."Position Held"::Director);
                    if insider.FindSet() then begin
                        repeat
                        rec.Init();
                        rec.BOD := insider."Member No";
                        rec.Validate(BOD);
                        if not rec.Insert() then rec.Modify();
                        until insider.Next()=0;
                    end;
                end;
            }
        }
    }

    var
    insider: Record InsiderLending;
    bodHonoraria: Record "BOD Honoraria";
    HonorariaLines: Record "BOD Honoraria Lines";
}


