#!/bin/bash

indir="$1"
outdir="$2"

mkdir -p "$outdir"

find "$indir" -type f -print0 | while IFS= read -r -d '' file; do
name=$(basename "$file")
main="${name%.*}"
ext="${name##*.}"

if [ "$main" == "$ext" ]; then
ext=""
else
ext=".$ext"
fi

newmain="$main"
col=1

while true; do
newname="${newmain}${ext}"
if [ ! -e "${outdir}/${newname}" ]; then
break
fi
newmain="${main}_${col}"
col=$((col + 1))
done

cp -- "$file" "${outdir}/${newname}"
done