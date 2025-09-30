# 🧪 Testing Guide - WebAR Experience

This guide will help you test your WebAR application thoroughly.

## ✅ Pre-Flight Checklist

Before starting, ensure you have:
- [ ] Node.js 18+ installed (`node --version`)
- [ ] npm installed (`npm --version`)
- [ ] Modern browser (Chrome 87+, Safari 14+, Firefox 78+)
- [ ] Smartphone with camera (for AR testing)
- [ ] Same WiFi network for mobile and desktop

---

## 🚀 Step 1: Development Server Test

### Start the Server
```bash
npm run dev
```

**Expected Output:**
```
VITE v6.3.6  ready in XXX ms

➜  Local:   https://localhost:3000/
➜  Network: https://192.168.X.X:3000/
```

### ✅ Checklist:
- [ ] Server starts without errors
- [ ] Browser opens automatically
- [ ] HTTPS URL (not HTTP)
- [ ] Network URL is displayed

---

## 🖥️ Step 2: Desktop Browser Test

### Accept Self-Signed Certificate
1. Click "Advanced" or "Show Details"
2. Click "Proceed to localhost" or "Accept Risk"

### ✅ Checklist:
- [ ] Page loads successfully
- [ ] Instructions overlay visible
- [ ] Loading indicator appears briefly
- [ ] No console errors (check DevTools)
- [ ] Camera permission dialog appears

### Expected Console Output:
```
✅ AR Scene loaded
✅ Camera initialized
✅ Camera permission granted
✅ 3D Can model loaded successfully in X.XXs
📊 Page loaded in X.XXs
```

### Common Issues:

**Camera not working:**
- Ensure HTTPS is enabled
- Check browser permissions
- Try Chrome (best WebAR support)

**Model not loading:**
- Check Network tab in DevTools
- Verify `/doodles-can-2.glb` loads (should be ~1.9MB)

---

## 📱 Step 3: Mobile Device Test

### Connect Your Phone
1. Find the **Network URL** from terminal (e.g., `https://192.168.1.10:3000`)
2. Open this URL in your phone's browser
3. Accept the certificate warning

### ✅ Checklist:
- [ ] Page loads on mobile
- [ ] Instructions are readable
- [ ] Camera permission prompt appears
- [ ] Allow camera access

### Expected Behavior:
1. Instructions overlay shows
2. Camera feed starts
3. "AR Ready" status appears
4. Ready to scan marker!

---

## 🎯 Step 4: AR Marker Test

### Get the Marker
1. Print from: https://ar-js-org.github.io/AR.js/data/images/hiro.png
2. Or display on another screen
3. Make it **at least 3x3 inches** (larger is better)

### Test AR Tracking

**📍 Test 1: Marker Detection**
1. Point camera at marker
2. Keep marker flat and well-lit
3. Hold phone 20-40cm from marker

**Expected:**
- ✅ "AR Active" status shows
- ✅ 3D can appears on marker
- ✅ Can is properly scaled
- ✅ Can rotates smoothly
- ✅ Lighting looks good

**Console Output:**
```
🎯 Marker detected - Can visible!
```

**📍 Test 2: Tracking Stability**
1. Move phone around marker (left, right, up, down)
2. Tilt phone at different angles
3. Move closer and farther

**Expected:**
- ✅ Can stays locked to marker
- ✅ No jittering or jumping
- ✅ Smooth tracking
- ✅ Can disappears when marker not visible

**Console Output:**
```
👁️ Marker lost
🎯 Marker detected - Can visible!
```

**📍 Test 3: Different Lighting**
Test in:
- [ ] Bright indoor light
- [ ] Dim indoor light
- [ ] Natural daylight
- [ ] Mix of light sources

---

## 🎨 Step 5: UI/UX Test

### Instructions Overlay
- [ ] Visible on load
- [ ] "Got It" button works
- [ ] Auto-hides after 5 seconds
- [ ] Double-tap shows/hides it

### Loading States
- [ ] Loading spinner appears
- [ ] "Loading AR Experience..." shows
- [ ] Disappears when model loads
- [ ] Smooth transition

### Status Indicator
- [ ] "AR Ready" shows when loaded
- [ ] "AR Active" shows when marker detected
- [ ] "Searching for marker..." shows when lost
- [ ] Green color when active

### Error Handling
Test error scenarios:
- [ ] Deny camera permission → Error message shows
- [ ] Offline → Appropriate error
- [ ] Model file missing → Error displayed

---

## 🏗️ Step 6: Production Build Test

### Build the Project
```bash
npm run build
```

**Expected Output:**
```
vite v6.3.6 building for production...
✓ 2 modules transformed.
dist/index.html  15.16 kB │ gzip: 4.06 kB
✓ built in XXXms
```

### ✅ Checklist:
- [ ] Build completes without errors
- [ ] `dist/` folder created
- [ ] `dist/index.html` exists
- [ ] `dist/doodles-can-2.glb` exists (1.9MB)
- [ ] `dist/manifest.json` exists
- [ ] `dist/robots.txt` exists

### Preview Production Build
```bash
npm run preview
```

