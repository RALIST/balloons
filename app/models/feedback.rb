class Feedback < ApplicationRecord
  include Imageable
  has_attached_file :img, styles: { small: ['x150', :png] },
                          convert_options: { preview: '-quality 75 -strip -interlace Plane' },
                          processors: %i[thumbnail paperclip_optimizer],
                          filename_cleaner: Paperclip::FilenameCleaner.new(/\_-/),
                          default_url: 'https://d18psmjp7qnrxg.cloudfront.net/images/missing/small/missing_small.png'
  validates_attachment_content_type :img,
                                    content_type: ['image/jpeg', 'image/jpg', 'image/png']

  def variants
    {
      small: { width: 150, height: 150, process: :resize_to_fill},
      medium: { width: 300, height: 300, process: :resize_to_fill },
      large: { width: 800, height: 800, process: :resize_to_limit }
      }
  end

  def send_code_to_user
    new_code = rand(100_000..999_999)
    text =  'Ваш промокод на скидку 5%: ' + new_code.to_s
    phone = self.phone.tr('()+ ', '')
    message = MainsmsApi::Message.new(message: text,
                                      recipients: [phone])
    response = message.deliver

    if response.status == 'success'
      self.promocode = new_code
      save
    else
      print response
    end
  end
end
