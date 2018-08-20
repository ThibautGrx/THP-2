class AddColumnToInvitations < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :invitations do |t|
        dir.up do
          t.references :student, foreign_key: { to_table: :users }, type: :uuid, index: true
          t.references :teacher, foreign_key: { to_table: :users }, type: :uuid, index: true
          t.remove :user_id
        end

        dir.down do
          t.references :user, foreign_key: true, type: :uuid, index: true
          t.remove :student
          t.remove :teacher
        end
      end
    end
  end
end
