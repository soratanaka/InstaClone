class AddColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :plofile, :text
  end
end
