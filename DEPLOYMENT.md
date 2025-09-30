# 🚀 Deployment Guide

This guide covers deploying your WebAR experience to production.

## Quick Deployment Options

### Option 1: Vercel (Recommended) ⚡

**Why Vercel?**
- Zero configuration needed
- Automatic HTTPS
- Global CDN
- Perfect for static sites
- Free tier available

**Deploy via CLI:**
```bash
# Install Vercel CLI
npm i -g vercel

# Build and deploy
npm run build
vercel --prod
```

**Deploy via GitHub:**
1. Push code to GitHub
2. Visit [vercel.com](https://vercel.com)
3. Click "Import Project"
4. Select your repository
5. Vercel auto-detects Vite and deploys!

**Environment Variables (if needed):**
- Go to Project Settings → Environment Variables
- Add any variables from `env.example`

---

### Option 2: Netlify 🌐

**Deploy via CLI:**
```bash
# Install Netlify CLI
npm i -g netlify-cli

# Build and deploy
npm run build
netlify deploy --prod
```

**Deploy via Drag & Drop:**
1. Run `npm run build`
2. Visit [netlify.com/drop](https://app.netlify.com/drop)
3. Drag the `dist/` folder
4. Done!

**Deploy via GitHub:**
1. Push code to GitHub
2. Visit [netlify.com](https://netlify.com)
3. Click "Add new site" → "Import from Git"
4. Select repository
5. Build settings are auto-configured via `netlify.toml`

---

### Option 3: GitHub Pages 📄

1. **Update `vite.config.js`** - set base to your repo name:
   ```js
   export default defineConfig({
     base: '/your-repo-name/',
     // ... rest of config
   })
   ```

2. **Install gh-pages:**
   ```bash
   npm install -D gh-pages
   ```

3. **Add deploy script to `package.json`:**
   ```json
   "scripts": {
     "deploy": "npm run build && gh-pages -d dist"
   }
   ```

4. **Deploy:**
   ```bash
   npm run deploy
   ```

5. **Enable GitHub Pages:**
   - Go to repository Settings → Pages
   - Select `gh-pages` branch
   - Save

Your app will be live at: `https://username.github.io/repo-name/`

---

## CI/CD with GitHub Actions

The included `.github/workflows/deploy.yml` automatically:
- ✅ Builds on every push/PR
- ✅ Tests on multiple Node versions
- ✅ Deploys to Vercel on main branch

**Setup GitHub Actions for Vercel:**

1. **Get Vercel tokens:**
   ```bash
   # Login to Vercel
   vercel login
   
   # Link project
   vercel link
   
   # Get tokens
   vercel project ls
   ```

2. **Add GitHub Secrets:**
   Go to your GitHub repo → Settings → Secrets → Actions
   
   Add these secrets:
   - `VERCEL_TOKEN` - Get from vercel.com/account/tokens
   - `VERCEL_ORG_ID` - Found in `.vercel/project.json`
   - `VERCEL_PROJECT_ID` - Found in `.vercel/project.json`

3. **Push to GitHub** - automatic deployment starts!

---

## Custom Domain Setup

### Vercel
1. Go to Project Settings → Domains
2. Add your domain
3. Update DNS records as shown
4. HTTPS is automatic!

### Netlify
1. Go to Site Settings → Domain Management
2. Add custom domain
3. Update DNS records
4. HTTPS is automatic!

### GitHub Pages
1. Go to Settings → Pages
2. Enter custom domain
3. Add CNAME record in your DNS
4. Enable "Enforce HTTPS"

---

## Post-Deployment

### Generate QR Code
Once deployed, create a QR code for easy mobile access:

```bash
# Install QR code generator
npm install -g qrcode-terminal

# Generate QR code
qrcode-terminal https://your-deployed-url.com
```

Or use online tools:
- [QR Code Generator](https://www.qr-code-generator.com/)
- [QRCode Monkey](https://www.qrcode-monkey.com/)

### Test Your Deployment
1. ✅ Open URL on desktop - should load instantly
2. ✅ Scan QR code on mobile - camera should work
3. ✅ Test AR marker detection
4. ✅ Check 3D model loads correctly
5. ✅ Test on different devices (iOS/Android)

### Monitor Performance
- **Vercel**: Built-in analytics in dashboard
- **Netlify**: Analytics available in dashboard
- **Add Google Analytics**: Uncomment GA code in `index.html`

---

## Troubleshooting Deployment

### Build Fails
```bash
# Clear cache and rebuild
rm -rf node_modules package-lock.json dist
npm install
npm run build
```

### Camera Not Working in Production
- Ensure deployment uses HTTPS (all platforms do by default)
- Check browser console for permission errors
- Verify `Permissions-Policy` headers are set correctly

### 3D Model Not Loading
- Check that `.glb` files are included in build
- Verify file paths are relative (`./model.glb` not `/model.glb`)
- Check deployment platform's asset size limits

### Slow Load Times
- Enable compression (already configured in `vercel.json`/`netlify.toml`)
- Consider optimizing your 3D model (reduce polygons/textures)
- Use CDN for assets (both Vercel/Netlify provide this)

---

## Cost Considerations

### Free Tiers
- **Vercel**: 100GB bandwidth/month, unlimited projects
- **Netlify**: 100GB bandwidth/month, 300 build minutes
- **GitHub Pages**: 100GB bandwidth/month

### Scaling Up
For high-traffic WebAR experiences, consider:
- Vercel Pro: $20/month - 1TB bandwidth
- Netlify Pro: $19/month - 1TB bandwidth
- CloudFlare + S3: Pay-as-you-go

---

## Security Checklist

✅ HTTPS enabled (automatic on all platforms)  
✅ Security headers configured (`vercel.json`/`netlify.toml`)  
✅ No sensitive data in client code  
✅ CORS properly configured  
✅ Camera permissions properly requested  

---

## Performance Checklist

✅ Minified and compressed assets  
✅ Code splitting enabled  
✅ Asset caching configured (1 year for static assets)  
✅ 3D models optimized  
✅ Images compressed  
✅ Console logs removed in production  

---

**Need help?** Open an issue or check the main [README.md](./README.md) for more info!

