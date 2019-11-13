module MyGoogleRecaptcha
  module ViewExt
    include ActionView::Helpers::TagHelper

    def include_recaptcha_js
      raw %Q{
        <script src=></script>
      }
    end

    def recaptcha_action(action)
      id = "my_google_recaptcha_token_#{SecureRandom.hex(10)}"
      raw %Q{
        <input name="my_google_recaptcha_token" type="hidden" id="#{id}"/>
        <script>
          grecaptcha.ready(function() {
            grecaptcha.execute(document.grecaptchaHandle, {action: "#{action}"}).then(function(token) {
              document.getElementById("#{id}").value = token;
            });
          });
        </script>
      }
    end
  end
end