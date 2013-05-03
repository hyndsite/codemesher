class AddOwnerContributor < ActiveRecord::Migration
  def change
      add_column :memberships, :owner, :boolean, null: false, default: false
      add_column :memberships, :contributor, :boolean, null: false, default: false
  end
end
