class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :body, null: false, limit: 300
      t.references :classroom, type: :uuid, index: true
      t.references :user, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
