module Paperclip
  class Watermark < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @file = file
      @attachment = attachment
      @options = options
      @watermark_path = options[:watermark_path].nil? ? "#{Rails.root}/app/assets/images/logo-shop.png" :
                            options[:watermark_path]
      @position       = options[:position].nil? ? "NorthEast" : options[:position]
    end
    
    def make
      warn 'Starting watermarking...'
      src = @file
      dst = Tempfile.new([@basename].compact.join("."))
      dst.binmode
      return super unless @watermark_path
      geometry = Paperclip::Geometry.from_file(src)
      params = " -gravity #{@position} :wm :source :dest"
      
      begin
        success = Paperclip.run("composite", params,
                                source: "#{File.expand_path(src.path)}",
                                dest: "#{File.expand_path(dst.path)}",
                                wm: "#{File.expand_path(wm(geometry.width.to_i / 2))}")
      rescue  => e
        puts e
        # raise Paperclip::Error, "There was an error processing the watermark for #{@basename}" if @whiny
      end
      dst
    end
    
    def wm(size)
      filename = "#{File.basename(@watermark_path, File.extname(@watermark_path))}.#{File.extname(@watermark_path)}"
      dst = TempfileFactory.new.generate(filename)
      dst.binmode
      params = ":source -resize #{size}x :dest"
       Paperclip.run("convert", params,  dest: "#{File.expand_path(dst.path)}", source: "#{@watermark_path}" )
      dst
    end
  end
end