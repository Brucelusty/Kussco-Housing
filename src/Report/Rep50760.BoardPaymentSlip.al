report 50760 "Board Payment Slip"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = BoardMeetingPay;

    dataset
    {
        dataitem("Sacco Meetings"; "Sacco Meetings")
        {
            RequestFilterFields = "Meeting No", "Meeting Date";
            DataItemTableView = where("Meeting Type" = filter("Board Meeting"));
            column(Meeting_No; "Meeting No")
            { }
            column(Committee_No; "Committee No")
            { }
            column(Committee_Name; "Committee Name")
            { }
            column(Meeting_Date; "Meeting Date")
            { }
            column(totalGrossSitting; totalGrossSitting)
            { }
            column(totalGrossTransport; totalGrossTransport)
            { }
            column(totalHousing; totalHousing)
            { }
            column(totalPAYESitting; totalPAYESitting)
            { }
            column(totalPAYETransport; totalPAYETransport)
            { }
            // column()
            // {}
            column(companyInfo_Name; companyInfo.Name)
            { }
            column(companyInfo_Pic; companyInfo.Picture)
            { }
            dataitem("Meeting Lines"; "Meeting Lines")
            {
                DataItemLink = "Doc No." = field("Meeting No");
                DataItemTableView = where("Member Present" = filter(true));

                column(Member_No; "Member No")
                { }
                column(Member_Name; "Member Name")
                { }
                column(Allowance; Allowance)
                { }
                column(NetSitting; NetSitting)
                { }
                column(NetTransport; NetTransport)
                { }
                // column()
                // {}

                trigger OnAfterGetRecord()
                begin
                    NetSitting := 0;
                    NetTransport := 0;

                    fundsSetup.Get();

                    committees.Reset();
                    committees.SetRange("Committee", "Sacco Meetings"."Committee No");
                    committees.SetRange("Member No", "Meeting Lines"."Member No");
                    if committees.Find('-') then begin
                        if "Sacco Meetings"."Special Meeting" then begin
                            NetSitting := committees."Sitting Allowance Special" - Round((committees."Sitting Allowance Special" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                            NetTransport := committees."Transport Allowance Special" - Round((committees."Transport Allowance Special" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                        end else begin
                            NetSitting := committees."Sitting Allowance" - Round((committees."Sitting Allowance" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                            NetTransport := committees."Transport Allowance" - Round((committees."Transport Allowance" * (fundsSetup."PAYE Percentage" / 100)), 1, '=');
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                totalGrossSitting := 0;
                totalGrossTransport := 0;
                totalPAYESitting := 0;
                totalPAYETransport := 0;
                totalHousing := 0;

                fundsSetup.Get();
                meetingAttendees.Reset();
                meetingAttendees.SetRange("Doc No.", "Sacco Meetings"."Meeting No");
                meetingAttendees.SetRange("Member Present", true);
                if meetingAttendees.Find('-') then begin
                    repeat
                        committees.Reset();
                        committees.SetRange("Committee", "Sacco Meetings"."Committee No");
                        committees.SetRange("Member No", meetingAttendees."Member No");
                        if committees.Find('-') then begin
                            if "Sacco Meetings"."Special Meeting" then begin
                                totalGrossTransport := committees."Transport Allowance Special" + totalGrossTransport;
                                totalGrossSitting := committees."Sitting Allowance Special" + totalGrossSitting;
                                totalPAYESitting := Round((committees."Sitting Allowance Special" * (fundsSetup."PAYE Percentage" / 100)), 1, '=') + totalPAYESitting;
                                totalPAYETransport := Round((committees."Transport Allowance Special" * (fundsSetup."PAYE Percentage" / 100)), 1, '=') + totalPAYETransport;
                                totalHousing := Round(((committees."Sitting Allowance Special" + committees."Transport Allowance Special") * 0.03), 0.01, '=') + totalHousing;
                            end else begin
                                totalGrossTransport := committees."Transport Allowance" + totalGrossTransport;
                                totalGrossSitting := committees."Sitting Allowance" + totalGrossSitting;
                                totalPAYESitting := Round((committees."Sitting Allowance" * (fundsSetup."PAYE Percentage" / 100)), 1, '=') + totalPAYESitting;
                                totalPAYETransport := Round((committees."Transport Allowance" * (fundsSetup."PAYE Percentage" / 100)), 1, '=') + totalPAYETransport;
                                totalHousing := Round(((committees."Sitting Allowance" + committees."Transport Allowance") * 0.03), 0.01, '=') + totalHousing;
                            end;
                        end;
                    until meetingAttendees.Next() = 0;
                end;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {

                //     }
                // }
            }
        }
    }

    rendering
    {
        layout(BoardMeetingPay)
        {
            Type = RDLC;
            LayoutFile = 'Layouts\BoardMeetingPayment.rdlc';
        }
    }

    trigger
    OnInitReport()
    begin
        companyInfo.Get();
        companyInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        totalGrossSitting: Decimal;
        totalGrossTransport: Decimal;
        NetSitting: Decimal;
        NetTransport: Decimal;
        totalPAYESitting: Decimal;
        totalPAYETransport: Decimal;
        totalHousing: Decimal;
        companyInfo: Record "Company Information";
        committees: Record "Sacco Committee Members";
        fundsSetup: Record "Funds General Setup";
        meetingAttendees: Record "Meeting Lines";
}


