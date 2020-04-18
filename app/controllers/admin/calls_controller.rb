class Admin::CallsController < Admin::AdminController

  before_action :find_call, only: [:show, :destroy]

  def index
    @calls = Call.all.reverse_order
  end

  def show;end

  def destroy
    @call.destroy
    redirect_back(fallback_location: admin_calls_path)
  end

  private

    def find_call
      @call = Call.find(params[:id])
    end
end
