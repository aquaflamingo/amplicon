# frozen_string_literal: true

class CreateProtocols < ActiveRecord::Migration[6.1]
  def change
    create_table :protocols do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
