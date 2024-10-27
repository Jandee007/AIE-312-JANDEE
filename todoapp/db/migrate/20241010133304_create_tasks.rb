class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :status, default: 0 # 0 for incomplete, 1 for complete

      t.timestamps
    end
  end
end
