class AddColumnVerifiedAtAndVerificationCodeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :verified_at, :date
    add_column :products, :verification_code, :string
  end
end
