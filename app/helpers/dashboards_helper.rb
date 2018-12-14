module DashboardsHelper
  def shout_form_for(content_type)
    form_for(Shout.new, url: content_type.new, remote: true) do |f|
      f.fields_for(:content) { |content_form| yield(content_form) } +
      f.submit('Shout!')
    end
  end
end
