page 51029 "AU SMS Messages"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "AU SMS Messages";
    SourceTableView = SORTING(date_created)
                      ORDER(Descending)
                      WHERE(msg=FILTER(<>'your PesaTele PIN is'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                
                field(msg_id;rec.msg_id)
                {
                }
                field(msg_category;rec.msg_category)
                {
                }
                field(msg_status_code;rec.msg_status_code)
                {
                }
                field(msg_status_description;rec.msg_status_description)
                {
                }
                field(sender;rec.sender)
                {
                }
                field(receiver;rec.receiver)
                {
                }
                field(msg;rec.msg)
                {
                }
                field(msg_type;rec.msg_type)
                {
                }
                field(msg_priority;rec.msg_priority)
                {
                }
                field("SMS Date";rec."SMS Date")
                {
                }
                field("Account To Charge";rec."Account To Charge")
                {
                }
                field("Insufficient Balance";rec."Insufficient Balance")
                {
                }
                field(Posted;rec.Posted)
                {
                }
                field(date_created;rec.date_created)
                {
                }
                field(Finalized;rec.Finalized)
                {
                }
                field("Charge Member";rec."Charge Member")
                {
                }
                field(msg_request_correlation_id;rec.msg_request_correlation_id)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Available Balance")
            {

                trigger OnAction()
                begin
                 //   MESSAGE('Available Balance: %1',SkyMbanking.GetAccountBalance(rec."Account To Charge"));
                end;
            }
        }
    }

    var
        //SkyMbanking: Codeunit //"51516167"
      //  "AU Mbanking";
}




