class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url
      t.string :html

      t.timestamps null: false
    end
  end
end
