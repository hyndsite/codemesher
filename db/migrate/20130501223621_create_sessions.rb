class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :abstract
      t.datetime :finish
      t.string :level
      t.string :room
      t.datetime :start
      t.string :title
      t.string :track
      t.references :speaker

      t.timestamps
    end
    add_index :sessions, :speaker_id
  end
end
