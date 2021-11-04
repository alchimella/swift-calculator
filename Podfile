platform :ios, '9.0'

def shared_pods
    pod 'FBSDKLoginKit'
    pod 'GoogleSignIn'
end

target 'swift-calculator' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for swift-calculator
  shared_pods
  
  target 'swift-calculatorTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'swift-calculatorUITests' do
    # Pods for testing
  end

end
