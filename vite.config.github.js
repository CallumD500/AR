import { defineConfig } from 'vite';
import basicSsl from '@vitejs/plugin-basic-ssl';

// Get repository name from package.json or environment variable
const repoName = process.env.VITE_REPO_NAME || '';
const isGitHubPages = process.env.GITHUB_ACTIONS === 'true';

export default defineConfig({
  // Root directory
  root: './',
  
  // Base public path - important for GitHub Pages!
  // For GitHub Pages: https://username.github.io/repo-name/
  // Set this to your repository name, or leave as '/' for custom domain
  base: isGitHubPages && repoName ? `/${repoName}/` : './',
  
  // Server configuration
  server: {
    port: 3000,
    https: true,
    host: '0.0.0.0',
    open: true,
    cors: true,
    strictPort: false,
  },
  
  // Build configuration for production
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    minify: 'terser',
    
    rollupOptions: {
      input: {
        main: './index.html',
        placement: './placement.html',
        marker: './marker.html',
        location: './location.html',
      },
      output: {
        manualChunks: undefined,
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
    
    assetsInlineLimit: 0,
    target: ['es2020', 'edge88', 'firefox78', 'chrome87', 'safari14'],
    
    terserOptions: {
      compress: {
        drop_console: false,
        drop_debugger: true,
        passes: 2
      },
      format: {
        comments: false
      }
    },
    
    reportCompressedSize: true,
    chunkSizeWarningLimit: 1000,
  },
  
  assetsInclude: ['**/*.glb', '**/*.gltf', '**/*.bin', '**/*.patt'],
  
  preview: {
    port: 4173,
    https: true,
    host: '0.0.0.0',
    cors: true,
    strictPort: false,
  },
  
  plugins: [
    basicSsl(),
  ],
  
  optimizeDeps: {
    exclude: []
  },
  
  publicDir: 'public',
});

