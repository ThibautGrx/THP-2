class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons, id: :uuid do |t|
      t.string :title, null: false, limit: 50
      t.text :description, null: false, limit: 300

      t.timestamps
    end
  end
end
