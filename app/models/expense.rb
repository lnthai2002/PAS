class Expense < ActiveRecord::Base
  belongs_to :exp_type
  belongs_to :payment_type
end
