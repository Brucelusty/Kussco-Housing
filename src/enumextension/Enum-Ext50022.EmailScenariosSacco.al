namespace TelepostSacco.TelepostSacco;

using System.Email;

enumextension 50022 "Email Scenarios Sacco" extends "Email Scenario"
{
    
    value(200; "Demand Notice")
    {
        Caption = 'Defaulter Notice';
    }
    value(201; Payslip)
    {
        Caption = 'Staff Payslip';
    }
}
