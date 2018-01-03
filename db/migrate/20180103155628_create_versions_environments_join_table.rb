class CreateVersionsEnvironmentsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :versions, :environments do |t|
      t.integer :version_id
      t.integer :environment_id
      t.index [:version_id, :environment_id]
      # t.index [:environment_id, :version_id]
    end
  end
end
