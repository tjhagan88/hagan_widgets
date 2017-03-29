class CreateWidgets < ActiveRecord::Migration
  def up
    create_table :widgets do |t|
    	t.references :order
    	t.string :wigtype
    	t.string :color, :null => false

      t.timestamps null: false
    end
  end

  def down
  	drop_table :widgets
  end
end
