require 'nokogiri'

# A package object to wrap up the paramters of an update
class AppCastUpdatePackage
  attr_accessor :template_path,
                :archive_path,
                :title,
                :description,
                :download_url,
                :cast_output_path
end

# Accepts updater packages and generates appcasts
class AppCastGenerator
  SPARKLE_PRIVATE_KEY = 'SPARKLE_PRIVATE_KEY'.freeze
  # Assumes that you have SPARKLE_PRIVATE_KEY and Sparkle bin PATH accessible
  def prepare_appcast_update(package)
    preflight

    signature = sign_update(package.archive_path, ENV[SPARKLE_PRIVATE_KEY])
    length = archive_length(package.archive_path)

    write_app_cast(package, length, signature)
  end

  def write_app_cast(package, length, signature)
    doc = File.open(File.expand_path(package.template_path)) { |f| Nokogiri::XML(f) }
    item = doc.xpath('//item').first
    item.xpath('title').first.content = package.title
    item.xpath('description').first.content = package.description
    item.xpath('pubDate').first.content = Time.new.to_s
    enclosure = item.xpath('enclosure').first
    enclosure['url'] = package.download_url
    enclosure['sparkle:version'] = '2.0'
    enclosure['length'] = length
    enclosure['sparkle:dsaSignature'] = signature

    File.write(File.expand_path(package.cast_output_path), doc.to_xml)
  end

  def sign_update(archive_path, key)
    signature = `sign_update #{File.expand_path(archive_path)} #{key}`.chomp
    raise 'Unable to sign update' unless $?.exitstatus == 0
    return signature
  end

  def archive_length(archive_path)
    File.size(File.expand_path(archive_path))
  end

  def preflight
    raise 'Unable to find sign_update tool from the Sparkle distribution' unless command? 'sign_update'
    raise 'SPARKLE_PRIVATE_KEY environment variable is missing!' unless !ENV[SPARKLE_PRIVATE_KEY].nil?
  end

  private

  def command?(command)
    system("which #{command} > /dev/null 2>&1")
  end
end
