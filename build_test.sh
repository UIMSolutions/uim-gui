#!/bin/bash
# Build and test script for uim-gnome library

set -e  # Exit on error

echo "=========================================="
echo "UIM GNOME Library - Build & Test Script"
echo "=========================================="
echo ""

# Check for required system libraries
echo "Checking for GTK4 development libraries..."
if ! pkg-config --exists gtk4; then
    echo "ERROR: GTK4 development libraries not found!"
    echo "Please install: sudo apt-get install libgtk-4-dev libglib2.0-dev"
    exit 1
fi
echo "✓ GTK4 found: $(pkg-config --modversion gtk4)"
echo ""

# Check D compiler
echo "Checking D compiler..."
if ! command -v dmd &> /dev/null && ! command -v ldc2 &> /dev/null; then
    echo "ERROR: No D compiler found (dmd or ldc2)!"
    exit 1
fi
if command -v dmd &> /dev/null; then
    echo "✓ DMD found: $(dmd --version | head -1)"
elif command -v ldc2 &> /dev/null; then
    echo "✓ LDC found: $(ldc2 --version | head -1)"
fi
echo ""

# Build library
echo "Building uim-gui library..."
dub build
echo "✓ Library built successfully"
echo ""

# Build examples
echo "Building examples..."
cd gnome/examples

echo "  Building hello.d..."
dub build --single hello.d
echo "  ✓ hello built"

echo "  Building formgrid.d..."
dub build --single formgrid.d
echo "  ✓ formgrid built"

echo "  Building texteditor.d..."
dub build --single texteditor.d
echo "  ✓ texteditor built"

cd ../..
echo "✓ All examples built successfully"
echo ""

echo "=========================================="
echo "Build Complete!"
echo "=========================================="
echo ""
echo "To run examples:"
echo "  cd gnome/examples"
echo "  ./hello"
echo "  ./formgrid"
echo "  ./texteditor"
echo ""
