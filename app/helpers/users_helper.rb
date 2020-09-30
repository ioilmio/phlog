module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, class: 'gravatar')
  end
  if Rails.env == 'development'
    def gravatar_for(user)
      gravatar_url = "https://api.adorable.io/avatars/80/#{user.email.downcase}.png"
      image_tag(gravatar_url, alt: user.username, class: 'gravatar')
    end
  end
end
