//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50613 "Cheque Transactions Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Truncation Buffer";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SerialId; Rec.SerialId)
                {
                }
                field(RCODE; Rec.RCODE)
                {
                }
                field(VTYPE; Rec.VTYPE)
                {
                }
                field(AMOUNT; Rec.AMOUNT)
                {
                }
                field(ENTRYMODE; Rec.ENTRYMODE)
                {
                }
                field(CURRENCYCODE; Rec.CURRENCYCODE)
                {
                }
                field(DESTBANK; Rec.DESTBANK)
                {
                }
                field(DESTBRANCH; Rec.DESTBRANCH)
                {
                }
                field(DESTACC; Rec.DESTACC)
                {
                }
                field(CHQDGT; Rec.CHQDGT)
                {
                }
                field(PBANK; Rec.PBANK)
                {
                }
                field(PBRANCH; Rec.PBRANCH)
                {
                }
                field(COLLACC; Rec.COLLACC)
                {
                }
                field(MemberNo; Rec.MemberNo)
                {
                }
                field(SNO; Rec.SNO)
                {
                }
                field(FrontBWImage; Rec.FrontBWImage)
                {
                }
                field(FrontGrayScaleImage; Rec.FrontGrayScaleImage)
                {
                }
                field(RearImage; Rec.RearImage)
                {
                }
                field(IsFCY; Rec.IsFCY)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(UploadFile)
            {

                trigger OnAction()
                var
                    DestinationFile: Text[100];
                begin
                    //  DestinationFile := FileMgt.OpenFileDialog('Family Cheque file', '*.J70', UserId + '(*.*)|(*.J70)');

                    Message(DestinationFile);
                    //UPLOADINTOSTREAM('Import','','All Files (*.*)|*.*',DestinationFile,USERID+'(*.*)|(*.J70)');
                end;
            }
        }
    }

    var
        FileMgt: Codeunit "File Management";
}






