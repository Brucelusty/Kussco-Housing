page 51143 "Collateral Attachments"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Collateral Attachment";
    Caption = 'Collateral Attachments';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name") { }
                field("Uploaded By"; Rec."Uploaded By") { }
                field("Uploaded On"; Rec."Uploaded On") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UploadFile)
            {
                Caption = 'Upload';
                Image = Import;
                promoted = true;
                promotedCategory = Process;

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                begin
                    if UploadIntoStream('Select file', '', '', FileName, InStr) then begin
                        Rec.Init();
                        Rec."Collateral No." := LoanNo;
                        Rec."File Name" := FileName;
                        Rec."File Extension" := CopyStr(FileName, StrLen(FileName) - 3);
                        Rec."Uploaded By" := UserId;
                        Rec."Uploaded On" := CurrentDateTime;

                        Rec."Attachment".CreateOutStream(OutStr);
                        CopyStream(OutStr, InStr);

                        Rec.Insert();
                    end;
                end;
            }


            action(DownloadFile)
            {
                Caption = 'Download';
                Image = Export;
                promoted = true;
                promotedCategory = Process;
                trigger OnAction()
                var
                    InStr: InStream;
                    ToFile: Text;
                begin
                    Rec.CalcFields("Attachment");
                    Rec."Attachment".CreateInStream(InStr);

                    // 👇 Default filename comes from the record
                    ToFile := Rec."File Name";

                    DownloadFromStream(
                        InStr,
                        'Download Attachment',
                        '',
                        '',
                        ToFile
                    );
                end;
            }


        }
    }

    var
        LoanNo: Code[20];

    trigger OnOpenPage()
    begin
        Rec.SetRange("Collateral No.", LoanNo);
    end;

    procedure SetLoanNo(pLoanNo: Code[20])
    begin
        LoanNo := pLoanNo;
    end;
}


