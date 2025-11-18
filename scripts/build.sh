#!/bin/bash

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Please install jq first."
    exit 1
fi

# Function to extract description from BASIC file
get_description() {
    local file="$1"
    head -20 "$file" | grep -i "^[0-9]*.*REM.*DESC\|^[0-9]*.*REM.*DESCRIPTION" | sed 's/^[0-9]*.*REM.*DESC[RIPTION]*[[:space:]]*[:]*[[:space:]]*//' | head -1
}

# Function to extract category from BASIC file
get_category() {
    local file="$1"
    local category=$(head -20 "$file" | grep -i "^[0-9]*.*REM.*CATEGORY" | sed 's/^[0-9]*.*REM.*CATEGORY[[:space:]]*[:]*[[:space:]]*//' | head -1)
    if [ -n "$category" ]; then
        echo "$category"
    else
        echo "Miscellaneous"
    fi
}

# Function to build descriptions JSON using jq
build_descriptions() {
    echo "{}" | jq '.' > "./public/demos/descriptions.json"
    
    for bas_file in demos/*.bas; do
        if [ -f "$bas_file" ]; then
            tap_file="./public/demos/$(basename "$bas_file" .bas).tap"
            if [ -f "$tap_file" ]; then
                basename=$(basename "$bas_file" .bas)
                desc=$(get_description "$bas_file")
                category=$(get_category "$bas_file")
                
                if [ -n "$desc" ]; then
                    jq --arg key "$basename.tap" --arg desc "$desc" --arg cat "$category" '. + {($key): {description: $desc, category: $cat}}' "./public/demos/descriptions.json" > tmp.json && mv tmp.json "./public/demos/descriptions.json"
                fi
            fi
        fi
    done
    
    echo "Generated descriptions file with categories"
}

if [ -n "$1" ]; then
    file="demos/$1.bas"
    if [ -f "$file" ]; then
        echo "Building $file"
        ./zxbasic/zxbc.py "$file" -o "./public/demos/$(basename "$file" .bas).tap" --output-format=tap --BASIC --autorun
        build_descriptions
    else
        echo "Error: File '$file' not found."
        exit 1
    fi
else
    for file in demos/*.bas; do
        if [ -f "$file" ]; then
            echo "Building $file"
            ./zxbasic/zxbc.py "$file" -o "./public/demos/$(basename "$file" .bas).tap" --output-format=tap --BASIC --autorun
        fi
    done
    build_descriptions
fi