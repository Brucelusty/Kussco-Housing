enum 50001 "ATM Transaction Types"
{
    Extensible = true;

    value(0; POS)
    {
    }
    value(1; "ATM Withdrawal") { }
    value(2; "ATM Balance") { }
    value(3; "ATM Ministatement") { }
    value(4; "POS Withdrawal") { }
    value(5; "POS Deposit") { }
    value(6; "POS Ministatement") { }
    value(7; "POS Balance") { }
    value(8; "VISA ATM Balance") { }
    value(9; "VISA ATM Withdrawal") { }
    value(10; "VISA ATM Ministatement") { }
    value(11; "VISA Purchase") { }
}
