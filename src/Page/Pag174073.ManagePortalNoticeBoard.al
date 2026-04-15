namespace TelepostSacco.TelepostSacco;
using System.Automation;
using System.Text;
using System.IO;

page 51171 "Manage Portal Notice Board"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Portal Notice Board";
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    
    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Upload Title";Rec."Upload Title")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    ShowMandatory = true;
                }
                field("Upload Description";Rec."Upload Description")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    ShowMandatory = true;
                }
                field("Upload Type";Rec."Upload Type")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Visibile To";Rec."Visibile To")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field(uploadFile;uploadFile)
                {
                    Caption = 'Upload File';
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    // Style = StrongAccent;
                    Editable = fileUp;

                    trigger OnValidate()
                    var
                    inStr: InStream;
                    outStr: OutStream;
                    files: Codeunit "File Management";
                    baseX64: Codeunit "Base64 Convert";
                    uploadMsg: Text;
                    fileName: Text[500];
                    exportFileName: Text[500];
                    expFileName: Text[500];
                    docFile: Text;
                    begin
                        if uploadFile then begin
                            Clear(outStr);
                            Clear(inStr);
                            uploadMsg := 'Select a file to upload...';
                            
                            if UploadIntoStream(uploadMsg, '', '', fileName, inStr) then begin
                                Message('File: %1', fileName);
                                Rec."File Name" := files.GetFileNameWithoutExtension(fileName);
                                Rec."File Type" := files.GetExtension(fileName);
                                Rec."File Upload".CreateOutStream(outStr);
                                CopyStream(outStr, inStr);
                                Rec.Modify;

                                if Rec."File Upload".HasValue then begin
                                    Message('File %1 has been uploaded successfully.', fileName);

                                    Rec.CalcFields("File Upload");
                                    Rec."File Upload".CreateInStream(inStr, TextEncoding::UTF8);

                                    expFileName := 'ExportedFile.%1';
                                    exportFileName := StrSubstNo(expFileName, Rec."File Type");
                                    DownloadFromStream(inStr, 'Export', '', '.'+Rec."File Type"+'', exportFileName);
                                end else begin
                                    Message('File not uploaded successfully.');
                                end;
                            end;
                        end;
                    end;
                }
                field("File Name";Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    Editable = false;
                    Style = Subordinate;
                }
                field("File Type";Rec."File Type")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    Editable = false;
                    Style = Strong;
                }
                field("Status";Rec."Upload Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
            }
            group("Upload Status")
            {
                field(Uploaded;Rec.Uploaded)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Uploaded By";Rec."Uploaded By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Upload Date";Rec."Upload Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Upload Time";Rec."Upload Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field(Removed;Rec.Removed)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Removed By";Rec."Removed By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Removal Date";Rec."Removal Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Removal Time";Rec."Removal Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Upload)
            {
                Caption = 'Upload Information';
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = not uploaded;

                trigger OnAction()
                begin
                    Rec.TestField("Upload Status", Rec."Upload Status"::Approved);

                    Rec.Uploaded := true;
                    Rec."Uploaded By" := UserId;
                    Rec."Upload Date" := Today;
                    Rec."Upload Time" := Time;
                    Message('Uploaded Successfully');
                end;
            }
            action(Delete)
            {
                Caption = 'Delete Information';
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = not removed;

                trigger OnAction()
                begin
                    Rec.TestField("Upload Status", Rec."Upload Status"::Approved);
                    Rec.TestField(Uploaded, true);
                    
                    Rec.Removed := true;
                    Rec."Removed By" := UserId;
                    Rec."Removal Date" := Today;
                    Rec."Removal Time" := Time;
                    Message('Upload Removed From Members'' Portal Successfully.');
                end;
            }
        }
        area(Navigation)
        {
            action(Approve)
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec."Upload Status" := Rec."Upload Status"::Approved;
                    Rec.Modify;
                    
                    Message('The record has been approved.');
                end;
            }
            action(Cancel)
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec."Upload Status" := Rec."Upload Status"::New;
                    Rec.Modify;

                    Message('Approval request canceled successfully');
                end;
            }
            action(Approvals)
            {
                Caption = 'Approval Entries';
                Image = ApprovalSetup;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Message('No Approval Entries');
                end;
            }
        }
    }
    
    var
    uploaded: Boolean;
    removed: Boolean;
    uploadFile: Boolean;
    fileUp: Boolean;
    approvaDoc: Enum "Approval Document Type";
    approvalEntries: Page "Approval Entries";
    approvals: Codeunit WorkflowIntegration;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        uploaded := false;
        removed := false;
        fileUp := false;

        if Rec."Upload Type" = Rec."Upload Type"::"Upload File" then begin
            fileUp := true;
        end;

        if Rec.Uploaded = true then begin
            uploaded := true;
        end;

        if Rec.Removed = true then begin
            removed := true;
        end;
    end;
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        uploaded := false;
        removed := false;
        fileUp := false;

        if Rec."Upload Type" = Rec."Upload Type"::"Upload File" then begin
            fileUp := true;
        end;

        if Rec.Uploaded = true then begin
            uploaded := true;
        end;

        if Rec.Removed = true then begin
            removed := true;
        end;
    end;

}


