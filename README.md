# GST Sales Documents India

Business Central extension providing Indian GST-compliant sales document layouts.

## Features

- **Tax Invoice** (Report 50101) - GST-compliant invoice with CGST/SGST/IGST breakdown
- **Sales Order** (Report 50102) - Proforma with full GST details
- Displays: GSTIN, PAN, CIN, HSN/SAC codes, Amount in words
- Supports intra-state (CGST+SGST) and inter-state (IGST) transactions

## Installation

### Method 1: From Release (Recommended)
1. Download `GST.app` from [Releases](../../releases)
2. In Business Central, go to **Extension Management**
3. Click **Manage > Upload Extension**
4. Select the `.app` file and click **Deploy**

### Method 2: Build from Source
```bash
# Requires AL Language extension in VS Code
alc.exe /project:"." /packagecachepath:".alpackages" /out:"output/GST.app"
```

## Usage

### Generate Tax Invoice
1. Go to **Posted Sales Invoices**
2. Select an invoice
3. Click **Print/Send > Print**
4. Select **Tax Invoice GST** layout

### Generate Sales Order
1. Go to **Sales Orders**
2. Select an order
3. Click **Print/Send > Print**
4. Select **Sales Order GST** layout

## Requirements

- Business Central v27.0+
- India localization (India GST, India Tax Base)

## Configuration

The reports automatically pull:
- Company GSTIN, PAN, CIN from **Company Information**
- Customer GSTIN from **Customer Card**
- HSN/SAC codes from **Item Card**
- GST rates from **GST Setup**

## License

MIT License - Free for commercial and personal use.
