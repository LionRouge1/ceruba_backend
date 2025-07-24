class CreateForms < ActiveRecord::Migration[8.0]
  def change
    create_table :forms do |t|
      t.string :name, default: "Untitled Form", null: false
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :website, foreign_key: true

      t.timestamps
    end
  end
end
