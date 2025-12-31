#!/bin/bash

# 1. Get the ID of the currently focused window
ACTIVE_ID=$(xdotool getactivewindow)

# 2. Get the window class (e.g., "Slack" or "wezterm")
WM_CLASS=$(xprop -id "$ACTIVE_ID" WM_CLASS | awk -F '"' '{print $4}')

# 3. Normalize to lowercase for robust matching
CLASS_LOWER=$(echo "$WM_CLASS" | tr '[:upper:]' '[:lower:]')

# 4. Logic: If Slack, ask. Otherwise, pass through.
if [[ "$CLASS_LOWER" == *"slack"* ]]; then
    # --default-cancel focuses the "No" button
    if zenity --question --title="Slack Huddle" --text="Start a huddle?" --default-cancel --no-wrap; then
        # User clicked "Yes" (exit code 0)
        # Small sleep ensures physical keys are released before xdotool sends virtual ones
        sleep 0.1 && xdotool key --window "$ACTIVE_ID" --clearmodifiers ctrl+shift+h
    fi
else
    # For WezTerm or other apps, pass the key combo through immediately
    sleep 0.1 && xdotool key --window "$ACTIVE_ID" --clearmodifiers ctrl+shift+h
fi
