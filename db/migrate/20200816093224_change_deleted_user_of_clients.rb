class ChangeDeletedUserOfClients < ActiveRecord::Migration[5.2]

  def up
      change_column :clients, :deleted_user, :integer, default: '1'
  end

  def down
      change_column :clients, :deleted_user, :integer
  end
end
