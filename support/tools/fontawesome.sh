#!/bin/sh
set -ex
icons="facebook facebook-square instagram instagram-square"

dest=static/fontawesome
url=https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/advanced-options/raw-svg/brands
url=https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/brands

mkdir -p "${dest}"
for icon in $icons; do
  icon="${icon}.svg"
  wget -O "${dest}/${icon}" "${url}/${icon}"
done
