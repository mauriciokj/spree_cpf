Spree::Order.class_eval do
  validates_with DocumentoValidator, on: :update
end