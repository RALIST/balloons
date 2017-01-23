class Order < ApplicationRecord
  belongs_to :user
  has_many :items, through: :positions
  has_many :compositions, through: :positions
  has_many :items, through: :subspositions
  has_many :positions
  validates :user_id, :order_date, :phone, :address, :name, presence: true

  accepts_nested_attributes_for :user

  before_validation :normalize_date

  attr_accessor :order_time


  def save_user(params={})
    user = User.find_by!(phone: params[:phone])
    self.user = user
  rescue ActiveRecord::RecordNotFound
    user = User.create(phone: params[:phone],
                        first_name: params[:name],
                        address: params[:address],
                        password: params[:name],
                        password_confirmation: params[:name])
    self.user = user
  end


  private
  def normalize_date
    self.order_date = Time.parse(order_date.to_s + ' ' + order_time.to_s)
  end
end
