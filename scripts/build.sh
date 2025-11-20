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

    # Helper to add an entry: args (key, bas_file)
    add_entry() {
        local key="$1"
        local bas_file="$2"
        if [ -f "$bas_file" ]; then
            local desc=$(get_description "$bas_file")
            local category=$(get_category "$bas_file")
            local is_external_flag="$3"
            if [ -n "$desc" ]; then
                if [ "$is_external_flag" = "true" ]; then
                    jq --arg key "$key" --arg desc "$desc" --arg cat "$category" '. + {($key): {description: $desc, category: $cat, is_external: true}}' "./public/demos/descriptions.json" > tmp.json && mv tmp.json "./public/demos/descriptions.json"
                else
                    jq --arg key "$key" --arg desc "$desc" --arg cat "$category" '. + {($key): {description: $desc, category: $cat}}' "./public/demos/descriptions.json" > tmp.json && mv tmp.json "./public/demos/descriptions.json"
                fi
            fi
        fi
    }

    # Process BAS files in top-level demos/
    for bas_file in demos/*.bas; do
        if [ -f "$bas_file" ]; then
            basename=$(basename "$bas_file" .bas)
            # Prefer .tap then .tzx
            if [ -f "./public/demos/$basename.tap" ]; then
                add_entry "$basename.tap" "$bas_file" "false"
            elif [ -f "./public/demos/$basename.tzx" ]; then
                add_entry "$basename.tzx" "$bas_file" "false"
            fi
        fi
    done

    # Also process external BAS files and look for matching TZX/TAP in public/demos
    for bas_file in demos/external/*.bas; do
        if [ -f "$bas_file" ]; then
            basename=$(basename "$bas_file" .bas)
            if [ -f "./public/demos/$basename.tap" ]; then
                add_entry "$basename.tap" "$bas_file" "true"
            elif [ -f "./public/demos/$basename.tzx" ]; then
                add_entry "$basename.tzx" "$bas_file" "true"
            fi
        fi
    done

    echo "Generated descriptions file with categories"
}

if [ -n "$1" ]; then
    file="demos/$1.bas"
    if [ -f "$file" ]; then
        echo "Building $file"
        ./zxbasic/zxbc.py "$file" -o "./public/demos/$(basename "$file" .bas).tap" --output-format=tap --BASIC --autorun --expect-warnings=999999 --hide-warning-codes

        # Copy any matching external TAP/TZX for this demo
        base=$(basename "$file" .bas)
        if [ -d "demos/external" ]; then
            for ext in tap tzx; do
                if [ -f "demos/external/$base.$ext" ]; then
                    cp "demos/external/$base.$ext" "./public/demos/"
                fi
            done
        fi

        build_descriptions
    else
        echo "Error: File '$file' not found."
        exit 1
    fi
else
    # First, build all top-level demos to TAP
    for file in demos/*.bas; do
        if [ -f "$file" ]; then
            echo "Building $file"
            ./zxbasic/zxbc.py "$file" -o "./public/demos/$(basename "$file" .bas).tap" --output-format=tap --BASIC --autorun --expect-warnings=999 --hide-warning-codes
        fi
    done

    # Copy external TAP/TZX files into public/demos
    if [ -d "demos/external" ]; then
        for f in demos/external/*.{tap,tzx}; do
            [ -e "$f" ] || continue
            echo "Copying external demo: $(basename "$f")"
            cp "$f" "./public/demos/"
        done
    fi

    build_descriptions
fi