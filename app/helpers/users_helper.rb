module UsersHelper
  def gravatar_for user, params = {}
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_size = params[:size] ? "?s=#{params[:size]}" : ""
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png#{gravatar_size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
