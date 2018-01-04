class Deployment < ApplicationRecord
  belongs_to :environment
  has_and_belongs_to_many :versions
end
