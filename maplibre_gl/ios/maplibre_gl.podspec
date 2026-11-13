#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'maplibre_gl'
  s.version          = '0.27.0'
  s.summary          = 'MapLibre GL Flutter plugin'
  s.description      = <<-DESC
MapLibre GL Flutter plugin.
                       DESC
  s.homepage         = 'https://maplibre.org'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'MapLibre' => 'info@maplibre.org' }
  s.source           = { :path => '.' }
  s.source_files = 'maplibre_gl/Sources/maplibre_gl/**/*'
  s.dependency 'Flutter'
  # anny's MapLibre Native build with symbol-height-offset (see ../../native/README.md), as in Package.swift
  s.vendored_frameworks = 'maplibre_gl/MapLibre.xcframework'
  s.swift_version = '5.0'
  s.ios.deployment_target = '15.0'
end

