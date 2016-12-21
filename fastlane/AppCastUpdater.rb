require 'nokogiri'

class AppCastUpdater
  # Assumes that you have SPARKLE_PRIVATE_KEY and Sparkle bin PATH accessible
  def prepare_appcast_update(
    template_path,
    archive_path,
    title,
    description,
    url,
    app_cast_output_path)

    key = ENV["SPARKLE_PRIVATE_KEY"]

    signature = sign_update(archive_path, key)
    length = archive_length(archive_path)

    write_app_cast(template_path, title, description, url, signature, length, app_cast_output_path)
  end

  def write_app_cast(template_path, title, description, url, signature, length, app_cast_output_path)
    doc = File.open(File.expand_path(template_path)) { |f| Nokogiri::XML(f) }
    item = doc.xpath("//item").first
    item.xpath("//title").first.content = title
    item.xpath("//description").first.content = description
    item.xpath("//pubDate").first.content = "#{Time.new}"
    enclosure = item.xpath("//enclosure").first
    enclosure["url"] = url
    enclosure["sparkle:version"] = "2.0"
    enclosure["length"] = length
    enclosure["sparkle:dsaSignature"] = signature

    File.write(File.expand_path(app_cast_output_path), doc.to_xml)
  end

  def sign_update(archive_path, key)
    return `sign_update #{File.expand_path(archive_path)} #{key}`.chomp
  end

  def archive_length(archive_path)
    return File.size(File.expand_path(archive_path))
  end
end
