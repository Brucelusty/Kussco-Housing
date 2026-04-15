page 50075 "Email Logs"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Email Logs";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name;Rec.Name)
                {
                }
                field(Subject;Rec.Subject)
                {
                }
                field(Body;Rec.Body)
                {
                }
                field("Sender E Mail";Rec."Sender E Mail")
                {
                }
                field("Recepient EMail";Rec."Recepient EMail")
                {
                }
                field("Date Sent";Rec."Date Sent")
                {
                }
                field(Status;Rec.Status)
                {
                }
            }
        }
    }
}


