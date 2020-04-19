module MyGoogleRecaptcha
  class Railtie < ::Rails::Railtie
    initializer 'my_google_recaptcha.helpers' do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, MyGoogleRecaptcha::ViewExt
      end
    end
  end
end