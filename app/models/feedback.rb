class Feedback < ApplicationRecord
  has_attached_file :img, styles: { preview: ['x100', :png]},
                          convert_options: {
                                            preview: "-quality 60 -strip -interlace Plane"},
                          processors: [:thumbnail, :compression],
                          default_url: '/missing/:style/missing.png'
  validates_attachment_content_type :img,
                        content_type: ["image/jpeg", "image/jpg", "image/png"]



def send_code_to_user
    new_code = rand(100000..999999)
    text =  'Ваш промокод на скидку 5%: ' + new_code.to_s + ' Шариковая фея'
    phone = self.phone.tr('()+ ', '')
    message = MainsmsApi::Message.new(message: text,
                                      recipients: [phone])
    response = message.deliver

    if response.status == "success"
      self.promocode = new_code
      self.save
    else
      print response
    end
  end
end
