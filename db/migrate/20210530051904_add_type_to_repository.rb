class AddTypeToRepository < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :type, :integer
  end
end
