class ShoutsController < ApplicationController
  def create
    shout = current_user.shouts.create(shout_params)
    redirect_to root_path, redirect_options_for(shout)
  end

  def show
    @shout = ShoutPresenter.new Shout.find(params[:id])
  end

  private

  def shout_params
    { content: content_from_params }
  end

  def content_from_params
    params[:default][:content_type].new(content_params)
  end

  def content_params
    params.require(:shout).require(:content).permit(:body)
  end

  def redirect_options_for(shout)
    if shout.persisted?
      { notice: 'Shouted successfully'}
    else
      { alert: shout.errors.full_messages.to_sentence }
    end
  end
end
