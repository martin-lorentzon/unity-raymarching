## What is included in the UnityPackage
```
Assets/
├── Scripts/
│   └── HLSL/
│       └── RaymarchIntersect.hlsl
└── Scenes/
    └── Raymarch Example/
        ├── Raymarchv4SG.shadergraph
        ├── CameraFadeSG.shadergraph
        ├── VolumeCloud.exr
        ├── RaymarchMat.mat
        └── VolumetricClouds.unity
```
## Installation  
[![Download Unity Package](https://img.shields.io/badge/Download-.unitypackage-black?style=for-the-badge&logo=unity)](https://github.com/martin-lorentzon/unity-raymarching/releases/download/v1.0/RaymarchingAssets_1_0.unitypackage)
[![Version](https://img.shields.io/badge/version-v1.0-green?style=for-the-badge)](https://github.com/martin-lorentzon/unity-raymarching/releases/tag/v1.0)

1. Download the latest release with the button above
2. Drag and drop the .unitypackage file into Unity
3. Move the files where you want them, e.g. into Assets/Shaders
## Details
This project is a continuation of Unity's example raymarching shader shown in the repository [Unity-URP-Cookbook](https://github.com/NikLever/Unity-URP-Cookbook).

However it provides the additional properties of:
* Better handling **Object Intersections**  
(Would previously incorrectly render volume data behind other objects)
* **Camera Fading** (Fade the volume object when entering it)

The "Intersect" in the file name `RaymarchIntersect.hlsl` is purely there to differentiate the shader from Unity's own example of a raymarching shader and to hint at the added properties. It's otherwise a standard, minimal raymarching shader.

### Compatibility
Developed and tested using **Unity 6.4 (6000.4.6f1) - URP**