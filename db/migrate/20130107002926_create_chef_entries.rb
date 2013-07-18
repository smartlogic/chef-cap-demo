class CreateChefEntries < ActiveRecord::Migration
  def up
    unless ActiveRecord::Base.connection.table_exists? :chef_entries
      create_table :chef_entries do |t|
        t.text :message
        t.timestamp :created_at
      end
    end
  end

  def down
    drop_table :chef_entries
  end
end
