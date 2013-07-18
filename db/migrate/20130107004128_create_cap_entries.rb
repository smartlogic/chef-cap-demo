class CreateCapEntries < ActiveRecord::Migration
  def change
    create_table :cap_entries do |t|
      t.text :message
      t.timestamp :created_at
    end
  end
end
