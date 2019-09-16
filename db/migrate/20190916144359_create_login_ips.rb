class CreateLoginIps < ActiveRecord::Migration[5.2]
  def change
    create_table :login_ips do |t|
      t.string :ip
      t.string :login
      t.timestamps
    end
  end
end
