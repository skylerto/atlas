class AddBuildNumberToVersion < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :build_number, :string
  end
end
