class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.content}
end
