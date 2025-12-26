report 50100 "Sales Quote GST India"
{
    Caption = 'Sales Quote (GST India)';
    DefaultLayout = RDLC;
    RDLCLayout = 'src/SalesQuoteGST.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("No.") where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.";

            // Company Information
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyCountry; CompanyInfo."Country/Region Code") { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyHomePage; CompanyInfo."Home Page") { }
            column(CompanyGSTIN; CompanyInfo."GST Registration No.") { }
            column(CompanyPAN; CompanyInfo."P.A.N. No.") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyStateCode; CompanyInfo."State Code") { }

            // Document Information
            column(DocumentNo; "No.") { }
            column(DocumentDate; "Document Date") { }
            column(QuoteValidDate; "Quote Valid Until Date") { }
            column(ExternalDocNo; "External Document No.") { }
            column(YourReference; "Your Reference") { }
            column(SalespersonCode; "Salesperson Code") { }
            column(SalespersonName; SalespersonName) { }

            // Bill-to Customer
            column(BillToCustomerNo; "Bill-to Customer No.") { }
            column(BillToName; "Bill-to Name") { }
            column(BillToAddress; "Bill-to Address") { }
            column(BillToAddress2; "Bill-to Address 2") { }
            column(BillToCity; "Bill-to City") { }
            column(BillToPostCode; "Bill-to Post Code") { }
            column(BillToCountry; "Bill-to Country/Region Code") { }
            column(BillToContact; "Bill-to Contact") { }
            column(BillToGSTIN; BillToGSTIN) { }
            column(BillToStateCode; BillToStateCode) { }

            // Ship-to Address
            column(ShipToCode; "Ship-to Code") { }
            column(ShipToName; "Ship-to Name") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(ShipToCountry; "Ship-to Country/Region Code") { }
            column(ShipToContact; "Ship-to Contact") { }
            column(ShipToGSTIN; ShipToGSTIN) { }
            column(ShipToStateCode; ShipToStateCode) { }

            // Currency and Payment
            column(CurrencyCode; CurrencyCode) { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(ShipmentMethodCode; "Shipment Method Code") { }

            // Totals
            column(TotalAmount; TotalAmount) { }
            column(TotalAmountInclVAT; TotalAmountInclVAT) { }
            column(TotalTaxAmount; TotalTaxAmount) { }
            column(TotalCGSTAmount; TotalCGSTAmount) { }
            column(TotalSGSTAmount; TotalSGSTAmount) { }
            column(TotalIGSTAmount; TotalIGSTAmount) { }
            column(TotalDiscountAmount; TotalDiscountAmount) { }
            column(AmountInWords; AmountInWords) { }

            // Place of Supply
            column(PlaceOfSupply; PlaceOfSupply) { }
            column(IsInterState; IsInterState) { }


            // Bank Details
            column(BankName; BankName) { }
            column(BankAccountNo; BankAccountNo) { }
            column(BankBranchNo; BankBranchNo) { }
            column(BankIFSC; BankIFSC) { }
            column(BankSWIFT; BankSWIFT) { }
            column(BankIBAN; BankIBAN) { }

            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(LineNo; "Line No.") { }
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
                column(TaxableAmount; LineAmount) { }
                column(VATPercent; "VAT %") { }
                column(CGSTPercent; CGSTPercent) { }
                column(SGSTPercent; SGSTPercent) { }
                column(IGSTPercent; IGSTPercent) { }
                column(CGSTAmount; CGSTAmount) { }
                column(SGSTAmount; SGSTAmount) { }
                column(IGSTAmount; IGSTAmount) { }
                column(AmountIncludingVAT; "Amount Including VAT") { }
                column(SerialNo; SerialNo) { }

                trigger OnAfterGetRecord()
                begin
                    SerialNo += 1;

                    // Get HSN/SAC Code from Item
                    if Type = Type::Item then begin
                        if Item.Get("No.") then
                            HSNSACCode := Item."HSN/SAC Code";
                    end;

                    // Calculate GST amounts based on inter-state or intra-state
                    LineAmount := "Line Amount";
                    if IsInterState then begin
                        IGSTPercent := "VAT %";
                        IGSTAmount := LineAmount * IGSTPercent / 100;
                        CGSTPercent := 0;
                        SGSTPercent := 0;
                        CGSTAmount := 0;
                        SGSTAmount := 0;
                    end else begin
                        CGSTPercent := "VAT %" / 2;
                        SGSTPercent := "VAT %" / 2;
                        CGSTAmount := LineAmount * CGSTPercent / 100;
                        SGSTAmount := LineAmount * SGSTPercent / 100;
                        IGSTPercent := 0;
                        IGSTAmount := 0;
                    end;

                    // Accumulate totals
                    TotalAmount += LineAmount;
                    TotalDiscountAmount += "Line Discount Amount";
                    TotalCGSTAmount += CGSTAmount;
                    TotalSGSTAmount += SGSTAmount;
                    TotalIGSTAmount += IGSTAmount;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                ShipToAddress: Record "Ship-to Address";
                Salesperson: Record "Salesperson/Purchaser";
                PaymentTerms: Record "Payment Terms";
            begin
                // Reset totals for each document
                TotalAmount := 0;
                TotalAmountInclVAT := 0;
                TotalTaxAmount := 0;
                TotalCGSTAmount := 0;
                TotalSGSTAmount := 0;
                TotalIGSTAmount := 0;
                TotalDiscountAmount := 0;
                SerialNo := 0;

                // Get Company Information
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                // Get Customer GSTIN and State
                if Customer.Get("Bill-to Customer No.") then begin
                    BillToGSTIN := Customer."GST Registration No.";
                    BillToStateCode := Customer."State Code";
                end;

                // Get Ship-to GSTIN and State
                if "Ship-to Code" <> '' then begin
                    if ShipToAddress.Get("Sell-to Customer No.", "Ship-to Code") then begin
                        ShipToGSTIN := ShipToAddress."GST Registration No.";
                        ShipToStateCode := ShipToAddress.State;
                    end;
                end else begin
                    ShipToGSTIN := BillToGSTIN;
                    ShipToStateCode := BillToStateCode;
                end;

                // Determine if Inter-State or Intra-State
                PlaceOfSupply := ShipToStateCode;
                IsInterState := CompanyInfo."State Code" <> ShipToStateCode;

                // Get Salesperson Name
                if Salesperson.Get("Salesperson Code") then
                    SalespersonName := Salesperson.Name;

                // Get Payment Terms Description
                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTermsDesc := PaymentTerms.Description;

                // Currency Code
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
                BankIBAN := CompanyInfo.IBAN;

                // Override with Bank Account if specified on the document
                if "Company Bank Account Code" <> '' then
                    if BankAccount.Get("Company Bank Account Code") then begin
                        BankName := BankAccount.Name;
                        BankAccountNo := BankAccount."Bank Account No.";
                        BankBranchNo := BankAccount."Bank Branch No.";
                        BankIFSC := BankAccount."IFSC Code";
                        BankSWIFT := BankAccount."SWIFT Code";
                        BankIBAN := BankAccount.IBAN;
                    end;
            end;

            trigger OnPostDataItem()
            begin
                TotalTaxAmount := TotalCGSTAmount + TotalSGSTAmount + TotalIGSTAmount;
                TotalAmountInclVAT := TotalAmount + TotalTaxAmount;
                AmountInWords := ConvertAmountToWords(TotalAmountInclVAT);
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

                    field(ShowTermsConditions; ShowTermsConditions)
                    {
                        Caption = 'Show Terms & Conditions';
                        ApplicationArea = All;
                    }
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
        QuoteTitleLbl = 'QUOTATION', Locked = true;
        QuoteNoLbl = 'Quote No.';
        DateLbl = 'Date';
        ValidUntilLbl = 'Valid Until';
        BillToLbl = 'Bill To';
        ShipToLbl = 'Ship To';
        GSTINLbl = 'GSTIN';
        PANLbl = 'PAN';
        HSNSACLbl = 'HSN/SAC';
        CGSTLbl = 'CGST';
        SGSTLbl = 'SGST';
        IGSTLbl = 'IGST';
        PlaceOfSupplyLbl = 'Place of Supply';
        TermsConditionsLbl = 'Terms & Conditions';
        AuthSignatoryLbl = 'Authorized Signatory';
        AmountInWordsLbl = 'Amount in Words';
        TotalInWordsLbl = 'Total (in words)';
        BankDetailsLbl = 'Bank Details';
        SubTotalLbl = 'Sub Total';
        DiscountLbl = 'Discount';
        TaxableLbl = 'Taxable Amount';
        GrandTotalLbl = 'Grand Total';
        SrNoLbl = 'Sr.No.';
        ItemDescLbl = 'Item Description';
        QtyLbl = 'Qty';
        UOMLbl = 'UOM';
        RateLbl = 'Rate';
        AmountLbl = 'Amount';
        PhoneLbl = 'Phone';
        EmailLbl = 'Email';
        PageLbl = 'Page';
        OfLbl = 'of';
    }

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        BankAccount: Record "Bank Account";

        // Customer/Ship-to GST Details
        BillToGSTIN: Text[20];
        BillToStateCode: Text[10];
        ShipToGSTIN: Text[20];
        ShipToStateCode: Text[10];
        PlaceOfSupply: Text[50];
        IsInterState: Boolean;

        // Salesperson & Payment
        SalespersonName: Text[100];
        PaymentTermsDesc: Text[100];
        CurrencyCode: Code[10];

        // Line Variables
        HSNSACCode: Code[20];
        LineAmount: Decimal;
        CGSTPercent: Decimal;
        SGSTPercent: Decimal;
        IGSTPercent: Decimal;
        CGSTAmount: Decimal;
        SGSTAmount: Decimal;
        IGSTAmount: Decimal;
        SerialNo: Integer;

        // Totals
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalTaxAmount: Decimal;
        TotalCGSTAmount: Decimal;
        TotalSGSTAmount: Decimal;
        TotalIGSTAmount: Decimal;
        TotalDiscountAmount: Decimal;
        AmountInWords: Text[500];

        // Options
        ShowTermsConditions: Boolean;
        ShowBankDetails: Boolean;

        // Bank Details
        BankName: Text[100];
        BankAccountNo: Text[30];
        BankBranchNo: Text[20];
        BankIFSC: Code[20];
        BankSWIFT: Code[20];
        BankIBAN: Code[50];


    local procedure ConvertAmountToWords(Amount: Decimal): Text[500]
    var
        WholeAmount: Integer;
        DecimalPart: Integer;
        ResultText: Text[500];
    begin
        WholeAmount := Round(Amount, 1, '<');
        DecimalPart := Round((Amount - WholeAmount) * 100, 1);

        ResultText := ConvertNumberToWords(WholeAmount) + ' Rupees';
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

        if Number = 0 then
            exit('Zero');

        // Crores (10,000,000)
        Crores := Number div 10000000;
        Number := Number mod 10000000;
        if Crores > 0 then
            ResultText += ConvertTwoDigits(Crores, Units, Tens) + ' Crore ';

        // Lakhs (100,000)
        Lakhs := Number div 100000;
        Number := Number mod 100000;
        if Lakhs > 0 then
            ResultText += ConvertTwoDigits(Lakhs, Units, Tens) + ' Lakh ';

        // Thousands (1,000)
        Thousands := Number div 1000;
        Number := Number mod 1000;
        if Thousands > 0 then
            ResultText += ConvertTwoDigits(Thousands, Units, Tens) + ' Thousand ';

        // Hundreds
        Hundreds := Number div 100;
        Remainder := Number mod 100;
        if Hundreds > 0 then
            ResultText += Units[Hundreds] + ' Hundred ';

        // Remainder (tens and units)
        if Remainder > 0 then
            ResultText += ConvertTwoDigits(Remainder, Units, Tens);

        exit(ResultText.Trim());
    end;

    local procedure ConvertTwoDigits(Number: Integer; Units: array[19] of Text[20]; Tens: array[9] of Text[20]): Text[50]
    var
        TensPart, UnitsPart: Integer;
    begin
        if Number < 20 then
            exit(Units[Number]);

        TensPart := Number div 10;
        UnitsPart := Number mod 10;

        if UnitsPart = 0 then
            exit(Tens[TensPart])
        else
            exit(Tens[TensPart] + ' ' + Units[UnitsPart]);
    end;
}
