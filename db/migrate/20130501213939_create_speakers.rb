class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.text :biography
      t.string :blog_url
      t.string :email_address
      t.string :name
      t.string :twitter

      t.timestamps
    end
  end
end
