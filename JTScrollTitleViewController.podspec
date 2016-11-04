Pod::Spec.new do |s|
    s.name         = 'JTScrollTitleViewController'
    s.version      = '1.0.1'
    s.summary      = 'An easy way to use a scrollable title bar in a view controller'
    s.homepage     = 'https://github.com/abchtv/JTScrollTitleViewController'
    s.license      = 'MIT'
	s.platform     = :ios
    s.authors      = {'Jorton HUANG' => '563260512@qq.com'}
	s.ios.deployment_target = '8.0'
    s.source       = {:git => 'https://github.com/abchtv/JTScrollTitleViewController.git', :tag => s.version}
    s.source_files = 'JTScrollTitleViewController/**/*.{h,m}'
    s.requires_arc = true
end
