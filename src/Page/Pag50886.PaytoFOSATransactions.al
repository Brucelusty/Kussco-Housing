page 50886 "PaytoFOSA Transactions"
{
    ApplicationArea = All;
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Lists;
    SourceTable ="Paybill Transactions";
    SourceTableView = where(Status = filter(<> Posted), MSIDN = filter('0124A062563600'));

    layout
    {
        area(Content)
        {
            repeater(Paybill)
            {
                field(TransID;Rec.TransID)
                {
                    // Editable=false;
                    ShowMandatory = true;
                    
                }
                field(TransactionType;Rec.TransactionType)
                {
                    Editable=false;
                    
                }
                field(TransTime;Rec.TransTime)
                {
                    Editable=false;
                    
                }
                field("Posted Date";Rec."Posted Date")
                {
                    Editable=false;
                }
                field("Posted Time";Rec."Posted Time")
                {
                    Editable=false;
                }
                field(TransAmount;Rec.TransAmount)
                {
                    Editable=false;
                    
                }
                field(BusinessShortCode;Rec.BusinessShortCode)
                {
                    Editable=false;
                    
                }
                field(BillRefNumber;Rec.BillRefNumber)
                {
                }

                field(InvoiceNumber;Rec.InvoiceNumber)
                {
                    Editable=false;
                    
                }
                field(OrgAccountBalance;Rec.OrgAccountBalance)
                {
                    Editable=false;
                    
                }
                field(ThirdPartyTransID;Rec.ThirdPartyTransID)
                {
                    Editable=false;
                    
                }
                field(MSIDN;Rec.MSIDN)
                {
                    Editable=false;
                    
                }
                field(Status;Rec.Status)
                {
                    Editable=false;
                    
                }
                field(FirstName;Rec.FirstName)
                {
                    Editable=false;
                    
                }
                field(TransType;Rec.TransType)
                {
                    Editable=false;
                    
                }
                field(IDNo;Rec.IDNo)
                {
                    // Editable=false;
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(PostPending)
            {
                Image = PostedDeposit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                
                trigger OnAction();
                begin
                    if users.Get(UserId) then begin
                        if users."Post Pending ABC" = true then begin
                            pendingPost.RunPostPendingPaybill(Rec.TransID);
                        end else Error('%1 lacks rights post this transaction.', UserId);
                    end;
                end;
            }
            action(UpdateReff)
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                
                trigger OnAction()
                begin
                    if users.Get(UserId) then begin
                        if users."Post Pending ABC" = true then begin
                            paybillTrans.Reset();
                            paybillTrans.SetRange(TransID, Rec.TransID);
                            if paybillTrans.Find('-') then begin
                                Report.Run(50091, true, false, paybillTrans);
                            end;
                        end else Error('%1 lacks rights post this transaction.', UserId);
                    end;
                end;
            }
            action(Test)
            {
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                
                trigger OnAction()
                var
                newID: Code[20];
                finalID: Code[20];
                finalIDII: Code[20];
                begin
                    newID := '';
                    finalID := '';
                    newID := CopyStr(Rec.BillRefNumber, 1, 8);
                    finalID := CopyStr(newID, 8);
                    finalIDII := CopyStr(newID, 1, 7);
                    if CopyStr(newID, 8) = format(0) then begin
                        finalIDII := CopyStr(newID, 1, 7);
                    end;
                    
                    Message('The last figure is: %1 and the value less the last figure is %2 with the final value is %3.', finalID, newID, finalIDII);
                end;
            }
        }
    }

    var
    pendingPost: Codeunit "Post Pending Paybill Trans";
    users: Record "User Setup";
    paybillTrans: Record "Paybill Transactions";
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        postedDate: Date;
        postedTime: Time;
    begin

        postedDate := DT2Date(Rec.TransTime);
        postedTime := DT2Time(Rec.TransTime);
        Rec."Posted Date" := postedDate;
        Rec."Posted Time" := postedTime;
    end;
}


