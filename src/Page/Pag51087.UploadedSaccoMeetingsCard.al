page 51087 "Uploaded Sacco Meetings Card"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "Sacco Meetings";
    Editable = false;
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            Group(General)
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
                field("Meeting Date";Rec."Meeting Date")
                {
                }
            }
            part(attendees; "Sacco Meetings Lines")
            {
                Caption = 'Meeting Attendees';
                Editable = false;
                SubPageLink = "Doc No." = field("Meeting No");
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Sacco Meetings"), "No." = field("Meeting No");
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Payment)
            {
                Ellipsis = True;
                Caption = 'Process Payment';
                Image = PostDocument;
                ToolTip = 'Process Allowances to attendees'' accounts.';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction() begin
                    if Confirm('Do you wish to proceed with allowance payment?', true) = false then exit;

                    lineNo:= 0;
                    docNo:= Rec."Meeting No";
                    batchName:= 'PAYMENTS';
                    batchTemplate:= 'MEETING ALLOWANCE';

                    genJournalTemp.Reset();
                    genJournalTemp.SetRange("Journal Batch Name", batchName);
                    genJournalTemp.SetRange("Journal Template Name", batchTemplate);
                    if genJournalTemp.FindSet() then begin
                        genJournalTemp.DeleteAll();
                    end;

                    genBatches.Reset();
                    genBatches.SetRange(Name, batchName);
                    genBatches.SetRange("Journal Template Name", batchTemplate);
                    if genBatches.Find('-') = false then begin
                        genBatches.Init();
                        genBatches.Name := batchName;
                        genBatches."Journal Template Name" := batchTemplate;
                        genBatches.Description := 'Meeting Allowances';
                        genBatches.Insert();
                    end;

                    meetingAttendees.Reset();
                    meetingAttendees.SetRange("Doc No.", rec."Meeting No");
                    meetingAttendees.SetRange("Member Present", true);
                    if meetingAttendees.FindSet() then begin
                        repeat

                        fosaAcc:= AUFactory.FnGetAccountNumber('103', meetingAttendees."Member No");
                        lineNo := lineNo + 1000;
                        AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournalTemp."Transaction Type"::" ", genJournalTemp."Account Type"::"G/L Account", 'SRC GL Account',
                                                        Today, meetingAttendees.Allowance, '', Rec."Meeting No", Format(Rec."Meeting Type") +' Meeting-'+ Format(Rec."Meeting Date"), '', genJournalTemp."Application Source"::CBS);
                        
                        lineNo:= lineNo + 1000;
                        AUFactory.FnCreateGnlJournalLine(batchTemplate, batchName, docNo, lineNo, genJournalTemp."Transaction Type"::" ", genJournalTemp."Account Type"::Vendor, fosaAcc,
                                                        Today, (meetingAttendees.Allowance)*-1, '', Rec."Meeting No", Format(Rec."Meeting Type") +' Meeting-'+ Format(Rec."Meeting Date"), '', genJournalTemp."Application Source"::CBS);
                        
                        until meetingAttendees.Next() = 0;
                    end;

                    rec.Posted:= true;
                    rec."Posted By":= UserId;
                    rec."Posted On":= Today;
                    rec.modify;
                end;
            }
        }
    }

    var
    lineNo: Integer;
    batchName: Code[20];
    batchTemplate: Code[20];
    docNo: Code[20];
    fosaAcc: Code[20];
    AUFactory: Codeunit "Au Factory";
    saccoGen: Record "Sacco General Set-Up";
    cust: Record Customer;
    vend: Record Vendor;
    genBatches: Record "Gen. Journal Batch";
    genJournalTemp: Record "Gen. Journal Line";
    saccoMeeting: Record "Sacco Meetings";
    committees: Record "Sacco Committees";
    meetingAttendees: Record "Meeting Lines";


}


