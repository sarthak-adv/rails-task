class User < ApplicationRecord
  belongs_to :org

  # enum role: {
  #   user: 0,
  #   admin: 1
  # }

  validates :role, presence: true
  has_secure_password
end
