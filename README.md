# GST Sales Documents India for Business Central

A free, open-source Microsoft Dynamics 365 Business Central extension that provides professionally designed, GST-compliant sales document layouts for Indian businesses.

## Overview

This extension replaces the standard Business Central sales document reports with custom layouts specifically designed for Indian GST (Goods and Services Tax) compliance. All documents follow Indian tax invoice formats and include the required statutory information.

## Included Reports

| Report | ID | Description |
|--------|-----|-------------|
| **Tax Invoice** | 50101 | GST-compliant invoice for posted sales invoices |
| **Sales Order** | 50102 | Proforma/Order confirmation with GST details |
| **Sales Quote** | 50100 | Quotation with GST breakdown |
| **Credit Memo** | 50103 | GST-compliant credit note |
| **Return Order** | 50104 | Sales return document with GST details |

## Key Features

### GST Compliance
- **Automatic GST Calculation**: Correctly handles CGST, SGST, and IGST based on transaction type
- **Intra-state Transactions**: Displays CGST + SGST (each at 50% of total GST rate)
- **Inter-state Transactions**: Displays IGST (full GST rate)
- **HSN/SAC Codes**: Shows Harmonized System of Nomenclature codes for goods and Service Accounting Codes for services

### Statutory Information Display
- **Company Details**: GSTIN, PAN, CIN, Company Registration Number
- **Bank Details**: Bank Name, Account Number, Branch, IFSC Code, SWIFT Code
- **Customer Details**: Customer GSTIN, Billing Address, Shipping Address
- **Document Details**: Invoice Number, Date, Due Date, Payment Terms

### Indian Formatting
- **Amount in Words**: Converts total amount to words using Indian numbering system (Crores, Lakhs, Thousands)
- **Currency**: Proper Indian Rupee (₹/Rs.) formatting
- **Number Format**: Indian number grouping (XX,XX,XXX.XX)

### Professional Layout
- Clean, professional design suitable for business use
- Company logo support
- Clear tax breakdown section
- Signature area with "For [Company Name]" designation

## Installation

### Method 1: Download from Releases (Recommended)

1. Download `GST.app` from the [Releases](https://github.com/aeoru/Business-Central-GST-India-Invoice-Template/releases/latest) page
2. In Business Central, search for **Extension Management**
3. Click **Manage** → **Upload Extension**
4. Select the downloaded `.app` file
5. Check the acknowledgment box and click **Deploy**
6. Wait for installation to complete (check **Installation Status** if needed)

### Method 2: Build from Source

Prerequisites:
- Visual Studio Code
- AL Language extension for VS Code
- Business Central development environment

```bash
# Clone the repository
git clone https://github.com/aeoru/Business-Central-GST-India-Invoice-Template.git
cd Business-Central-GST-India-Invoice-Template

# Download symbols (Ctrl+Shift+P → AL: Download Symbols)
# Build the extension
alc.exe /project:"." /packagecachepath:".alpackages" /out:"output/GST.app"
```

## Configuration

### Prerequisites in Business Central

Before using the reports, ensure the following data is configured:

#### Company Information
Navigate to **Company Information** and fill in:
- GSTIN (GST Registration Number)
- PAN (Permanent Account Number)
- CIN (Corporate Identity Number) - in Registration No. field
- Bank Account details (Name, Account No., IFSC, SWIFT)
- Company Address and State Code

#### Customer Cards
For each customer, ensure:
- GSTIN is filled (for B2B transactions)
- Correct billing and shipping addresses
- State codes are set correctly

#### Item Cards
For each item/service:
- HSN Code (for goods) or SAC Code (for services)
- GST Group and GST rates configured

## Usage

### Printing a Tax Invoice
1. Navigate to **Posted Sales Invoices**
2. Open the invoice you want to print
3. Click **Print/Send** → **Print**
4. The GST Tax Invoice layout will be used automatically

### Printing a Sales Order
1. Navigate to **Sales Orders**
2. Open the order you want to print
3. Click **Print/Send** → **Print**
4. The GST Sales Order layout will be used automatically

### Setting as Default Layout
To make these layouts the default for all users:
1. Search for **Report Layout Selection**
2. Find the report (e.g., Report 50101)
3. Set the custom RDLC layout as default

## Requirements

- **Business Central Version**: 27.0 or higher
- **Localization**: India (requires India GST and India Tax Base extensions)
- **Runtime**: 16.0+

## Dependencies

This extension depends on the following Microsoft extensions:
- Base Application (27.0.0.0)
- System Application (27.0.0.0)
- India Tax Base (27.0.0.0)
- India GST (27.1+)

## Screenshots

*Coming soon*

## Contributing

Contributions are welcome! Please feel free to:
- Report bugs by opening an issue
- Suggest features or improvements
- Submit pull requests

## License

This project is licensed under the **MIT License** - you are free to use, modify, and distribute this extension for both commercial and personal purposes. See the [LICENSE](LICENSE) file for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/aeoru/Business-Central-GST-India-Invoice-Template/issues)
- **Discussions**: [GitHub Discussions](https://github.com/aeoru/Business-Central-GST-India-Invoice-Template/discussions)

## Disclaimer

This extension is provided as-is. While every effort has been made to ensure GST compliance, users should verify that the generated documents meet their specific legal and business requirements. The authors are not responsible for any tax filing issues or compliance problems.

---

**Made with ❤️ for the Indian Business Central community**
