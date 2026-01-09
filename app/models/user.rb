class User < ApplicationRecord
  belongs_to :org
  has_secure_password
end
