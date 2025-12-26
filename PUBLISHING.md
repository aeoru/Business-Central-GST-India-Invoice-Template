# Publishing Guide: GST Sales Documents India

## Option 1: GitHub (Recommended for Open Source)

### Step 1: Create GitHub Repository
```bash
cd C:\Users\Account\BC-SalesQuote
git init
git add .
git commit -m "Initial commit: GST Sales Documents India v2.8.3.0"
```

### Step 2: Create Repository on GitHub
1. Go to https://github.com/new
2. Name: `bc-gst-sales-documents-india`
3. Description: "Business Central extension for Indian GST-compliant sales documents"
4. Set to **Public**
5. Click **Create repository**

### Step 3: Push Code
```bash
git remote add origin https://github.com/YOUR_USERNAME/bc-gst-sales-documents-india.git
git branch -M main
git push -u origin main
```

### Step 4: Create a Release
1. Go to your repo > **Releases** > **Create new release**
2. Tag: `v2.8.3.0`
3. Upload the `output/GST.app` file
4. Publish release

---

## Option 2: Microsoft AppSource (Commercial Distribution)

### Requirements
- Microsoft Partner Network account
- Partner Center access
- Code signing certificate
- Passed validation checks

### Steps
1. **Register** at [Partner Center](https://partner.microsoft.com)
2. **Prepare app.json** - Add required fields:
   ```json
   {
     "privacyStatement": "https://yoursite.com/privacy",
     "EULA": "https://yoursite.com/eula",
     "help": "https://yoursite.com/help",
     "url": "https://yoursite.com"
   }
   ```
3. **Run validation**: `alc.exe /project:. /packagecachepath:.alpackages /target:Cloud`
4. **Submit** via Partner Center > Marketplace offers > New offer > Dynamics 365 Business Central

> **Note:** AppSource requires extensive validation and is best for commercial products. For open-source sharing, GitHub is simpler.

---

## Quick Alternative: Direct Sharing

For sharing with specific companies without AppSource:

1. Share the `.app` file directly
2. They install via **Extension Management > Manage > Upload Extension**
3. No approval process needed for per-tenant extensions
