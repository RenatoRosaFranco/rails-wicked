# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true

  after_create :create_verification_code

  def create_verification_code
    update(verification_code: "#{rand(1000...9999)}")
  end

  def verify_product
    update!(verified: true, verified_at: Date.today, verification_code: nil)
  end
end
