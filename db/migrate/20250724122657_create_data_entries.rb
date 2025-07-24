class CreateDataEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :data_entries do |t|
      t.jsonb :payload, null: false
      t.string :origin
      t.string :location, default: "Unknown Location"
      t.string :ip_address
      t.string :user_agent
      t.references :form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
