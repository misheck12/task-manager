class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.references :service_type, foreign_key: true, index: true
      t.references :client, foreign_key: true, index: true
      t.boolean :active
      t.boolean :suspended
      t.text :info
      t.datetime :suspended_at

      t.timestamps
    end
  end
end
