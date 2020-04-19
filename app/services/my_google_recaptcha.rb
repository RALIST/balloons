require './lib/my_google_recaptcha/railtie'
require './lib/my_google_recaptcha/view_ext'
require './lib/my_google_recaptcha/validator'

module MyGoogleRecaptcha

  def self.site_key
    "6LeRLakUAAAAAF7l-9OVwZ8eefKxv6i6us4BtKf_"
  end

  def self.secret_key
    "6LeRLakUAAAAABS2C4H83rLEC3BL382S-qx-CyXg"
  end

  def self.minimum_score
    0.5
  end

  def self.onload_function
    'myCallback'
  end

  def self.human?(token, action, minimum_score = self.minimum_score, model = nil)
    is_valid = MyGoogleRecaptcha::Validator.valid?(token, action, minimum_score)
    if model && !is_valid
      model.errors.add(:base, self.i18n("my_google_recaptcha.errors.verification_human", "Looks like you are not a human"))
    end
    is_valid
  end

  def self.i18n(key, default)
    if defined?(I18n)
      I18n.translate(key, default: default)
    else
      default
    end
  end
end
