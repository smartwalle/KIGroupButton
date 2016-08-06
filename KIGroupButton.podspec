Pod::Spec.new do |s|
  s.name         = "KIGroupButton"
  s.version      = "0.0.6"
  s.summary      = "KIGroupButton"
  s.description  = <<-DESC
                  KIGroupButton.
                   DESC

  s.homepage     = "https://github.com/smartwalle/KIGroupButton"
  s.license      = "MIT"
  s.author       = { "SmartWalle" => "smartwalle@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/smartwalle/KIGroupButton.git", :tag => "#{s.version}" }
  s.source_files = "KIGroupButton/KIGroupButton/*.{h,m}", "KIGroupButton/KIRadioButton/*.{h,m}", "KIGroupButton/KICheckBox/*.{h,m}"
  s.requires_arc = true
end
