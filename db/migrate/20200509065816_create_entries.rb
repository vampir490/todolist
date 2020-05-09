class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :text
      t.datetime :duedate
      t.integer :priority
      t.boolean :completed

      t.timestamps
    end
  end
end
