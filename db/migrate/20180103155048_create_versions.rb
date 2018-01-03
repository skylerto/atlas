class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :versions do |t|
      t.references :service, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
