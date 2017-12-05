
Pod::Spec.new do |s|

s.name         = "ARCarMovement"
s.version      = "1.0.1"
s.summary      = "Here Marker move as vehicles moves with turns as uber does in their app."

s.description  = <<-DESC
Achieve the Moving Marker(car) animation in iOS using the Google map with old and new coordinates animating bearing value the markers are moving.
DESC

s.homepage     = "https://github.com/antonyraphel/ARCarMovement"
s.screenshots  = "https://raw.githubusercontent.com/antonyraphel/ARCarMovement/30b4fa26fc4f14abaef5da147544db8d558b1c18/screenshot/image-1.png"

s.license      = { :type => "MIT", :file => "LICENSE" }
s.author    = "Antony Raphel"
s.social_media_url   = "https://twitter.com/antonypr717"
s.platform     = :ios, "9.0"
s.ios.deployment_target = '9.0'
s.source       = { :git => "https://github.com/antonyraphel/ARCarMovement.git", :tag => "v#{s.version}" }
s.source_files  = "ARCarMovement", "ARCarMovement/**/*.{swift}"
s.static_framework = true

#s.compiler_flags = '-ObjC', '$(inherited)'

#s.xcconfig     = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/GoogleMaps/Frameworks"' }

#s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

s.dependency 'GoogleMaps', '~> 2.0'
s.requires_arc = true
s.frameworks   = [
        "Accelerate",
        "CoreTelephony",
        "CoreText",
        "GLKit",
        "ImageIO",
        "OpenGLES",
        "QuartzCore"
      ]
s.libraries    = 'c++', 'z'
s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
s.vendored_frameworks = [
        "Maps/Frameworks/GoogleMaps.framework",
        "Maps/Frameworks/GoogleMapsCore.framework"
      ]

end

