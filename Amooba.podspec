Pod::Spec.new do |s|
  s.name             = 'Amooba'
  s.version          = '0.1.0'
  s.summary          = 'An declarative animation framework for Swift'

  s.description      = <<-DESC
Easily chain view animations without having to use the completion of UIView.animate
                       DESC

  s.homepage         = 'https://github.com/stickerbox/Amooba'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jordan Dixon' => 'jordan.d@me.com' }
  s.source           = { :git => 'https://github.com/stickerbox/Amooba.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'AnimationFramework/*.swift'

end
