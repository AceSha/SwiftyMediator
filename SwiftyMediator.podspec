Pod::Spec.new do |s|

  s.name         = 'SwiftyMediator'
  s.version      = '0.2.0'
  s.summary      = 'Pure Swifty Mediator'

  s.description  = <<-DESC
                    this is SwiftyMediator, easiest way to route viewControllers in swift
                   DESC

  s.homepage     = 'https://github.com/AceSha/SwiftyMediator'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = 'shayuan'

  s.platform     = :ios, '8.0'

  s.source       = { :git => 'https://github.com/AceSha/SwiftyMediator.git', :tag => s.version.to_s }

  s.default_subspec = 'Core'

  s.subspec 'Core' do |c|
    c.source_files = 'SwiftyMediator/Classes/Core/**/*'
  end

  s.subspec 'Routable' do |r|
    r.source_files = 'SwiftyMediator/Classes/Routable/**/*'
    r.dependency 'SwiftyMediator/Core'
  end

end
