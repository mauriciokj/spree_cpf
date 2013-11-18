Spree::Order.class_eval do
  validates_with CpfValidator, on: :update
end