class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :address
      t.string :site, :null => false

      t.timestamps
    end
  end
end
