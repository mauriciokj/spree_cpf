class AddDocumentoToAddress < ActiveRecord::Migration
  def up
    add_column :spree_addresses, :documento, :string
  end

  def down
    remove_column :spree_addresses, :documento, :string
  end
end
