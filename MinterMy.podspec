Pod::Spec.new do |s|
  s.name             = 'MinterMy'
  s.version          = '0.1.6'
  s.summary          = 'A short description of MinterMy.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MinterTeam/minter-ios-my'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sidorov.panda' => 'ody344@gmail.com' }
  s.source           = { :git => 'https://github.com/MinterTeam/minter-ios-my.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'MinterMy/Classes/**/*'
  s.dependency 'MinterCore'
end