**Test:**
- [ ] Opens at `https://localhost:4173`
- [ ] All features work same as dev
- [ ] No console errors
- [ ] Performance feels fast

---

## 📊 Step 7: Performance Test

### Load Time Metrics

**Desktop (Chrome DevTools → Network):**
- [ ] Initial HTML load: < 1s
- [ ] 3D model load: < 2s
- [ ] Total page load: < 3s
- [ ] No 404 errors

**Mobile (Chrome DevTools → Lighthouse):**
Run Lighthouse audit:
- [ ] Performance: > 80
- [ ] Accessibility: > 90
- [ ] Best Practices: > 90
- [ ] SEO: > 80

### AR Performance

**Frame Rate:**
- [ ] Camera feed: 30+ FPS
- [ ] Model rotation: Smooth
- [ ] No dropped frames
- [ ] No lag or stutter

**Memory:**
Check DevTools Memory:
- [ ] No memory leaks
- [ ] Stable memory usage
- [ ] < 100MB total

---

## 🌐 Step 8: Cross-Browser Test

### Desktop Browsers
Test on:
- [ ] Chrome (Latest)
- [ ] Firefox (Latest)
- [ ] Safari (Latest)
- [ ] Edge (Latest)

### Mobile Browsers
Test on:
- [ ] iOS Safari
- [ ] iOS Chrome
- [ ] Android Chrome
- [ ] Android Firefox

### Known Compatibility:
✅ **Best:** Chrome (Desktop & Mobile)
✅ **Good:** Safari (iOS & macOS)
⚠️ **Okay:** Firefox (some AR.js quirks)
⚠️ **Limited:** Edge (older versions)

---

## 🔍 Step 9: Debug Common Issues

### Issue: Camera Not Working
**Check:**
```javascript
// Open Console and run:
navigator.mediaDevices.getUserMedia({ video: true })
  .then(() => console.log('Camera works!'))
  .catch(err => console.error('Camera error:', err));
```

**Fixes:**
- Use HTTPS (required)
- Check browser permissions
- Try different browser
- Restart browser

### Issue: Marker Not Detected
**Check:**
- Marker print quality (crisp, not blurry)
- Lighting (bright, even lighting)
- Marker size (at least 3x3 inches)
- Distance (20-40cm optimal)
- Marker flatness (no wrinkles)

**Debug:**
```javascript
// Check marker tracking in console
document.querySelector('#marker').addEventListener('markerFound', 
  () => console.log('FOUND!'));
document.querySelector('#marker').addEventListener('markerLost', 
  () => console.log('LOST!'));
```

### Issue: Model Not Appearing
**Check Console for:**
```
✅ 3D Can model loaded successfully
```

**If not loaded:**
- Check Network tab: `/doodles-can-2.glb` should be 200 OK
- Verify file exists: `ls public/doodles-can-2.glb`
- Check file size: ~1.9MB
- Try hard refresh: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)

### Issue: Performance Issues
**Fixes:**
- Close other browser tabs
- Restart browser
- Clear browser cache
- Try on better device
- Reduce model complexity (if using custom model)

---

## ✅ Final Verification Checklist

### Development ✓
- [ ] `npm install` works
- [ ] `npm run dev` starts server
- [ ] HTTPS works
- [ ] Hot reload works
- [ ] No console errors

### Functionality ✓
- [ ] Camera permissions requested
- [ ] Camera feed shows
- [ ] Marker detection works
- [ ] 3D model appears
- [ ] Model stays locked to marker
- [ ] Rotation animation works
- [ ] Lighting looks good

### UI/UX ✓
- [ ] Instructions clear
- [ ] Loading states work
- [ ] Status indicators work
- [ ] Error messages work
- [ ] Responsive design
- [ ] Touch interactions work

### Production ✓
- [ ] `npm run build` succeeds
- [ ] All files in `dist/`
- [ ] `npm run preview` works
- [ ] Performance is good
- [ ] No console errors
- [ ] Works on mobile

### Ready to Deploy? 🚀
- [ ] All tests pass ✅
- [ ] No critical issues
- [ ] Performance acceptable
- [ ] Mobile experience good

---

## 📈 Success Criteria

Your WebAR experience is **ready for production** when:

1. ✅ Builds without errors
2. ✅ Loads in < 3 seconds
3. ✅ Camera works on mobile
4. ✅ Marker detection is reliable
5. ✅ 3D model appears correctly
6. ✅ No console errors
7. ✅ Works on iOS and Android
8. ✅ Good performance (> 30 FPS)

---

## 🎉 Next Steps

Once all tests pass:
1. Deploy to Vercel/Netlify (see `DEPLOYMENT.md`)
2. Generate QR code with production URL
3. Share with users!

---

## 🆘 Still Having Issues?

### Debug Mode
Enable debug mode by editing `index.html`:
```html
arjs="debugUIEnabled: true; ..."
```

This shows tracking info overlay.

### Get Help
- Check browser console for errors
- Review `README.md` for troubleshooting
- Check A-Frame docs: https://aframe.io
- Check AR.js docs: https://ar-js-org.github.io/AR.js-Docs/

---

**Happy Testing! 🧪✨**

