# anny's MapLibre Native build

The plugin ships its own MapLibre Native instead of the upstream packages, for one feature upstream lacks:
`symbol-height-offset` (MapLibre GL JS 6.6, maplibre-native#1929). It draws a symbol layer's names and icons at a
height in metres, for drawing, placement and collision alike, so labels stand on a raised floor of a 3D indoor map.

- Android: `maplibre_gl/android/maven/` holds `org.maplibre.gl:android-sdk-opengl:<version>` (the official POM under
  our version; the AAR for every ABI, without its prefab headers), used by `maplibre_gl/android/build.gradle`.
- iOS: `maplibre_gl/ios/maplibre_gl/MapLibre.xcframework` (device arm64, simulator arm64 + x86_64), iOS 15 and up;
  `Package.swift` and `maplibre_gl.podspec` use it.

The patch, its MapLibre Native release and the build live in the anny mobile-apps repository,
`ci/maplibre-native/`: GitLab CI builds both libraries when that folder changes and, on main, commits them here.

Drop all of this once MapLibre Native releases `symbol-height-offset`: back to the upstream dependency in
`maplibre_gl/android/build.gradle`, `Package.swift` and `maplibre_gl.podspec`.
