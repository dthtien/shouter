module ShoutsHelper
  def link_to_action(shout)
    if shout.liked_by?(current_user)
      link_to 'Unlike', unlike_shout_path(shout), method: :delete 
    else
      link_to 'Like', like_shout_path(shout), method: :post
    end
  end

  def autolink(text)
    text.gsub(/@\w+/) do |mention|
      link_to mention, user_path(mention[1..-1])
    end.html_safe
  end
end
