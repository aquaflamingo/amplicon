class AddDetailFieldsToProtocol < ActiveRecord::Migration[6.1]
  def change
    add_column :protocols, :reagents, :text
    add_column :protocols, :methods, :text
    add_column :protocols, :equipment, :text
  end
end
