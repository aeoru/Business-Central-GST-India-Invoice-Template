# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**BC-SalesQuote** is a Microsoft Dynamics 365 Business Central (BC) AL extension providing GST-compliant sales document layouts for the Indian market. It customizes standard BC sales documents (Quote, Order, Invoice, Credit Memo, Return Order) with complete GST tax breakdowns (CGST, SGST, IGST), HSN/SAC codes, GSTIN details, and amount-in-words conversion using Indian numbering (Crores, Lakhs).

- **Platform:** Business Central 27.0 (Cloud)
- **Runtime:** 16.0
- **Object ID Range:** 50100-50199

## Build and Development

### Prerequisites
- VS Code with AL Language extension (ms-dynamics-smb.al)
- Business Central development environment

### Compilation
Use VS Code's AL: Package command (Ctrl+Shift+B) or the AL Language extension to compile. Output goes to `output/GST.app`.

### Deployment
Deploy the compiled `.app` file via BC Extension Management to the target environment.

### Debug Configuration
Configure your own launch.json to connect to your Business Central environment. Startup object is typically Report 50101 (Sales Invoice).

### RDLC Fix Scripts
PowerShell scripts fix `First()` function scope issues in RDLC files:
- `fix_rdlc.ps1` - Single file fix
- `fix_all_rdlc.ps1` - Batch fix all .rdl files in src/

## Architecture

### Source Structure (src/)
```
CompanyInfoExt.TableExt.al   - Extends Company Information table (adds IFSC Code field 50100)
CompanyInfoCardExt.PageExt.al - UI extension for Company Information page
SalesQuoteGST.Report.al      - Report 50100: Sales Quote
SalesOrderGST.Report.al      - Report 50102: Sales Order
SalesInvoiceGST.Report.al    - Report 50101: Tax Invoice
SalesCreditMemoGST.Report.al - Report 50103: Credit Memo
SalesReturnOrderGST.Report.al - Report 50104: Return Order
*.rdl                        - Corresponding RDLC visual layouts
```

### Report Pattern
Each report follows the same structure:
1. **Header dataitem** - Document header (Sales Header/Invoice Header/etc.) with company, customer, and ship-to columns
2. **Lines dataitem** - Document lines with item details, HSN/SAC codes, and per-line GST calculations
3. **Local procedures** - `ConvertAmountToWords()`, `ConvertNumberToWords()`, `ConvertTwoDigits()` for Indian currency text

### GST Calculation Logic
- **Inter-state** (company state ≠ ship-to state): IGST = full VAT%, CGST/SGST = 0%
- **Intra-state** (company state = ship-to state): CGST = VAT%/2, SGST = VAT%/2, IGST = 0%

### Dependencies
- Base Application (27.0)
- System Application (27.0)
- India Tax Base (27.0)
- India GST (27.1)
