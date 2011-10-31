module DiskID

  require 'json'

  VERSION = "0.2.1"

  class DiskInfo

    attr_accessor :file_name, :format, :virtual_size, :disk_size

    def initialize(params)
      @hash = params
      @file_name = @hash['file_name']
      @format = @hash['format']
      @virtual_size = @hash['virtual_size']
      @disk_size = @hash['disk_size']
    end

    def to_json
      to_hash.to_json
    end

    def to_xml
      buf = ""
      buf << "<disk_info>"
      buf << "<file_name>#{@file_name}</file_name>"
      buf << "<format>#{@format}</format>"
      buf << "<virtual_size>#{@virtual_size}</virtual_size>"
      buf << "<disk_size>#{@disk_size}</disk_size>"
      buf << "</disk_info>"
      buf
    end

    def to_hash
      {
        'file_name' =>  @file_name,
        'format' => @format,
        'virtual_size' => @virtual_size,
        'disk_size' => @disk_size
      }
    end

  end

  class Inspector


    def initialize(file, qemu_img_bin='qemu-img-bleeding')
      @qemu_img_bin = qemu_img_bin
      @file = file
    end

    def inspect
      out = `#{@qemu_img_bin} info #{@file}`
      raise Exception.new("Error getting info from #{@file}") if $? != 0

      md = /image:(.*)$\nfile format:(.*)$\nvirtual size:(.*)$\ndisk size:(.*)\n/.match out
      @file_name,@format,@virtual_size,@disk_size = [md[1], md[2], md[3], md[4]].map { |e| e.strip.chomp }
      @virtual_size = @virtual_size.split()[0]
      DiskInfo.new({
        'file_name' =>  @file_name,
        'format' => @format,
        'virtual_size' => @virtual_size,
        'disk_size' => @disk_size
      })
    end


  end
end
