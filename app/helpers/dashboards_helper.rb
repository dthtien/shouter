module DashboardsHelper
  def shout_form_for(content_type)
    form_for Shout.new do |f|
      f.hidden_field(:content_type, value: content_type) + 
      f.fields_for(:content) { |content_form| yield(content_form) } + 
      f.submit('Shout!')
    end.html_safe
  end
end
