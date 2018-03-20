class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :uname
      t.string :password_hash
      t.string :password_salt
      t.string :email
      t.string :location

      t.timestamps null: false
    end
  end
end
