require 'yaml'
require 'fileutils'

require 'net/http'
require 'uri'

require 'digest/md5'

def open(url)
  Net::HTTP.get(URI.parse(url))
end

def get_settings()

  config = {
    local: './vagrant/config/vagrant-local.yml',
    example: './vagrant/config/vagrant-local.example.yml'
  }

# copy config from example if local config not exists
  FileUtils.cp config[:example], config[:local] unless File.exist?(config[:local])

# read config
  return YAML.load_file config[:local]

end


def draw_intro(machine_name)

  file = 'vagrant/tmp/'+Digest::MD5.hexdigest(machine_name)

  if File.file?(file)
    puts File.read(file)
    return
  end

  url ='http://artii.herokuapp.com/make?text='+machine_name+' server'+'&font=big';
  page_content = open(url)

  File.open(file, 'w+') { |_file| _file.write(page_content) }

  puts page_content

end
