class NewCartLine
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :user, :cart_id, :cart_name, :asset_id, :quantity
  attr_reader :persisted

  validates :user, presence: true
  validates :cart_name, length: {minimum: 2, maximum: 30}, allow_blank: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end

    @persisted = false
  end

  def asset
    Asset.find(asset_id)
  end

  def cart
    return user.carts.find_or_create_by(name: cart_name) unless cart_name.blank?

    begin
      user.carts.find(cart_id)
    rescue
      user.cart
    end
  end

  def save
    if valid?
      line = cart.lines.find_or_create_by(asset_id: asset_id)

      line.quantity ||= 0
      line.quantity += quantity.to_i
      line.save
    else
      false
    end
  end

  def persisted?
    @persisted
  end
end
