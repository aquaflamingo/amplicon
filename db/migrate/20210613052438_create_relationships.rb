# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower, index: true, null: false, foreign_key: { to_table: :users }
      t.references :followed, index: true, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
