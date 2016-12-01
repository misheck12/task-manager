class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.references :created_by, references: :users, index: true
      t.references :client, foreign_key: true
      t.datetime :when, :null => false
      t.integer :duration, :null => false
      t.boolean :single_event, :null => false
      t.string :activity, :null => false
      t.text :comment
      t.boolean :done, :default => false
      t.datetime :done_at
      t.string :color, :null => false
      t.string :token, :null => false

      t.timestamps
    end

    add_foreign_key :tasks, :users, column: :user_id
    add_foreign_key :tasks, :users, column: :created_by_id
  end
end
