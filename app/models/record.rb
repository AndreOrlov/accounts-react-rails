class Record < ActiveRecord::Base
  validates_numericality_of :amount, only_integer: true
end
