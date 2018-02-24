module VideosHelper

  def embed url
    url.split("=").last
  end
end
