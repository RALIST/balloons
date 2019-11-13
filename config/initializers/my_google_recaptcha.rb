if Object.const_defined?('MyGoogleRecaptcha')
  MyGoogleRecaptcha.setup do |config|
    config.site_key   = "6LeRLakUAAAAAF7l-9OVwZ8eefKxv6i6us4BtKf_"
    config.secret_key = "6LeRLakUAAAAABS2C4H83rLEC3BL382S-qx-CyXg"
    config.minimum_score = 0.5
    config.onload_function = 'myCallback'
  end
end
