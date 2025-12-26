# Publishing Guide: GST Sales Documents India

This extension is now published on GitHub!

## Repository

**URL:** https://github.com/aeoru/Business-Central-GST-India-Invoice-Template

## For Users: How to Download & Install

### Step 1: Download
1. Go to [Releases](https://github.com/aeoru/Business-Central-GST-India-Invoice-Template/releases/latest)
2. Download `GST.zip`
3. Extract the ZIP file to get `GST.app`

### Step 2: Install in Business Central
1. Open Business Central
2. Search for **Extension Management**
3. Click **Manage** → **Upload Extension**
4. Select the `GST.app` file
5. Check the acknowledgment checkbox
6. Click **Deploy**
7. Wait 1-2 minutes for installation to complete

### Step 3: Verify Installation
1. Go to **Extension Management**
2. Look for "GST Sales Documents India" in the list
3. Status should show as "Installed"

---

## For Developers: How to Contribute

### Clone the Repository
```bash
git clone git@github.com:aeoru/Business-Central-GST-India-Invoice-Template.git
cd Business-Central-GST-India-Invoice-Template
```

### Build from Source
1. Open the folder in VS Code
2. Install the AL Language extension
3. Press `Ctrl+Shift+P` → **AL: Download Symbols**
4. Press `Ctrl+Shift+B` to build
5. Output will be in `output/GST.app`

### Submit Changes
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a Pull Request

---

## Creating a New Release

### Step 1: Update Version
Edit `app.json` and increment the version number:
```json
"version": "X.X.X.X"
```

### Step 2: Build
```bash
alc.exe /project:"." /packagecachepath:".alpackages" /out:"output/GST.app"
```

### Step 3: Create ZIP
```powershell
Compress-Archive -Path "output/GST.app" -DestinationPath "output/GST.zip" -Force
```

### Step 4: Create GitHub Release
1. Go to [Releases](https://github.com/aeoru/Business-Central-GST-India-Invoice-Template/releases/new)
2. Create a new tag (e.g., `v2.8.4.0`)
3. Add release title and description
4. Upload `GST.zip`
5. Publish release

---

## Alternative: Microsoft AppSource

For commercial distribution via AppSource:

### Requirements
- Microsoft Partner Network account
- Partner Center access
- Code signing certificate (~$200-400/year)
- Pass validation checks

### Steps
1. Register at [Partner Center](https://partner.microsoft.com)
2. Add required fields to `app.json`:
   ```json
   {
     "privacyStatement": "https://yoursite.com/privacy",
     "EULA": "https://yoursite.com/eula",
     "help": "https://yoursite.com/help",
     "url": "https://yoursite.com"
   }
   ```
3. Run validation: `alc.exe /project:. /packagecachepath:.alpackages /target:Cloud`
4. Submit via Partner Center → Marketplace offers → Dynamics 365 Business Central

> **Note:** AppSource requires extensive validation. For free open-source distribution, GitHub is simpler and has no cost.

---

## Direct Sharing

For sharing with specific companies:

1. Send them the `GST.zip` file directly
2. They extract and install via **Extension Management → Manage → Upload Extension**
3. No approval process needed for per-tenant extensions
