module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, class: 'gravatar')
  end

  def photo_for(user, size: 80)
    if !user.photo.attached?
      gravatar_for user
    else
      image_tag(user.photo, size: size, class: 'gravatar')
    end
  end
  if Rails.env == 'development'
    def gravatar_for(user)
      gravatar_url = "https://api.adorable.io/avatars/80/#{user.email.downcase}.png"
      image_tag(gravatar_url, alt: user.username, class: 'gravatar')
    end
  end
end
