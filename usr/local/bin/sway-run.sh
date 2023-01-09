#!/usr/bin/bash

export PATH=$PATH:/home/kriive/.local/bin:/home/kriive/.cargo/bin

export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

# For Android Studio
export _JAVA_AWT_WM_NONREPARENTING=1
export STUDIO_JDK=/usr/lib/jvm/default

# For Gradle
export JAVA_HOME=/usr/lib/jvm/default

if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
	# https://github.com/swaywm/sway/issues/595
        export _JAVA_AWT_WM_NONREPARENTING=1
fi

export MOZ_ENABLE_WAYLAND=1

# Start the GNOME Keyring Daemon
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# This is used by virt-manager to avoid passing Super keybindings to
# guest VMs.
export SPICE_NOGRAB=1
	
exec sway

