class Service < ApplicationRecord
  belongs_to :environment
  validates :name, uniqueness: { scope: [:version, :environment_id] }
end
