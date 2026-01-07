#!/bin/bash

# Recursion Guard: Prevent the script from re-triggering itself.
LOCKFILE="/tmp/huddle_interceptor.lock"
COOLDOWN_MS=1500

# Initial check to break loops
if [ -f "$LOCKFILE" ]; then
    LAST_RUN=$(cat "$LOCKFILE")
    NOW=$(date +%s%N)
    if [ $(( (NOW - LAST_RUN) / 1000000 )) -lt $COOLDOWN_MS ]; then
        exit 0
    fi
fi

update_lock() {
    date +%s%N > "$LOCKFILE"
}

send_virtual_key() {
    xdotool windowactivate "$ACTIVE_ID"
    xdotool windowfocus "$ACTIVE_ID"
    sleep 0.1 # Increased delay for Electron to settle
    update_lock
    xdotool keydown ctrl keydown shift key h
    sleep 0.05
    xdotool keyup h keyup shift keyup ctrl
}

# Get active window info (Class and Title)
ACTIVE_ID=$(xdotool getactivewindow)
INFO=$(xprop -id "$ACTIVE_ID" WM_CLASS _NET_WM_NAME)
WM_CLASS=$(echo "$INFO" | grep "WM_CLASS" | awk -F '"' '{print $4}')
WM_NAME=$(echo "$INFO" | grep "_NET_WM_NAME" | cut -d '"' -f 2)
CLASS_LOWER=$(echo "$WM_CLASS" | tr '[:upper:]' '[:lower:]')

if [[ "$CLASS_LOWER" == *"wezterm"* ]]; then
    # Use WezTerm CLI for better performance
    wezterm cli activate-pane-direction Left
elif [[ "$CLASS_LOWER" == *"slack"* ]]; then
    # Bypass prompt if already in a huddle window
    if [[ "$WM_NAME" == *"Huddle"* ]]; then
        send_virtual_key
        exit 0
    fi

    # Clear modifiers before the dialog to prevent "stuck" keys
    xdotool keyup Control_L Control_R Shift_L Shift_R

    # Use GJS (GNOME JavaScript) to show a native dialog.
    if gjs -c '
        imports.gi.versions.Gtk = "3.0";
        const Gtk = imports.gi.Gtk;
        Gtk.init(null);
        let dialog = new Gtk.MessageDialog({
            message_type: Gtk.MessageType.QUESTION,
            buttons: Gtk.ButtonsType.YES_NO,
            text: "Slack Huddle",
            secondary_text: "Start a huddle?"
        });
        let response = dialog.run();
        dialog.destroy();
        if (response !== Gtk.ResponseType.YES) imports.system.exit(1);
    '; then
        send_virtual_key
    fi
else
    send_virtual_key
fi
