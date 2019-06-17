if Object.const_defined?('NewGoogleRecaptcha')
  NewGoogleRecaptcha.setup do |config|
    config.site_key   = "6LeRLakUAAAAAF7l-9OVwZ8eefKxv6i6us4BtKf_"
    config.secret_key = "6LeRLakUAAAAABS2C4H83rLEC3BL382S-qx-CyXg"
    config.minimum_score = 0.5
  end
end
