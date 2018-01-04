class CreateDeployments < ActiveRecord::Migration[5.1]
  def change
    create_table :deployments do |t|
      t.references :environment, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
