class Admin::TonesController < Admin::AdminController
  def new
    @tone = Tone.new
  end

  def show
    @items = tone.items.paginate(page: params[:page], per_page: 20)
  end

  def create
    @tone = Tone.create(tone_params)
    redirect_to admin_items_path
  end

  private

    def tone
      @tone ||= Tone.find(params[:id])
    end

  def tone_params
    params.require(:tone).permit(:name, :eng_name, :code, :color)
  end
end
