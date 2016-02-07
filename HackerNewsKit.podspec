#
#  Be sure to run `pod spec lint HackerNewsKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "HackerNewsKit"
s.version      = "1.03"
s.summary      = "An Objective-C wrapper for the Hacker News API"
s.description  = <<-DESC
HackerNewsKit is an unofficial iOS API for Hacker News.  It comes with no dependancies, making all communication using NSURLSession.
DESC
s.homepage     = "https://github.com/skyefreeman/HackerNewsKit"
s.license      = "MIT"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "Skye Freeman" => "skyefreeman@icloud.com" }
s.social_media_url   = "http://twitter.com/ImSkyeFreeman"
s.platform     = :ios
s.source       = { :git => "https://github.com/skyefreeman/HackerNewsKit.git", :tag => s.version.to_s }
s.source_files  = "HackerNewsRequestModel/*.{h,m}", "HackerNewsKit.h"
s.public_header_files = "*.h"
s.requires_arc = true
end
