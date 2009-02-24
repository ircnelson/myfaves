class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.string :name
      t.string :description
      t.string :url
      t.boolean :state, :default => true
      t.references :section
      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
