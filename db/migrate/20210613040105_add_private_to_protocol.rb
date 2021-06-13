class AddPrivateToProtocol < ActiveRecord::Migration[6.1]
  def change
    add_column :protocols, :private, :boolean, default: false, null: false
  end
end
