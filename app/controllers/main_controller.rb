class MainController < ApplicationController
  def index
    @header = 'Welcome home!'
    respond_to do |format|
      format.html
      format.json { render json: { text: 'Welcome!' } }
    end
  end
end
