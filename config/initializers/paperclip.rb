Paperclip::UriAdapter.register
require 'paperclip/media_type_spoof_detector'

Paperclip::MediaTypeSpoofDetector.class_eval do
  def spoofed?
    false
  end
  def type_from_file_command
    begin
      Paperclip.run("file", "-b --mime :file", :file => @file.path)
    rescue Cocaine::CommandLineError
      puts "No File.exe"
    end
  end
end