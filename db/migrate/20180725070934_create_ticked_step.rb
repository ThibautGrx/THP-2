class CreateTickedStep < ActiveRecord::Migration[5.2]
  def change
    create_table :ticked_steps, id: :uuid do |t|
      t.references :step, foreign_key: true, type: :uuid, index: true
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :classroom, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
