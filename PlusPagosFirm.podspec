#
# Be sure to run `pod lib lint PlusPagosFirm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PlusPagosFirm'
  s.version          = '0.1.0'
  s.summary          = 'Encriptacion de PlusPagos'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Libreria para encriptar campos de boton de pago de PlusPagos'

  s.homepage         = 'https://sandboxpp.asjservicios.com.ar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'e699006c1788932c1bf62474df4b313e2588cef5' => 'andres.ceccoli@gmail.com' }
  s.source           = { :git => 'https://github.com/e699006c1788932c1bf62474df4b313e2588cef5/PlusPagosFirm.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PlusPagosFirm/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PlusPagosFirm' => ['PlusPagosFirm/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.swift_version = '4.1'
  
  s.dependency 'CryptoSwift'
end
