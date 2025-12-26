tableextension 50100 "Company Info GST Ext" extends "Company Information"
{
    fields
    {
        field(50100; "IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
        }
    }
}
