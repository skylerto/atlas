class AddStatusToDeployments < ActiveRecord::Migration[5.1]
  def change
    add_column :deployments, :status, :boolean, default: false
  end
end
