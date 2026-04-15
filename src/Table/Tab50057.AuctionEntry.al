table 50057 "Auction Entry"
{
    fields
    {
        field(1; "Auction No."; Integer) { AutoIncrement=true;Editable = false; }
        field(2; "Case No."; Code[20]) { }
        field(3; "Auctioneer"; Text[100]) { }
        field(4; "Auction Date"; Date) { }
        field(5; "Highest Bid"; Decimal) {  }

        field(6; "Status"; Enum "Auction Status")
        {
            // Editable = false;
            trigger OnValidate()
            var
                CaseRec: Record "Defaulter Case";
            begin
                if Status = Status::Successful then begin
                    CaseRec.Get("Case No.");
                    CaseRec."Recovery Stage" := CaseRec."Recovery Stage"::Auction;
                    CaseRec.Modify;
                end;

                if Status = Status::Unsuccessful then begin
                    CaseRec.Get("Case No.");
                    CaseRec."Recovery Stage" := CaseRec."Recovery Stage"::"Repeat Auction";
                    CaseRec.Modify;
                end;
            end;
        }


    }
        keys
    {
        key(Key1; "Auction No.", "Case No.", Auctioneer, "Auction Date")
        {
            Clustered = true;
        }
    }
}
