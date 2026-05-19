#!/usr/bin/env sh -

# Get the file path.
FILE="$1"

# Do not bother processing a file that dos not exist or has zero size.
if [ ! -s "$FILE" ]; then exec cat; fi

# Based on the type of the file, use the appropriate tool to convert to plain text.
case "$FILE" in
    *.pdf)
        exec pdftotext - -
        ;;
    *.doc)
        # Extract text using macOS textutil, sending the output to stdout (-convert txt -stdout)
        # We handle errors gracefully by discarding stderr so ripgrep doesn't choke on unconvertible files
        exec textutil -convert txt -stdout "$FILE" 2>/dev/null
        ;;
    *.docx)
        # Extract text using macOS textutil, sending the output to stdout (-convert txt -stdout)
        # We handle errors gracefully by discarding stderr so ripgrep doesn't choke on unconvertible files
        exec textutil -convert txt -stdout "$FILE" 2>/dev/null
        ;;
    *)
        exec cat
        ;;
esac

# End of script
