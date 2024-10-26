#!/bin/bash
echo "Rendering models."
cat model-list.txt | parallel {}

echo "Makeing a ZIP archive and removing the STLs after that."
if command -v advzip > /dev/null
then
    advzip -a -4 -i 15 Handheld-PicoRX.zip *.stl Build.md "CC BY-SA 4.0.txt" Readme
else
    zip -v9 Handheld-PicoRX.zip *.stl Build.md "CC BY-SA 4.0.txt" Readme
fi
rm *.stl
