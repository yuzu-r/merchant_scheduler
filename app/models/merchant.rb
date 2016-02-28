class Merchant < ActiveRecord::Base
	VALID_MERCHANT_NAME_REGEX = /\A[a-z\d]+[-\s]*/i   # this is not right still
	validates(:name, presence: true, length: {maximum: 50}, 
		format: { with: VALID_MERCHANT_NAME_REGEX }, 
		uniqueness: { case_sensitive: false})
end

