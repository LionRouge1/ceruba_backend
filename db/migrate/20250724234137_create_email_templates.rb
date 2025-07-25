class CreateEmailTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :email_templates do |t|
      t.string :name, null: false
      t.text :body, null: false
      t.bigint :emailable_id
      t.string :emailable_type
      t.string :subject, null: false
      # t.references :emailable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :email_templates, :name, unique: true
    add_index :email_templates, [:emailable_type, :emailable_id]
  end
end
