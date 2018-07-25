class CreateVote < ActiveRecord::Migration[5.2]
  def change
    create_table :votes, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :question, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
