class Environment < ApplicationRecord
  has_and_belongs_to_many :versions
end
