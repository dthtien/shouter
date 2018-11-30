class HashtagsController < ApplicationController
  def show
    @hashtag = params[:id]
  end
end
