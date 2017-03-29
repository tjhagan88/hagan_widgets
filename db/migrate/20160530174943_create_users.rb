class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.string :username, :null => false
      t.string :password_digest, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
    	t.string :email, :null => false
      t.boolean :isAdmin
      t.timestamps null: false
    end
  end

  def down
  	drop_table :users
  end
end
