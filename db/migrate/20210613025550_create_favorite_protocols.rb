class CreateFavoriteProtocols < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_protocols do |t|
      t.references :user, null: false, foreign_key: true
      t.references :protocol, null: false, foreign_key: true

      t.timestamps
    end
  end
end
