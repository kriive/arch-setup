#!/bin/sh

set -eo pipefail

echo "Arch Linux install script by @kriive"
echo ""

read -s -p "Enter the disk encryption password: " disk_encryption_password
echo ""
read -s -p "Enter the disk encryption password, again: " disk_encryption_password_check 
echo ""

if [ "$disk_encryption_password" != "$disk_encryption_password_check" ]; then
    echo "The two encryption passwords do not match. Exiting."
    exit 1
fi
echo ""

read -s -p "Enter the user password: " user_password
echo ""
read -s -p "Enter the user password, again: " user_password_check 
echo ""

if [ "$disk_encryption_password" != "$disk_encryption_password_check" ]; then
    echo "The two user passwords do not match. Exiting."
    exit 1
fi

echo "We're about to install Arch Linux. This will erase EVERYTHING on your hard drive."
while true; do
    read -p "Want to continue? [Yy/Nn] " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

FILENAME="$(mktemp)"

cp ./archinstall/creds.json.tmpl "$FILENAME"

sed -i -e "s/@@encryption@@/${disk_encryption_password}/g" "$FILENAME"
sed -i -e "s/@@password@@/${user_password}/g" "$FILENAME"

set +e
archinstall --config ./archinstall/config.json --creds "$FILENAME" --disk_layout ./archinstall/disk.json --silent

# Remove the user credentials as soon as possible.
rm "$FILENAME"
rm /var/log/archinstall/user_credentials.json
