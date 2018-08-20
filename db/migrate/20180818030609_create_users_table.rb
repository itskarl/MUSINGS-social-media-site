
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |x|
      x.string :first_name
      x.string :last_name
      x.string :email
      x.string :username
      x.string :password_hash
      x.datetime :created_at
      x.datetime :posted_at
      x.string :birthday
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
