class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms, id: :uuid do |t|
      t.string :title, null: false, limit: 50
      t.text :description, null: false, limit: 300
      t.references :lesson, foreign_key: true, index: true, type: :uuid
      t.timestamps
    end
  end
end
