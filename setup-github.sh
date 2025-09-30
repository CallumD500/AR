#!/bin/bash

# GitHub Pages Setup Script for WebAR Experience
# This script helps you quickly set up GitHub Pages deployment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║     GitHub Pages Setup - WebAR Experience                 ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Error: git is not installed${NC}"
    echo "Please install git first: https://git-scm.com/"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ Error: npm is not installed${NC}"
    echo "Please install Node.js first: https://nodejs.org/"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites check passed${NC}\n"

# Get GitHub username
echo -e "${BLUE}Step 1: GitHub Repository Information${NC}"
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter your repository name: " REPO_NAME

echo -e "\n${YELLOW}Your site will be available at:${NC}"
echo "https://${GITHUB_USER}.github.io/${REPO_NAME}/"
echo ""
read -p "Is this correct? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo -e "${RED}Setup cancelled${NC}"
    exit 0
fi

# Update vite.config.github.js with repo name
echo -e "\n${BLUE}Step 2: Configuring build settings${NC}"
if [ -f "vite.config.github.js" ]; then
    # Create temporary config with repo name
    sed "s/const repoName = process.env.VITE_REPO_NAME || '';/const repoName = process.env.VITE_REPO_NAME || '${REPO_NAME}';/" vite.config.github.js > vite.config.github.tmp
    mv vite.config.github.tmp vite.config.github.js
    echo -e "${GREEN}✓ Configuration updated${NC}"
else
    echo -e "${RED}❌ Error: vite.config.github.js not found${NC}"
    exit 1
fi

# Install dependencies
echo -e "\n${BLUE}Step 3: Installing dependencies${NC}"
npm install
echo -e "${GREEN}✓ Dependencies installed${NC}"

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    echo -e "\n${BLUE}Step 4: Initializing Git repository${NC}"
    git init
    echo -e "${GREEN}✓ Git initialized${NC}"
else
    echo -e "\n${YELLOW}ℹ Git repository already initialized${NC}"
fi

# Add gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo -e "\n${BLUE}Creating .gitignore${NC}"
    cat > .gitignore << EOF
# Dependencies
node_modules/
package-lock.json

# Build output
dist/
dist-ssr/

# Environment files
.env
.env.local

# Editor
.DS_Store
*.swp
*.swo

# SSL certificates
*.pem
EOF
    echo -e "${GREEN}✓ .gitignore created${NC}"
fi

# Create .gitattributes for LFS if needed
if [ ! -f ".gitattributes" ]; then
    cat > .gitattributes << EOF
*.glb filter=lfs diff=lfs merge=lfs -text
*.gltf filter=lfs diff=lfs merge=lfs -text
EOF
    echo -e "${GREEN}✓ .gitattributes created for 3D models${NC}"
fi

# Add all files
echo -e "\n${BLUE}Step 5: Preparing files for commit${NC}"
git add .
echo -e "${GREEN}✓ Files staged${NC}"

# Create initial commit if this is first commit
if ! git rev-parse HEAD &> /dev/null; then
    echo -e "\n${BLUE}Creating initial commit${NC}"
    git commit -m "Initial commit: WebAR experience with CI/CD pipeline"
    echo -e "${GREEN}✓ Initial commit created${NC}"
fi

# Set branch to main
echo -e "\n${BLUE}Step 6: Setting branch to main${NC}"
git branch -M main
echo -e "${GREEN}✓ Branch set to main${NC}"

# Add remote
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
echo -e "\n${BLUE}Step 7: Adding GitHub remote${NC}"
if git remote | grep -q "origin"; then
    echo -e "${YELLOW}ℹ Remote 'origin' already exists${NC}"
    git remote set-url origin $REMOTE_URL
    echo -e "${GREEN}✓ Remote URL updated${NC}"
else
    git remote add origin $REMOTE_URL
    echo -e "${GREEN}✓ Remote added${NC}"
fi

# Push to GitHub
echo -e "\n${BLUE}Step 8: Pushing to GitHub${NC}"
echo -e "${YELLOW}You may be prompted for GitHub credentials${NC}"
echo ""
read -p "Ready to push to GitHub? (y/n): " PUSH_CONFIRM

if [ "$PUSH_CONFIRM" = "y" ] || [ "$PUSH_CONFIRM" = "Y" ]; then
    if git push -u origin main; then
        echo -e "${GREEN}✓ Code pushed to GitHub${NC}"
    else
        echo -e "${RED}❌ Push failed. You may need to:${NC}"
        echo "  1. Create the repository on GitHub first"
        echo "  2. Set up authentication (SSH key or Personal Access Token)"
        echo "  3. Run: git push -u origin main"
    fi
else
    echo -e "${YELLOW}ℹ Skipped push. Run manually: git push -u origin main${NC}"
fi

# Summary
echo -e "\n${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║     Setup Complete! 🎉                                    ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}✅ Next Steps:${NC}\n"
echo "1. Go to: https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo "2. Click 'Settings' → 'Pages'"
echo "3. Under 'Source', select 'GitHub Actions'"
echo "4. Wait ~2 minutes for deployment"
echo "5. Your site will be live at:"
echo -e "   ${BLUE}https://${GITHUB_USER}.github.io/${REPO_NAME}/${NC}\n"

echo -e "${YELLOW}📚 Documentation:${NC}"
echo "   - Full guide: GITHUB_CICD_GUIDE.md"
echo "   - Testing: TESTING_GUIDE.md"
echo "   - Deployment: DEPLOYMENT.md"

echo -e "\n${GREEN}Happy deploying! 🚀${NC}\n"

