class Version < ApplicationRecord
  belongs_to :service
  has_and_belongs_to_many :environments
end
