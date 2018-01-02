class AddEnvironmentToServices < ActiveRecord::Migration[5.1]
  def change
    add_reference :services, :environment, foreign_key: true
  end
end
