# frozen_string_literal: true

class AddProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :address, :string
    add_column :users, :profile, :text
  end
end
