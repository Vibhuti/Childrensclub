# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog
  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  process :auto_orient # this should go before all other "process" steps

  process resize_to_fill:[800, 800]

  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  # version :thumb do
  #   process :resize_to_limit => [200, 200]
  # end

end