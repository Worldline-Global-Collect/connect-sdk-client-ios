Pod::Spec.new do |s|

  s.name          = "WorldlineConnectSDK"
  s.version       = "6.0.0"
  s.summary       = "Worldline Connect iOS SDK"
  s.description   = <<-DESC
                    This native iOS SDK facilitates handling payments in your apps
                    using the Worldline Global Collect platform of Worldline Global Collect.
                    DESC

  s.homepage      = "https://github.com/Worldline-Global-Collect/connect-sdk-client-ios"
  s.license       = { :type => "MIT", :file => "LICENSE.txt" }
  s.author        = "Worldline Connect"
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/Worldline-Global-Collect/connect-sdk-client-ios.git", :tag => s.version }
  s.source_files  = "WorldlineConnectSDK/**/*.{h,m}"
  s.resource      = "WorldlineConnectSDK/WorldlineConnectSDK.bundle"

end
