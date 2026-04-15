//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50058 "Member BackID-App"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            field("ID Back"; Rec."ID Back")
            {
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the ID Front.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable and (HideActions = false);

                trigger OnAction()
                begin
                    TakeNewPicture;
                end;
            }
            action(ImportPicture)
            {
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    ImportFromDevice;
                end;
            }
            action(ExportFile)
            {
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';
                Visible = (CameraAvailable = false) and (HideActions = false);

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    //TESTFIELD(Description);

/*                     NameValueBuffer.DeleteAll;
                    ExportPath := TemporaryPath + Rec."No." + Format(Rec."ID Back".MediaId);
                    Rec."ID Back".ExportFile(ExportPath);
                    FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
                    TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
                    TempNameValueBuffer.FindFirst;
                    ToFile := StrSubstNo('%1 %2.jpg', Rec."No.", ConvertStr(Rec."No.", '"/\', '___'));
                    Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then; */
                end;
            }
            action(DeletePicture)
            {
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    DeleteItemPicture;
                end;
            }
        }
    }

    var
        // [RunOnClient]
        // [WithEvents]

        Camera: Codeunit Camera;

        MustSpecifyDescriptionErr: Label 'You must add a description to the item before you can import a picture.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;

        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';

    procedure TakeNewPicture()
    var

    begin
        Rec.Find;
        Rec.TestField("No.");
        Rec.Find();
        Rec.TestField("No.");


        OnAfterTakeNewPicture(Rec, DoTakeNewPicture());
    end;

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        Rec.Find;
        Rec.TestField("No.");
        //TESTFIELD(Description);

/*         if Rec."ID Back".Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Rec."ID Back");
        Rec."ID Back".ImportFile(FileName, ClientFileName);
        if not Rec.Insert(true) then
            Rec.Modify(true);

        if FileManagement.DeleteServerFile(FileName) then; */
    end;

    local procedure SetEditableOnPictureActions()
    begin
        //DeleteExportEnabled := Signature.Count <> 0;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;


    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec."ID Back");
        Rec.Modify(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTakeNewPicture(var Item: Record "Membership Applications"; IsPictureAdded: Boolean)
    begin
    end;

    local procedure DoTakeNewPicture(): Boolean
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        if Rec."ID Back".Count() > 0 then
            if not Confirm(OverrideImageQst) then
                exit(false);

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec."ID Back");
            Rec."ID Back".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;

        exit(false);
    end;
}


