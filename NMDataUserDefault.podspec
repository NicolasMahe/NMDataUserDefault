Pod::Spec.new do |s|
  s.name             = 'NMDataUserDefault'
  s.version          = '0.0.2'
  s.summary          = 'Save data in UserDefault with ease'
  s.description      = <<-DESC
Save data in UserDefault with ease. Type, notification and in memory.
                       DESC

  s.homepage         = 'https://github.com/NicolasMahe/NMDataUserDefault'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nicolas Mahé' => 'nicolas@mahe.me' }
  s.source           = { :git => 'https://github.com/NicolasMahe/NMDataUserDefault.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.frameworks = 'UIKit'

  s.source_files = 'NMDataUserDefault/**/*.swift'
end
