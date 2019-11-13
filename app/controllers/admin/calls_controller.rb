class Admin::CallsController < Admin::AdminController

  def index
    @calls = Call.all.order('created_at DESC')
  end

  def show
    @call = Call.find(params[:id])

  end

  def destroy

  end


end