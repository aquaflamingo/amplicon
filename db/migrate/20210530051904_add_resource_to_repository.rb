class AddResourceToRepository < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :resource, :integer
  end
end
