page 51091 "Sacco Meetings No Allowance"
{
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Sacco Meetings";
    CardPageId = "Sacco Meetings Card";
    Editable = false;
    DeleteAllowed = true;
    SourceTableView = where(Uploaded = filter(true));
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Meeting No";Rec."Meeting No")
                {
                    Editable = false;
                }
                field("Meeting Type";Rec."Meeting Type")
                {
                }
                field("Meeting Description";Rec."Meeting Description")
                {
                }
                field("Special Meeting";Rec."Special Meeting")
                {
                }
                field("Meeting Date";Rec."Meeting Date")
                {
                }
                field(Uploaded;Rec.Uploaded)
                {
                }
                field(Posted;Rec.Posted)
                {
                }
            }
        }
        
    }
    
    actions
    {
        area(Reporting)
        {
            // action("Add New NoK")
            // {
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = UpdateXML;
                
            //     trigger OnAction()
            //     begin
            //         if cust.Get(Rec."Member No") then begin
            //             cust.CalcFields("No of Next of Kin");
            //             if cust."No of Next of Kin" < 1 then begin
            //                 newNoKTable.Reset();
            //                 newNoKTable.SetRange("Member No", Rec."Member No");
            //                 if newNoKTable.FindSet() then begin
            //                     nokNo:= 1;
            //                     repeat
            //                         nokTable.init;
            //                         nokTable."Account No" := cust."No.";
            //                         nokTable.Name := newNoKTable."NOK Name";
            //                         nokTable."Next Of Kin Type" := newNoKTable."Next Of Kin Type";
            //                         nokTable."Date of Birth" := newNoKTable."NOK DoB";
            //                         nokTable.Telephone := newNoKTable.Telephone;
            //                         nokTable."ID No." := newNoKTable."NOK ID No";
            //                         nokTable.Relationship := newNoKTable."NOK Relationship";
            //                         nokTable.Email := newNoKTable.Email;
            //                         nokTable."%Allocation" := newNoKTable."NOK Allocation";
            //                         nokTable."NoK No." := nokNo;
            //                         nokTable.Insert;
            //                         nokNo := nokNo +1;
            //                     until newNoKTable.Next() = 0;
            //                 end;
            //             end else if cust."No of Next of Kin" >= 1 then begin
            //                 nokTable.Reset();
            //                 nokTable.SetRange("Account No", Rec."Member No");
            //                 if nokTable.FindLast() then begin
            //                     newNokno:= nokTable."NoK No." + 1;
            //                 end;
            //                 newNoKTable.Reset();
            //                 newNoKTable.SetRange("Member No", Rec."Member No");
            //                 if newNoKTable.FindSet() then begin
            //                     nokNo:= newNokno;
            //                     repeat
            //                         nokTable.init;
            //                         nokTable."Account No" := cust."No.";
            //                         nokTable.Name := newNoKTable."NOK Name";
            //                         nokTable."Next Of Kin Type" := newNoKTable."Next Of Kin Type";
            //                         nokTable."Date of Birth" := newNoKTable."NOK DoB";
            //                         nokTable.Telephone := newNoKTable.Telephone;
            //                         nokTable."ID No." := newNoKTable."NOK ID No";
            //                         nokTable.Relationship := newNoKTable."NOK Relationship";
            //                         nokTable.Email := newNoKTable.Email;
            //                         nokTable."%Allocation" := newNoKTable."NOK Allocation";
            //                         nokTable."NoK No." := nokNo;
            //                         nokTable.Insert;
            //                         nokNo := nokNo +1;
            //                     until newNoKTable.Next() = 0;
            //                 end;
            //             end;
            //         end;
            //     end;
            // }

        }
    }
    var
    nokTable: Record "Members Next of Kin";
    // newNoKTable: Record "New Next of Kin";
    nokNo: Integer;
    newNokno: Integer;
    cust: Record Customer;
}


