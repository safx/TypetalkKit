Pod::Spec.new do |s|
  s.name         = "TypetalkKit"
  s.version      = "0.2.9"
  s.summary      = "An unofficial web API client for Typetalk, a web service for team disscussions."
  s.homepage     = "https://github.com/safx/TypetalkKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "MATSUMOTO Yuji" => "safxdev@gmail.com" }
  s.source       = { :git => "https://github.com/safx/TypetalkKit.git", :tag => s.version }
  s.source_files = "Source/**/*.swift"
  s.ios.deployment_target = "8.3"
  s.osx.deployment_target = "10.10"
  s.dependency     "Alamofire", '~> 1.2.1'
  s.dependency     "JSONHelper", '~> 1.5.4'
  s.dependency     "Starscream", '~> 0.9.3'
  s.requires_arc = true
end
