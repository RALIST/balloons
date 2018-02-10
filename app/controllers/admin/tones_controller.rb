class Admin::TonesController < Admin::AdminController
  def new
    @tone = Tone.new
  end

  def index
    @tones = Tone.all.order(:vendor_id)
  end

  def create
    @tone = Tone.create(tone_params)
    redirect_to admin_items_path
  end

  private

  def tone_params
    params.require(:tone).permit(:name, :eng_name, :code, :color)
  end
end
