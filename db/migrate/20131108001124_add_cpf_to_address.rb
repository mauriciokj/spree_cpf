class AddCpfToAddress < ActiveRecord::Migration
  def up
    add_column :spree_addresses, :cpf, :string
  end

  def down
    remove_column :spree_addresses, :cpf, :string
  end
end
