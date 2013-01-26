class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :title
      t.text :abstract
      t.datetime :start
      t.datetime :end
      t.string :room
      t.string :difficulty
      t.string :speaker_name
      t.string :technology
      t.text :uri
      t.string :event_type
      t.string :id
      t.text :session_lookup_id
      t.text :speaker_uri

      t.timestamps
    end
  end
end
