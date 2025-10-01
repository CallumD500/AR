# 🥫 Can WebAR Experience

A production-ready WebAR application with **dual AR modes**: barcode marker-based AR and GPS location-based AR. Built with A-Frame and AR.js, optimized with Vite. No app installation required - works directly in your phone's web browser!

## 🎯 Two AR Modes

### 📍 **Marker-Based AR**
Point your camera at a barcode marker (QR code compatible) to see the 3D can in AR. Perfect for demos, exhibitions, and controlled environments.

### 🌍 **Location-Based AR**
Experience AR based on GPS coordinates. The 3D can appears at specific real-world locations. Great for outdoor exploration and scavenger hunts.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm 9+
- A smartphone with a camera
- Modern web browser (Chrome, Safari, Firefox)

### Installation

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start development server:**
   ```bash
   npm run dev
   ```
   
   This will start a local HTTPS server (required for camera access) at `https://localhost:3000`

3. **For mobile testing:**
   - The dev server will show you the network URL (e.g., `https://192.168.1.X:3000`)
   - Open this URL on your phone
   - Accept the self-signed certificate warning
   - Or use a tunneling service: `npx localtunnel --port 3000`

### Production Build

```bash
# Build for production
npm run build

# Preview production build locally
npm run preview
```

The optimized build will be in the `dist/` folder, ready to deploy!

## 📱 How to Use

### Mode Selection
1. **Open the app** on your smartphone
2. **Choose your AR mode**:
   - **QR Code Marker AR** - For marker-based tracking
   - **Location-Based AR** - For GPS-based AR

### Marker-Based AR
1. **Allow camera permissions** when prompted
2. **Point your camera** at a barcode marker #0
3. **Watch your 3D can appear** in AR!
4. **Generate markers** at: [AR.js Marker Generator](https://ar-js-org.github.io/AR.js/three.js/examples/marker-training/examples/generator.html)

See [MARKERS.md](./MARKERS.md) for detailed marker instructions.

### Location-Based AR
1. **Allow camera and location permissions**
2. **Go outdoors** for best GPS accuracy
3. **Walk towards** the GPS coordinates
4. **The can appears** when you're near the location
5. **Update coordinates** in `location.html` for your desired locations

## 🛠️ Technical Details

### Technologies Used
- **Vite**: Lightning-fast build tool and dev server
- **A-Frame**: Web framework for building virtual reality experiences
- **AR.js**: Lightweight library for Augmented Reality on the web
- **WebGL**: For 3D rendering
- **WebRTC**: For camera access

### File Structure
```
AR/
├── index.html              # Mode selection page
├── marker.html             # Barcode marker AR mode
├── location.html           # Location-based AR mode
├── doodles-can-2.glb       # Your 3D can model
├── vite.config.js          # Vite configuration (local dev)
├── vite.config.github.js   # Vite configuration (GitHub Pages)
├── package.json            # Node dependencies and scripts
├── MARKERS.md              # Marker generation guide
├── vercel.json             # Vercel deployment config
├── netlify.toml            # Netlify deployment config
└── README.md               # This file
```

### Features
- ✅ Marker-based AR tracking
- ✅ 3D model loading (GLB/GLTF format)
- ✅ Automatic model rotation animation
- ✅ Mobile-optimized interface
- ✅ Real-time camera feed
- ✅ Cross-platform compatibility
- ✅ Production-ready build system (Vite)
- ✅ Optimized assets and code splitting
- ✅ HTTPS development server
- ✅ Easy deployment to Vercel/Netlify
- ✅ Security headers and caching strategies

## 🔧 Customization

### Adjust 3D Model
Edit the `index.html` file to modify:
- **Scale**: Change `scale="0.5 0.5 0.5"` to make the can bigger/smaller
- **Position**: Modify `position="0 0 0"` to move the can
- **Rotation**: Update `rotation="0 0 0"` to change orientation
- **Animation**: Customize the rotation animation speed in the `animation` attribute

### Change Marker
Replace `preset="hiro"` with:
- `preset="kanji"` for Kanji marker
- `type="pattern" url="path/to/your/pattern.patt"` for custom markers

### Styling
Modify the CSS in the `<style>` section to change:
- Instruction overlay appearance
- Loading screen design
- Button styles

## 🚀 Deployment

### Deploy to Vercel (Recommended)

1. **Install Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Deploy:**
   ```bash
   npm run build
   vercel --prod
   ```

Or connect your GitHub repo to Vercel for automatic deployments.

### Deploy to Netlify

1. **Install Netlify CLI:**
   ```bash
   npm i -g netlify-cli
   ```

2. **Deploy:**
   ```bash
   npm run build
   netlify deploy --prod
   ```

Or drag and drop the `dist/` folder to [netlify.com/drop](https://app.netlify.com/drop).

### Deploy to GitHub Pages

1. **Build the project:**
   ```bash
   npm run build
   ```

2. **Deploy the `dist/` folder** to your `gh-pages` branch

## 📱 QR Code Generation

After deployment:

1. **Get your production URL** (e.g., `https://your-app.vercel.app`)
2. **Generate QR code** using:
   - [QR Code Generator](https://www.qr-code-generator.com/)
   - [QRCode Monkey](https://www.qrcode-monkey.com/)
   - Or programmatically with `qrcode` npm package
3. **Share the QR code** - scanning it opens your WebAR experience instantly!

## 🐛 Troubleshooting

### Camera Not Working
- Ensure you're using HTTPS (required for camera access)
- Check browser permissions for camera access
- Try a different browser (Chrome usually works best)

### 3D Model Not Loading
- Check that `doodles-can-2.glb` is in the same directory
- Verify the file isn't corrupted
- Check browser console for error messages

### Marker Not Detected
- Ensure good lighting conditions
- Hold the marker steady and flat
- Try printing a larger version of the marker
- Clean your camera lens

### Performance Issues
- Close other browser tabs
- Restart the browser
- Try on a different device with better performance

## 🚀 Next Steps

Want to enhance your WebAR experience? Try:
- Adding sound effects when the marker is detected
- Creating multiple markers with different 3D models
- Adding interactive buttons in AR
- Implementing location-based AR
- Adding particle effects or animations

## 📄 License

MIT License - feel free to modify and share!

---

**Happy AR Building! 🥫✨**

