class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.column :name, :string, uniq: true
      t.column :text, :text
      t.column :hint_type, :integer, default: 0
    end
  end
end
