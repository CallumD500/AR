# AR Marker Guide

## Barcode Marker AR Mode

The marker-based AR mode uses **barcode markers** (value: 0) which can be embedded in QR codes.

### Generating Barcode Markers

1. **Online Generator**: Visit the [AR.js Marker Generator](https://ar-js-org.github.io/AR.js/three.js/examples/marker-training/examples/generator.html)

2. **Settings**:
   - Set Pattern Type: `Barcode`
   - Set Marker Value: `0` (matches the value in marker.html)
   - Leave other settings as default
   - Click "Download Marker"

3. **Print or Display**:
   - Print the marker on paper (works best at A4 size)
   - Or display it on another screen
   - Ensure good lighting and contrast

### Embedding in QR Codes

You can embed a barcode marker inside a QR code:

1. Create a QR code with your desired content
2. Add the barcode marker image as the logo/center of the QR code
3. Ensure the marker has sufficient contrast and size
4. Test that both the QR code and AR tracking work

### Testing Your Marker

1. Open `marker.html` on your device
2. Allow camera permissions
3. Point your camera at the barcode marker
4. The 3D can should appear on the marker

## Location-Based AR Mode

### Setting GPS Coordinates

Edit `location.html` and update the coordinates:

```html
<a-entity
    gps-new-entity-place="latitude: YOUR_LAT; longitude: YOUR_LON"
>
```

### Finding Coordinates

1. Use Google Maps: Right-click on a location → "What's here?"
2. Use your phone's GPS coordinates app
3. For testing, use coordinates near your current location

### Testing Location-Based AR

1. Go outside (GPS works best outdoors)
2. Open `location.html` on your device
3. Allow camera and location permissions
4. Walk towards the GPS coordinates
5. The 3D can appears when you're close to the location

## Tips

- **Marker AR**: Best for controlled environments, demos, exhibitions
- **Location AR**: Best for outdoor exploration, scavenger hunts, tours
- Always test in the actual environment before deploying
- HTTPS is required for camera and GPS permissions
