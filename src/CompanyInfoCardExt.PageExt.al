pageextension 50100 "Company Info Card GST Ext" extends "Company Information"
{
    layout
    {
        addafter("Bank Branch No.")
        {
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = All;
                Caption = 'IFSC Code';
                ToolTip = 'Specifies the Indian Financial System Code (IFSC) for the company bank account.';
            }
        }
    }
}
