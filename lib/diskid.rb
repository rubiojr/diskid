module DiskID

  require 'json'

  VERSION = "0.2.2"

  class DiskInfo

    attr_accessor :file_name, :format, :virtual_size, :disk_size
    attr_accessor :variant

    def initialize(params)
      @hash = params
      @file_name = @hash['file_name']
      @format = @hash['format']
      @virtual_size = @hash['virtual_size']
      @disk_size = @hash['disk_size']
      @variant = @hash['variant']
    end

    def to_json
      to_hash.to_json
    end

    def to_xml
      buf = ""
      buf << "<disk_info>"
      buf << "<file_name>#{@file_name}</file_name>"
      buf << "<format>#{@format}</format>"
      buf << "<variant>#{@variant}</variant>" if not @variant.empty?
      buf << "<virtual_size>#{@virtual_size}</virtual_size>"
      buf << "<disk_size>#{@disk_size}</disk_size>"
      buf << "</disk_info>"
      buf
    end

    def to_text
      t = ""
      t << "file_name: #{@file_name}\n"
      t << "format: #{@format}\n"
      t << "variant: #{@variant}\n" if not @variant.empty?
      t << "virtual_size: #{@virtual_size}\n"
      t << "disk_size: #{@disk_size}\n"
    end

    def to_hash
      h = {
        'file_name' =>  @file_name,
        'format' => @format,
        'virtual_size' => @virtual_size,
        'disk_size' => @disk_size
      }
      h['variant'] = @variant if not @variant.empty?
      h
    end

  end

  class Inspector


    def initialize(file, qemu_img_bin='qemu-img-bleeding')
      @qemu_img_bin = (qemu_img_bin || '').strip.chomp
      if not @qemu_img_bin =~ /^\//
        @qemu_img_bin = `sh -c 'command -v #{@qemu_img_bin}'`.strip.chomp
      end
      raise ArgumentError.new("qemu-img command not found: #{@qemu_img_bin}") if @qemu_img_bin.empty?

      @file = file
    end

    def identify 
      out = `#{@qemu_img_bin} info #{@file}`
      raise Exception.new("Error getting info from #{@file}") if $? != 0

      md = /image:(.*)$\nfile format:(.*)$\nvirtual size:(.*)$\ndisk size:(.*)\n/.match out
      @file_name,@format,@virtual_size,@disk_size = [md[1], md[2], md[3], md[4]].map { |e| e.strip.chomp }
      @virtual_size = @virtual_size.split()[0]
      variant = ''
      if @format == 'vmdk'
        variant = read_variant @file
      end
      DiskInfo.new({
        'file_name' =>  @file_name,
        'format' => @format,
        'virtual_size' => @virtual_size,
        'disk_size' => @disk_size,
        'variant' => variant
      })
    end

    private
    def read_variant(file)
      IO.read(file, 20000).each_line do |l|
        return $1 if l =~ /createType="(.*?)"/
      end
      ''
    end

  end

end
