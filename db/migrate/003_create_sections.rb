class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.references :user
      t.timestamps
    end
    User.create(:email => 'contato@nel.yuno.com.br',
    						:login => 'nelson',
    						:password => 'ncvj487569',
    						:password_confirmation => 'ncvj487569')
  end

  def self.down
    drop_table :sections
  end
end
