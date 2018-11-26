module ApplicationHelper
  def gravatar(email)
    digest_email = Digest::MD5.hexdigest(email)
    image_tag "//www.gravatar.com/avatar/#{digest_email}", width: 30
  end
end
