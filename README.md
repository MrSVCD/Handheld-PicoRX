# Handheld-PicoRX
3D models for making a handheld PicoRX on a 100x80mm PCB, Manhattan style.

The STL files in Handheld-PicoRX.zip is under the CC BY-SA 4.0 license. The ZIP file also contains a copy of Build.md for offline reading.

## Building
Read [Build.md](Build.md).

## Rendering

Rending needs the following software:

* OpenSCAD
* GNU Parallel
* advzip from advancecomp **or** zip from Info-Zip

To render run render.sh

```
$> ./render.sh
```

This will create Handheld-PicoRX.zip with all the STLs inside as well as `Build.md` `Readme` and `CC BY-SA 4.0.txt`.
