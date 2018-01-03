class CreateVersionsDeploymentsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :versions, :deployments do |t|
      t.integer :version_id
      t.integer :deployment_id
      t.index [:version_id, :deployment_id]
      # t.index [:deployment_id, :version_id]
    end
  end
end
