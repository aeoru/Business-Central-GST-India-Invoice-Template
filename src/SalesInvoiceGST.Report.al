report 50101 "Sales Invoice GST India"
{
    Caption = 'Tax Invoice (GST India)';
    DefaultLayout = RDLC;
    RDLCLayout = 'src/SalesInvoiceGST.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Posting Date";

            // ========== COMPANY INFORMATION (Left Header) ==========
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyCountry; CompanyInfo."Country/Region Code") { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyFax; CompanyInfo."Fax No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyHomePage; CompanyInfo."Home Page") { }
            column(CompanyGSTIN; CompanyInfo."GST Registration No.") { }
            column(CompanyPAN; CompanyInfo."P.A.N. No.") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyStateCode; CompanyInfo."State Code") { }
            column(CompanyStateName; CompanyStateName) { }
            column(CompanyCIN; CompanyCIN) { }

            // ========== INVOICE DETAILS (Right Header) ==========
            column(InvoiceNo; "No.") { }
            column(InvoiceDate; "Posting Date") { }
            column(DueDate; "Due Date") { }
            column(OrderNo; "Order No.") { }
            column(OrderDate; "Order Date") { }
            column(ExternalDocNo; "External Document No.") { }
            column(SalespersonCode; "Salesperson Code") { }
            column(SalespersonName; SalespersonName) { }
            column(YourReference; "Your Reference") { }
            column(ShipmentDate; "Shipment Date") { }
            column(ShipmentMethodCode; "Shipment Method Code") { }

            // ========== CUSTOMER INFORMATION (Below Header - Left) ==========
            column(CustomerNo; "Sell-to Customer No.") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(CustomerAddress; "Sell-to Address") { }
            column(CustomerAddress2; "Sell-to Address 2") { }
            column(CustomerCity; "Sell-to City") { }
            column(CustomerPostCode; "Sell-to Post Code") { }
            column(CustomerCountry; "Sell-to Country/Region Code") { }
            column(CustomerContact; "Sell-to Contact") { }
            column(CustomerGSTIN; CustomerGSTIN) { }
            column(CustomerStateCode; CustomerStateCode) { }
            column(CustomerStateName; CustomerStateName) { }
            column(CustomerPAN; CustomerPAN) { }

            // Bill-to (if different)
            column(BillToCustomerNo; "Bill-to Customer No.") { }
            column(BillToName; "Bill-to Name") { }
            column(BillToAddress; "Bill-to Address") { }
            column(BillToAddress2; "Bill-to Address 2") { }
            column(BillToCity; "Bill-to City") { }
            column(BillToPostCode; "Bill-to Post Code") { }
            column(BillToCountry; "Bill-to Country/Region Code") { }
            column(BillToContact; "Bill-to Contact") { }

            // Ship-to
            column(ShipToCode; "Ship-to Code") { }
            column(ShipToName; "Ship-to Name") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(ShipToCountry; "Ship-to Country/Region Code") { }
            column(ShipToContact; "Ship-to Contact") { }

            // ========== GST & TAX INFORMATION ==========
            column(PlaceOfSupply; PlaceOfSupply) { }
            column(PlaceOfSupplyCode; PlaceOfSupplyCode) { }
            column(IsInterState; IsInterState) { }
            column(ReverseCharge; ReverseCharge) { }

            // ========== CURRENCY & PAYMENT ==========
            column(CurrencyCode; CurrencyCode) { }
            column(CurrencySymbol; CurrencySymbol) { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(PaymentTermsDesc; PaymentTermsDesc) { }
            column(PaymentMethodCode; "Payment Method Code") { }

            // ========== TOTALS ==========
            column(SubTotal; SubTotal) { }
            column(TotalDiscountAmount; TotalDiscountAmount) { }
            column(TotalTaxableAmount; TotalTaxableAmount) { }
            column(TotalCGSTAmount; TotalCGSTAmount) { }
            column(TotalSGSTAmount; TotalSGSTAmount) { }
            column(TotalIGSTAmount; TotalIGSTAmount) { }
            column(TotalGSTAmount; TotalGSTAmount) { }
            column(GrandTotal; GrandTotal) { }
            column(RoundOffAmount; RoundOffAmount) { }
            column(AmountInWords; AmountInWords) { }

            // ========== BANK DETAILS ==========
            column(BankName; BankName) { }
            column(BankAccountNo; BankAccountNo) { }
            column(BankBranchNo; BankBranchNo) { }
            column(BankIFSC; BankIFSC) { }
            column(BankSWIFT; BankSWIFT) { }
            column(BankIBAN; BankIBAN) { }


            // ========== LINE ITEMS ==========
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(LineNo; "Line No.") { }
                column(Type; Type) { }
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Description2; "Description 2") { }
                column(HSNSACCode; HSNSACCode) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(UnitOfMeasureCode; "Unit of Measure Code") { }
                column(Quantity; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(LineDiscountPercent; "Line Discount %") { }
                column(LineDiscountAmount; "Line Discount Amount") { }
                column(LineAmount; "Line Amount") { }
                column(TaxableAmount; TaxableAmount) { }
                column(GSTPercent; GSTPercent) { }
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
                    // Skip blank lines
                    if (Type = Type::" ") and ("No." = '') and (Description = '') then
                        CurrReport.Skip();

                    SerialNo += 1;

                    // Get HSN/SAC Code
                    HSNSACCode := '';
                    if Type = Type::Item then begin
                        if Item.Get("No.") then
                            HSNSACCode := Item."HSN/SAC Code";
                    end;

                    // Calculate taxable amount
                    TaxableAmount := "Line Amount";

                    // GST Rate (default 18% = 9% CGST + 9% SGST or 18% IGST)
                    GSTPercent := "VAT %";
                    if GSTPercent = 0 then
                        GSTPercent := 18; // Default GST rate

                    // Calculate GST based on inter-state or intra-state
                    if IsInterState then begin
                        // Inter-state: IGST only
                        IGSTPercent := GSTPercent;
                        IGSTAmount := Round(TaxableAmount * IGSTPercent / 100, 0.01);
                        CGSTPercent := 0;
                        SGSTPercent := 0;
                        CGSTAmount := 0;
                        SGSTAmount := 0;
                    end else begin
                        // Intra-state: CGST + SGST (split equally)
                        CGSTPercent := GSTPercent / 2; // 9%
                        SGSTPercent := GSTPercent / 2; // 9%
                        CGSTAmount := Round(TaxableAmount * CGSTPercent / 100, 0.01);
                        SGSTAmount := Round(TaxableAmount * SGSTPercent / 100, 0.01);
                        IGSTPercent := 0;
                        IGSTAmount := 0;
                    end;

                    // Line total including GST
                    LineTotal := TaxableAmount + CGSTAmount + SGSTAmount + IGSTAmount;

                    // Accumulate totals
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
                // Reset totals
                SubTotal := 0;
                TotalDiscountAmount := 0;
                TotalTaxableAmount := 0;
                TotalCGSTAmount := 0;
                TotalSGSTAmount := 0;
                TotalIGSTAmount := 0;
                TotalGSTAmount := 0;
                GrandTotal := 0;
                SerialNo := 0;

                // Get Company Information
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                // Get Company Registration Number (CIN)
                CompanyCIN := CompanyInfo."Registration No.";

                // Get Company State Name
                CompanyStateName := '';
                if State.Get(CompanyInfo."State Code") then
                    CompanyStateName := State.Description;

                // Get Customer GST details
                CustomerGSTIN := '';
                CustomerStateCode := '';
                CustomerStateName := '';
                CustomerPAN := '';
                if Customer.Get("Sell-to Customer No.") then begin
                    CustomerGSTIN := Customer."GST Registration No.";
                    CustomerStateCode := Customer."State Code";
                    CustomerPAN := Customer."P.A.N. No.";
                    if State.Get(Customer."State Code") then
                        CustomerStateName := State.Description;
                end;

                // Determine Place of Supply and Inter-state flag
                PlaceOfSupplyCode := CustomerStateCode;
                PlaceOfSupply := CustomerStateName;
                IsInterState := CompanyInfo."State Code" <> CustomerStateCode;

                // Reverse Charge
                ReverseCharge := 'No';

                // Get Salesperson
                SalespersonName := '';
                if Salesperson.Get("Salesperson Code") then
                    SalespersonName := Salesperson.Name;

                // Get Payment Terms
                PaymentTermsDesc := '';
                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTermsDesc := PaymentTerms.Description;

                // Currency
                if "Currency Code" = '' then begin
                    CurrencyCode := 'INR';
                    CurrencySymbol := 'Rs.';
                end else begin
                    CurrencyCode := "Currency Code";
                    CurrencySymbol := "Currency Code";
                end;

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
                // Calculate final totals (for use by Totals dataitem)
                TotalGSTAmount := TotalCGSTAmount + TotalSGSTAmount + TotalIGSTAmount;
                GrandTotal := TotalTaxableAmount + TotalGSTAmount;

                // Round off
                RoundOffAmount := Round(GrandTotal, 1) - GrandTotal;
                GrandTotal := Round(GrandTotal, 1);

                // Amount in words
                AmountInWords := ConvertAmountToWords(GrandTotal);
            end;
        }

        // Totals dataitem - outputs calculated totals after all lines are processed
        dataitem(Totals; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            MaxIteration = 1;

            column(Totals_SubTotal; SubTotal) { }
            column(Totals_TotalDiscountAmount; TotalDiscountAmount) { }
            column(Totals_TotalTaxableAmount; TotalTaxableAmount) { }
            column(Totals_TotalCGSTAmount; TotalCGSTAmount) { }
            column(Totals_TotalSGSTAmount; TotalSGSTAmount) { }
            column(Totals_TotalIGSTAmount; TotalIGSTAmount) { }
            column(Totals_TotalGSTAmount; TotalGSTAmount) { }
            column(Totals_GrandTotal; GrandTotal) { }
            column(Totals_RoundOffAmount; RoundOffAmount) { }
            column(Totals_AmountInWords; AmountInWords) { }
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

                    field(ShowLogo; ShowLogo)
                    {
                        Caption = 'Show Company Logo';
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
        TaxInvoiceLbl = 'TAX INVOICE';
        InvoiceNoLbl = 'Invoice No.';
        InvoiceDateLbl = 'Invoice Date';
        DueDateLbl = 'Due Date';
        CustomerLbl = 'Bill To';
        ShipToLbl = 'Ship To';
        GSTINLbl = 'GSTIN';
        PANLbl = 'PAN';
        PlaceOfSupplyLbl = 'Place of Supply';
        HSNSACLbl = 'HSN/SAC';
        CGSTLbl = 'CGST @9%';
        SGSTLbl = 'SGST @9%';
        IGSTLbl = 'IGST @18%';
        SubTotalLbl = 'Sub Total';
        DiscountLbl = 'Discount';
        TaxableAmountLbl = 'Taxable Amount';
        GrandTotalLbl = 'Grand Total';
        AmountInWordsLbl = 'Amount in Words';
        PaymentTermsLbl = 'Payment Terms';
        DeclarationLbl = 'Declaration';
        DeclarationText = 'We declare that this invoice shows the actual price of the goods/services described and that all particulars are true and correct.';
        AuthSignatoryLbl = 'Authorized Signatory';
        ForCompanyLbl = 'For';
        BankDetailsLbl = 'Bank Details';
    }

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        BankAccount: Record "Bank Account";

        // Company Details
        CompanyStateName: Text[100];
        CompanyCIN: Text[50];

        // Customer GST Details
        CustomerGSTIN: Text[20];
        CustomerStateCode: Text[10];
        CustomerStateName: Text[100];
        CustomerPAN: Text[20];

        // GST Details
        PlaceOfSupply: Text[100];
        PlaceOfSupplyCode: Text[10];
        IsInterState: Boolean;
        ReverseCharge: Text[10];

        // Salesperson & Payment
        SalespersonName: Text[100];
        PaymentTermsDesc: Text[100];
        CurrencyCode: Code[10];
        CurrencySymbol: Text[10];

        // Line Variables
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

        // Totals
        SubTotal: Decimal;
        TotalDiscountAmount: Decimal;
        TotalTaxableAmount: Decimal;
        TotalCGSTAmount: Decimal;
        TotalSGSTAmount: Decimal;
        TotalIGSTAmount: Decimal;
        TotalGSTAmount: Decimal;
        GrandTotal: Decimal;
        RoundOffAmount: Decimal;
        AmountInWords: Text[500];

        // Options
        ShowLogo: Boolean;
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
