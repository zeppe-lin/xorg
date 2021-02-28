#!/bin/bash
# Find missing dependencies for xorg pkgsrc collection.

PKGS=$(find . -name Pkgfile -exec dirname {} \; | sed 's/.\///g')
for p in $PKGS; do
	pkgman \
	--root=/dev/null \
	--no-std-config \
	--config-append="pkgsrcdir $PWD" \
	--config-append="pkgsrcdir $PWD/../opt" \
	--config-append="pkgsrcdir $PWD/../core" \
	dep --all --recursive $p | \
	awk -v p=$p '/not found/{print p":"$1}'
done

# End of file.
