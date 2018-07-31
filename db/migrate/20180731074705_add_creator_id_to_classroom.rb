class AddCreatorIdToClassroom < ActiveRecord::Migration[5.2]
  def change
    change_table :classrooms do |t|
      t.references :creator, foreign_key: { to_table: :users }, type: :uuid, index: true
    end
  end
end
