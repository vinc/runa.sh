class RenameTokenIntoApiKeyInUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :token, :api_key
  end
end
