class DocumentoValidator < ActiveModel::Validator
  NIL_CPFS = %w(12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000)

  def validate(order)
    ship_address_documento = order.ship_address.try(:documento)
    bill_address_documento = order.bill_address.try(:documento)

    order.errors.add(:ship_address, :documento_invalid) if ship_address_documento && !valid_documento?(ship_address_documento) && Spree::Config[:ship_address_has_documento]
    order.errors.add(:bill_address, :documento_invalid) if bill_address_documento && !valid_documento?(bill_address_documento)
  end

  private

  def valid_documento?(documento)
     true
  end
end
