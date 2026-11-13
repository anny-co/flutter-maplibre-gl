# anny's MapLibre Native build

The plugin ships its own MapLibre Native instead of the upstream packages, for one feature upstream lacks:
`symbol-height-offset` (MapLibre GL JS 6.6, maplibre-native#1929). It draws a symbol layer's names, icons and
dots at a height in metres, for drawing, placement and collision alike, so labels stand on a raised floor of a
3D indoor map.

- `symbol-height-offset.patch`: the change, on maplibre-native tag `android-v13.5.0` (core of 2026-08-13).
  The property is constant or zoom-dependent per layer (GL JS also takes feature data). It raises the tile
  matrix of the layer's symbols (`SymbolBucket::elevatedMatrix`): the shaders, the placement and the collision
  index all project through it. No shader or vertex format changes.
- Android: `maplibre_gl/android/maven/` holds `org.maplibre.gl:android-sdk-opengl:13.5.0-anny.1` (the official
  13.5.0 POM with this version; the AAR without its prefab headers). arm64-v8a only for now.
- iOS: `maplibre_gl/ios/maplibre_gl/MapLibre.xcframework` (device arm64, simulator arm64), minimum iOS 15:
  Xcode 27's libc++ no longer builds for iOS 12.

## Rebuild

```sh
git clone --depth 1 --branch android-v13.5.0 https://github.com/maplibre/maplibre-native.git
cd maplibre-native && git submodule update --init --depth 1 --recursive
git apply ../flutter-maplibre-gl/native/symbol-height-offset.patch

# iOS (bazelisk): minimum iOS 15 and the arm64 simulator only, as in the patch
bazel build //platform/ios:MapLibre.dynamic --//:renderer=metal --compilation_mode=opt --copt=-Oz
# → bazel-bin/platform/ios/MapLibre.dynamic.xcframework.zip, unzip into maplibre_gl/ios/maplibre_gl/

# Android (JDK 21, ANDROID_HOME set); leave out -Pmaplibre.abis for every ABI
cd platform/android && ./gradlew :MapLibreAndroid:assembleOpenglRelease -Pmaplibre.abis=arm64-v8a
# → MapLibreAndroid/build/outputs/aar/MapLibreAndroid-opengl-release.aar: drop prefab/, rename to
#   android-sdk-opengl-13.5.0-anny.1.aar in maplibre_gl/android/maven/org/maplibre/gl/android-sdk-opengl/13.5.0-anny.1/
```

Drop all of this once MapLibre Native releases `symbol-height-offset`: back to the upstream dependency in
`maplibre_gl/android/build.gradle`, `Package.swift` and `maplibre_gl.podspec`.
