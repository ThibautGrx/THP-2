class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps, id: :uuid do |t|
      t.string :title, null: false, limit: 50
      t.text :description, null: false, limit: 300
      t.references :lesson, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
