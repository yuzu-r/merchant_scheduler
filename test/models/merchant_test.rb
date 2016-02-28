require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  def setup
  	@merchant = Merchant.new(name: "Bank of Tracy")
  end

  test "should be valid"  do
  	assert @merchant.valid?, "why am I failing?"
  end

  test "name should be present" do
		@merchant.name = ""
		assert_not @merchant.valid?
	end

	test "name should be max 50 in length" do
		@merchant.name = "w" * 51
		assert_not @merchant.valid?
	end

	test "name should be alphanumeric, space and dash only, at least one letter or number" do
		invalid_merchant_names = %w[ - @@ ]
		invalid_merchant_names.each do |invalid_name|
			@merchant.name = invalid_name			
			assert_not @merchant.valid?, "failing character tests"
		end
	end

	test "name should be unique" do
		duplicate_merchant = @merchant.dup
		duplicate_merchant.name = @merchant.name.upcase
		@merchant.save
		assert_not duplicate_merchant.valid?
	end
end
