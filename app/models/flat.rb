class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy


  validates :address, :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 50, less_than: 1000 }

  before_validation :set_name_if_blank

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  def set_name_if_blank
    self.name = "#{user.username.to_s.capitalize}'s Flat" if name.blank? && user.present?
  end
end
