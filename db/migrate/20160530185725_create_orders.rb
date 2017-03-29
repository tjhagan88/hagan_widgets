class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.references :user
      t.date :arrivalDt, :null => false
     	t.string :status, :null => false, :default => "pending"
      t.timestamps null: false
    end
  end

  def down
  	drop_table :orders 

  end

end
