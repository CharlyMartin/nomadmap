class Nomad < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #      :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true

  validates :address, presence: true
  # validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def full_name
    "#{first_name} #{last_name}"
  end

  def city_country
    "#{city}, #{ISO3166::Country[country].name}"
  end

  def full_address
    "#{address}, #{zip_code} #{city} #{ISO3166::Country[country].name}"
  end

  def full_address_changed?
    address_changed? || zip_code_changed? || city_changed? || country_changed?
  end
end