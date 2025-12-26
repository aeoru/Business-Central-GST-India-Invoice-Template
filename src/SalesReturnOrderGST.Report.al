report 50104 "Sales Return Order GST India"
{
    Caption = 'Sales Return Order (GST India)';
    DefaultLayout = RDLC;
    RDLCLayout = 'src/SalesReturnOrderGST.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("No.") where("Document Type" = const("Return Order"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.";

            // ========== COMPANY INFORMATION ==========
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyGSTIN; CompanyInfo."GST Registration No.") { }
            column(CompanyPAN; CompanyInfo."P.A.N. No.") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyStateCode; CompanyInfo."State Code") { }
            column(CompanyStateName; CompanyStateName) { }

            // ========== RETURN ORDER DETAILS ==========
            column(ReturnOrderNo; "No.") { }
            column(DocumentDate; "Document Date") { }
            column(OrderDate; "Order Date") { }
            column(ExternalDocNo; "External Document No.") { }
            column(YourReference; "Your Reference") { }
            column(SalespersonCode; "Salesperson Code") { }
            column(SalespersonName; SalespersonName) { }

            // ========== CUSTOMER INFORMATION ==========
            column(CustomerNo; "Sell-to Customer No.") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(CustomerAddress; "Sell-to Address") { }
            column(CustomerAddress2; "Sell-to Address 2") { }
            column(CustomerCity; "Sell-to City") { }
            column(CustomerPostCode; "Sell-to Post Code") { }
            column(CustomerContact; "Sell-to Contact") { }
            column(CustomerGSTIN; CustomerGSTIN) { }
            column(CustomerStateCode; CustomerStateCode) { }
            column(CustomerStateName; CustomerStateName) { }

            // Bill-to
            column(BillToName; "Bill-to Name") { }
            column(BillToAddress; "Bill-to Address") { }
            column(BillToAddress2; "Bill-to Address 2") { }
            column(BillToCity; "Bill-to City") { }
            column(BillToPostCode; "Bill-to Post Code") { }
            column(BillToContact; "Bill-to Contact") { }

            // Ship-to (Return from)
            column(ShipToName; "Ship-to Name") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(ShipToContact; "Ship-to Contact") { }
            column(ShipToCountry; "Ship-to Country/Region Code") { }

            // ========== GST INFORMATION ==========
            column(PlaceOfSupply; PlaceOfSupply) { }
            column(IsInterState; IsInterState) { }
            column(ReverseCharge; ReverseCharge) { }

            // ========== CURRENCY & PAYMENT ==========
            column(CurrencyCode; CurrencyCode) { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }

            // ========== TOTALS ==========
            column(SubTotal; SubTotal) { }
            column(TotalDiscountAmount; TotalDiscountAmount) { }
            column(TotalTaxableAmount; TotalTaxableAmount) { }
            column(TotalCGSTAmount; TotalCGSTAmount) { }
            column(TotalSGSTAmount; TotalSGSTAmount) { }
            column(TotalIGSTAmount; TotalIGSTAmount) { }
            column(TotalGSTAmount; TotalGSTAmount) { }
            column(GrandTotal; GrandTotal) { }
            column(AmountInWords; AmountInWords) { }

            // ========== BANK DETAILS ==========
            column(BankName; BankName) { }
            column(BankAccountNo; BankAccountNo) { }
            column(BankBranchNo; BankBranchNo) { }
            column(BankIFSC; BankIFSC) { }
            column(BankSWIFT; BankSWIFT) { }

            // ========== LINE ITEMS ==========
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(LineNo; "Line No.") { }
                column(Type; Type) { }
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Description2; "Description 2") { }
                column(HSNSACCode; HSNSACCode) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(Quantity; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(LineDiscountPercent; "Line Discount %") { }
                column(LineDiscountAmount; "Line Discount Amount") { }
                column(LineAmount; "Line Amount") { }
                column(TaxableAmount; TaxableAmount) { }
                column(CGSTPercent; CGSTPercent) { }
                column(SGSTPercent; SGSTPercent) { }
                column(IGSTPercent; IGSTPercent) { }
                column(CGSTAmount; CGSTAmount) { }
                column(SGSTAmount; SGSTAmount) { }
                column(IGSTAmount; IGSTAmount) { }
                column(LineTotal; LineTotal) { }
                column(SerialNo; SerialNo) { }

                trigger OnAfterGetRecord()
                begin
                    if (Type = Type::" ") and ("No." = '') and (Description = '') then
                        CurrReport.Skip();

                    SerialNo += 1;

                    HSNSACCode := '';
                    if Type = Type::Item then
                        if Item.Get("No.") then
                            HSNSACCode := Item."HSN/SAC Code";

                    TaxableAmount := "Line Amount";
                    GSTPercent := "VAT %";
                    if GSTPercent = 0 then
                        GSTPercent := 18;

                    if IsInterState then begin
                        IGSTPercent := GSTPercent;
                        IGSTAmount := Round(TaxableAmount * IGSTPercent / 100, 0.01);
                        CGSTPercent := 0;
                        SGSTPercent := 0;
                        CGSTAmount := 0;
                        SGSTAmount := 0;
                    end else begin
                        CGSTPercent := GSTPercent / 2;
                        SGSTPercent := GSTPercent / 2;
                        CGSTAmount := Round(TaxableAmount * CGSTPercent / 100, 0.01);
                        SGSTAmount := Round(TaxableAmount * SGSTPercent / 100, 0.01);
                        IGSTPercent := 0;
                        IGSTAmount := 0;
                    end;

                    LineTotal := TaxableAmount + CGSTAmount + SGSTAmount + IGSTAmount;

                    SubTotal += "Line Amount" + "Line Discount Amount";
                    TotalDiscountAmount += "Line Discount Amount";
                    TotalTaxableAmount += TaxableAmount;
                    TotalCGSTAmount += CGSTAmount;
                    TotalSGSTAmount += SGSTAmount;
                    TotalIGSTAmount += IGSTAmount;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                Salesperson: Record "Salesperson/Purchaser";
                PaymentTerms: Record "Payment Terms";
                State: Record State;
            begin
                SubTotal := 0;
                TotalDiscountAmount := 0;
                TotalTaxableAmount := 0;
                TotalCGSTAmount := 0;
                TotalSGSTAmount := 0;
                TotalIGSTAmount := 0;
                SerialNo := 0;

                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                CompanyStateName := '';
                if State.Get(CompanyInfo."State Code") then
                    CompanyStateName := State.Description;

                CustomerGSTIN := '';
                CustomerStateCode := '';
                CustomerStateName := '';
                if Customer.Get("Sell-to Customer No.") then begin
                    CustomerGSTIN := Customer."GST Registration No.";
                    CustomerStateCode := Customer."State Code";
                    if State.Get(Customer."State Code") then
                        CustomerStateName := State.Description;
                end;

                PlaceOfSupply := CustomerStateName;
                IsInterState := CompanyInfo."State Code" <> CustomerStateCode;
                ReverseCharge := 'No';

                SalespersonName := '';
                if Salesperson.Get("Salesperson Code") then
                    SalespersonName := Salesperson.Name;

                PaymentTermsDesc := '';
                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTermsDesc := PaymentTerms.Description;

                if "Currency Code" = '' then
                    CurrencyCode := 'INR'
                else
                    CurrencyCode := "Currency Code";

                // Get Bank Details - default from Company Information
                BankName := CompanyInfo."Bank Name";
                BankAccountNo := CompanyInfo."Bank Account No.";
                BankBranchNo := CompanyInfo."Bank Branch No.";
                BankIFSC := CompanyInfo."IFSC Code";
                BankSWIFT := CompanyInfo."SWIFT Code";

                // Override with Bank Account if specified on the document
                if "Company Bank Account Code" <> '' then
                    if BankAccount.Get("Company Bank Account Code") then begin
                        BankName := BankAccount.Name;
                        BankAccountNo := BankAccount."Bank Account No.";
                        BankBranchNo := BankAccount."Bank Branch No.";
                        BankIFSC := BankAccount."IFSC Code";
                        BankSWIFT := BankAccount."SWIFT Code";
                    end;
            end;

            trigger OnPostDataItem()
            begin
                TotalGSTAmount := TotalCGSTAmount + TotalSGSTAmount + TotalIGSTAmount;
                GrandTotal := TotalTaxableAmount + TotalGSTAmount;
                AmountInWords := ConvertAmountToWords(GrandTotal);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowBankDetails; ShowBankDetails)
                    {
                        Caption = 'Show Bank Details';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    labels
    {
        ReturnOrderTitleLbl = 'SALES RETURN ORDER';
        ReturnOrderNoLbl = 'Return Order No.';
        ReturnDateLbl = 'Date';
        ReturnReasonLbl = 'Return Reason';
        ReturnFromLbl = 'Return From';
    }

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        BankAccount: Record "Bank Account";
        CompanyStateName: Text[100];
        CustomerGSTIN: Text[20];
        CustomerStateCode: Text[10];
        CustomerStateName: Text[100];
        PlaceOfSupply: Text[100];
        IsInterState: Boolean;
        ReverseCharge: Text[10];
        SalespersonName: Text[100];
        PaymentTermsDesc: Text[100];
        CurrencyCode: Code[10];
        HSNSACCode: Code[20];
        TaxableAmount: Decimal;
        GSTPercent: Decimal;
        CGSTPercent: Decimal;
        SGSTPercent: Decimal;
        IGSTPercent: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        LineTotal: Decimal;
        SerialNo: Integer;
        SubTotal: Decimal;
        TotalDiscountAmount: Decimal;
        TotalTaxableAmount: Decimal;
        TotalCGSTAmount: Decimal;
        TotalSGSTAmount: Decimal;
        TotalIGSTAmount: Decimal;
        TotalGSTAmount: Decimal;
        GrandTotal: Decimal;
        AmountInWords: Text[500];
        ShowBankDetails: Boolean;
        BankName: Text[100];
        BankAccountNo: Text[30];
        BankBranchNo: Text[20];
        BankIFSC: Code[20];
        BankSWIFT: Code[20];

    local procedure ConvertAmountToWords(Amount: Decimal): Text[500]
    var
        WholeAmount: Integer;
        DecimalPart: Integer;
        ResultText: Text[500];
    begin
        WholeAmount := Round(Amount, 1, '<');
        DecimalPart := Round((Amount - WholeAmount) * 100, 1);
        ResultText := 'Indian Rupees ' + ConvertNumberToWords(WholeAmount);
        if DecimalPart > 0 then
            ResultText += ' and ' + ConvertNumberToWords(DecimalPart) + ' Paise';
        ResultText += ' Only';
        exit(ResultText);
    end;

    local procedure ConvertNumberToWords(Number: Integer): Text[250]
    var
        Units: array[19] of Text[20];
        Tens: array[9] of Text[20];
        ResultText: Text[250];
        Crores, Lakhs, Thousands, Hundreds, Remainder: Integer;
    begin
        Units[1] := 'One'; Units[2] := 'Two'; Units[3] := 'Three'; Units[4] := 'Four';
        Units[5] := 'Five'; Units[6] := 'Six'; Units[7] := 'Seven'; Units[8] := 'Eight';
        Units[9] := 'Nine'; Units[10] := 'Ten'; Units[11] := 'Eleven'; Units[12] := 'Twelve';
        Units[13] := 'Thirteen'; Units[14] := 'Fourteen'; Units[15] := 'Fifteen';
        Units[16] := 'Sixteen'; Units[17] := 'Seventeen'; Units[18] := 'Eighteen';
        Units[19] := 'Nineteen';
        Tens[2] := 'Twenty'; Tens[3] := 'Thirty'; Tens[4] := 'Forty'; Tens[5] := 'Fifty';
        Tens[6] := 'Sixty'; Tens[7] := 'Seventy'; Tens[8] := 'Eighty'; Tens[9] := 'Ninety';

        if Number = 0 then exit('Zero');

        Crores := Number div 10000000;
        Number := Number mod 10000000;
        if Crores > 0 then ResultText += ConvertTwoDigits(Crores, Units, Tens) + ' Crore ';

        Lakhs := Number div 100000;
        Number := Number mod 100000;
        if Lakhs > 0 then ResultText += ConvertTwoDigits(Lakhs, Units, Tens) + ' Lakh ';

        Thousands := Number div 1000;
        Number := Number mod 1000;
        if Thousands > 0 then ResultText += ConvertTwoDigits(Thousands, Units, Tens) + ' Thousand ';

        Hundreds := Number div 100;
        Remainder := Number mod 100;
        if Hundreds > 0 then ResultText += Units[Hundreds] + ' Hundred ';

        if Remainder > 0 then ResultText += ConvertTwoDigits(Remainder, Units, Tens);

        exit(ResultText.Trim());
    end;

    local procedure ConvertTwoDigits(Number: Integer; Units: array[19] of Text[20]; Tens: array[9] of Text[20]): Text[50]
    var
        TensPart, UnitsPart: Integer;
    begin
        if Number < 20 then exit(Units[Number]);
        TensPart := Number div 10;
        UnitsPart := Number mod 10;
        if UnitsPart = 0 then exit(Tens[TensPart]) else exit(Tens[TensPart] + ' ' + Units[UnitsPart]);
    end;
}
