class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations, id: :uuid do |t|
      t.boolean :accepted
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :classroom, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
