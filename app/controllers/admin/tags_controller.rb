class Admin::TagsController < Admin::AdminController

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)
    if @tag.save
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def destroy
    @tag.destroy
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end