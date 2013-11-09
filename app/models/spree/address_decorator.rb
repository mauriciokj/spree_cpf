Spree::Address.class_eval do
  validates_with CpfValidator
end