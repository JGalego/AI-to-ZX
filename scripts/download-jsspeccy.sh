#!/bin/bash

# Download JSSpeccy script
# This script downloads the latest JSSpeccy emulator files

set -e  # Exit on any error

# Configuration
JSSPECCY_VERSION="3.2"
JSSPECCY_URL="https://github.com/gasman/jsspeccy3/releases/download/v${JSSPECCY_VERSION}/jsspeccy-${JSSPECCY_VERSION}.zip"
TARGET_DIR="./public/libs"
TEMP_FILE="/tmp/jsspeccy.zip"

echo "Downloading JSSpeccy v${JSSPECCY_VERSION}..."

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo "Error: curl is required but not installed. Please install curl first."
    exit 1
fi

# Check if unzip is available
if ! command -v unzip &> /dev/null; then
    echo "Error: unzip is required but not installed. Please install unzip first."
    exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "${TARGET_DIR}"

# Remove existing jsspeccy directory if it exists
if [ -d "${TARGET_DIR}/jsspeccy" ]; then
    echo "Removing existing JSSpeccy installation..."
    rm -rf "${TARGET_DIR}/jsspeccy"
fi

# Download JSSpeccy
echo "Downloading from ${JSSPECCY_URL}..."
if curl -L -f -o "${TEMP_FILE}" "${JSSPECCY_URL}"; then
    echo "Download successful."
else
    echo "Error: Failed to download JSSpeccy from ${JSSPECCY_URL}"
    exit 1
fi

# Extract JSSpeccy
echo "Extracting JSSpeccy..."
cd "${TARGET_DIR}"

# First, let's see what's in the zip file
echo "Examining zip contents..."
unzip -l "${TEMP_FILE}" | head -20

# Extract to a temporary directory first
mkdir -p temp_extract
if unzip -q "${TEMP_FILE}" -d temp_extract; then
    echo "Extraction to temp directory successful."
    
    # Find the jsspeccy directory in the extracted content
    if [ -d "temp_extract/jsspeccy" ]; then
        # If there's a jsspeccy folder, move its contents
        mv temp_extract/jsspeccy jsspeccy
        echo "Moved jsspeccy folder."
    elif [ -d "temp_extract" ]; then
        # If files are directly in temp_extract, assume they are jsspeccy files
        mv temp_extract jsspeccy
        echo "Moved extracted files to jsspeccy folder."
    else
        echo "Error: Could not find jsspeccy files in extraction"
        rm -rf temp_extract
        cd - > /dev/null
        exit 1
    fi
    
    # Clean up temp directory if it still exists
    rm -rf temp_extract
    echo "Extraction successful."
else
    echo "Error: Failed to extract JSSpeccy"
    rm -rf temp_extract
    cd - > /dev/null
    exit 1
fi
cd - > /dev/null

# Clean up
rm -f "${TEMP_FILE}"

echo "JSSpeccy v${JSSPECCY_VERSION} downloaded and installed successfully to ${TARGET_DIR}/jsspeccy"