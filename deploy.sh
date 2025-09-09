#!/bin/bash

# Claude2API Render Deployment Script
# This script helps prepare and deploy Claude2API to Render

set -e

echo "🚀 Claude2API Render Deployment Helper"
echo "======================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "main.go" ]; then
    print_error "main.go not found. Please run this script from the claude2api project root."
    exit 1
fi

print_status "Checking project structure..."

# Verify required files exist
required_files=("Dockerfile" "render.yaml" ".dockerignore" "RENDER_DEPLOYMENT.md")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        print_success "✓ $file exists"
    else
        print_error "✗ $file missing"
        exit 1
    fi
done

# Check if .env exists and warn about environment variables
if [ -f ".env" ]; then
    print_warning "Found .env file. Remember to set environment variables in Render console:"
    echo "  - SESSIONS (required)"
    echo "  - APIKEY (required)"
    echo "  - PROXY (optional)"
else
    print_warning "No .env file found. Don't forget to configure environment variables in Render."
fi

# Validate Go code
print_status "Running Go module verification..."
if go mod verify; then
    print_success "✓ Go modules verified"
else
    print_error "✗ Go module verification failed"
    exit 1
fi

# Test build
print_status "Testing Go build..."
if go build -o /tmp/claude2api-test ./main.go; then
    print_success "✓ Go build successful"
    rm -f /tmp/claude2api-test
else
    print_error "✗ Go build failed"
    exit 1
fi

# Test Docker build if Docker is available
if command -v docker &> /dev/null; then
    print_status "Testing Docker build..."
    if docker build -t claude2api-test . > /dev/null 2>&1; then
        print_success "✓ Docker build successful"
        docker rmi claude2api-test > /dev/null 2>&1
    else
        print_warning "Docker build failed, but this won't prevent Render deployment"
    fi
else
    print_warning "Docker not available for local testing"
fi

echo ""
echo "🎉 Pre-deployment checks complete!"
echo ""
echo "Next Steps:"
echo "==========="
echo "1. 📤 Push your code to GitHub:"
echo "   git add ."
echo "   git commit -m \"Optimize for Render deployment\""
echo "   git push origin main"
echo ""
echo "2. 🌐 Go to Render Dashboard: https://dashboard.render.com"
echo "3. ➕ Create a new Web Service"
echo "4. 🔗 Connect your GitHub repository"
echo "5. ⚙️  Render will detect render.yaml automatically"
echo "6. 🔑 Set environment variables:"
echo "   - SESSIONS=sk-ant-sid01-your-session-tokens"
echo "   - APIKEY=your-api-key"
echo "7. 🚀 Deploy!"
echo ""
echo "📖 For detailed instructions, see: RENDER_DEPLOYMENT.md"
echo ""
print_success "Ready for deployment! 🎊"