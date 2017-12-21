class CreateJenkins < ActiveRecord::Migration[5.1]
  def change
    create_table :jenkins do |t|
      t.string :server_ip
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
