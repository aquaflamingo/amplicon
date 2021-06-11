class AddUserIdToProtocol < ActiveRecord::Migration[6.1]
  def change
    add_reference :protocols, :user, null: false, foreign_key: true
  end
end
