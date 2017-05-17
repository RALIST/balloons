class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_call, :tags, :receivers

end

private
  def new_call
    @call = Call.new
  end

  def tags
    @menu_tags = Tag.composition_tags
  end

  def receivers
    @menu_receivers = Receiver.all.select("distinct on (title) *")
  end
