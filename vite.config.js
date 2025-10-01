import { defineConfig } from 'vite';

export default defineConfig({
  // Root directory
  root: './',
  
  // Base public path for production
  base: './',
  
  // Server configuration
  server: {
    port: 3000,
    https: false, // Disabled HTTPS for local development
    host: 'localhost', // Use localhost only
    open: true, // Auto-open browser
    cors: true, // Enable CORS
    strictPort: false, // Try next port if 3000 is taken
  },
  
  // Build configuration for production
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    minify: 'terser',
    
    // Optimize chunks - don't try to chunk external CDN scripts
    rollupOptions: {
      input: {
        main: './index.html',
        placement: './placement.html',
        marker: './marker.html',
        location: './location.html',
      },
      output: {
        manualChunks: undefined, // Let Vite handle chunking automatically
        // Optimize asset file names
        assetFileNames: (assetInfo) => {
          const info = assetInfo.name.split('.');
          let extType = info[info.length - 1];
          if (/glb|gltf|bin/.test(extType)) {
            return `models/[name]-[hash][extname]`;
          }
          return `assets/[name]-[hash][extname]`;
        },
        chunkFileNames: 'assets/[name]-[hash].js',
        entryFileNames: 'assets/[name]-[hash].js',
      }
    },
    
    // Asset handling
    assetsInlineLimit: 0, // Don't inline assets, keep GLB files separate
    
    // Target modern browsers for WebAR
    target: ['es2020', 'edge88', 'firefox78', 'chrome87', 'safari14'],
    
    // Optimize for production
    terserOptions: {
      compress: {
        drop_console: false, // Keep console.logs for debugging (remove in final production if needed)
        drop_debugger: true,
        passes: 2
      },
      format: {
        comments: false
      }
    },
    
    // Report bundle size
    reportCompressedSize: true,
    chunkSizeWarningLimit: 1000,
  },
  
  // Handle 3D model files
  assetsInclude: ['**/*.glb', '**/*.gltf', '**/*.bin', '**/*.patt'],
  
  // Preview server (for testing production build)
  preview: {
    port: 4173,
    https: false,
    host: 'localhost',
    cors: true,
    strictPort: false,
  },
  
  // Plugin configuration
  plugins: [
    // basicSsl() disabled for local development
  ],
  
  // Optimize dependencies
  optimizeDeps: {
    exclude: [] // Don't exclude anything, let Vite optimize
  },
  
  // Public directory
  publicDir: 'public',
});

