class CreateUserSecrets < ActiveRecord::Migration
  def change
    create_table :user_secrets do |t|
      t.string :secret_code
      t.references :user

      t.timestamps null: false
    end
  end
end
