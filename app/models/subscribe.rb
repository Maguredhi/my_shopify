class Subscribe < ApplicationRecord
  validates :email, uniqueness: true, presence: true
end
