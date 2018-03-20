class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :subject
      t.text :body
      t.references :user
      
      
      t.timestamps null: false
    end
  end
end
