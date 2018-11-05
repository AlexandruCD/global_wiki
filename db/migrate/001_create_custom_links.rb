class CreateCustomLinks < ActiveRecord::Migration
  def change
    create_table :custom_links do |t|
      t.string :name
      t.string :url
      t.string :after_which
    end
  end

  def self.down
    drop_table :custom_links
  end
end
