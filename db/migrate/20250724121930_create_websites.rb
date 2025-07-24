class CreateWebsites < ActiveRecord::Migration[8.0]
  def change
    create_table :websites do |t|
      t.string :name, null: false, default: "Untitled Website"
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
