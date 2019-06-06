require 'spec_helper'

describe 'DocumentoValidator' do

  before(:each) do
    Spree::Config[:ship_address_has_documento] = true
    @validator = DocumentoValidator.new({attributes: {}})
    @order = double('order')
    @order_errors = double('order errors')
    @order.stub(:errors).and_return(@order_errors)
  end

  describe 'invalid documentos' do
    it 'invalidates a invalid documento format' do
      @order.stub_chain(:ship_address, :documento) { 'Invalid CPF :)' }
      @order.stub_chain(:bill_address, :documento) { 'Invalid CPF :)' }
      @order_errors.should_receive(:add).with(:bill_address, :documento_invalid)
      @order_errors.should_receive(:add).with(:ship_address, :documento_invalid)
      @validator.validate(@order)
    end

    it 'invalidates nil documento values' do
      @order_errors.should_receive(:add).with(:ship_address, :documento_invalid).exactly(DocumentoValidator::NIL_CPFS.length)
      @order_errors.should_receive(:add).with(:bill_address, :documento_invalid).exactly(DocumentoValidator::NIL_CPFS.length)
      DocumentoValidator::NIL_CPFS.each do |documento|
        @order.stub_chain(:ship_address, :documento) { documento }
        @order.stub_chain(:bill_address, :documento) { documento }
        @validator.validate(@order)
      end
    end
  end

  describe 'valid documentos' do
    let(:valid_documentos) { ['236.371.868-29', '468.548.242-57', '387.366.318-09'] }

    it 'returns true to valid documentos' do
      @order_errors.should_not_receive(:add)
      @order_errors.should_not_receive(:add)
      valid_documentos.each do |documento|
        @order.stub_chain(:ship_address, :documento) { documento }
        @order.stub_chain(:bill_address, :documento) { documento }
        @validator.validate(@order)
      end
    end
  end
end