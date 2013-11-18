require 'spec_helper'

describe 'CpfValidator' do

  before(:each) do
    Spree::Config[:ship_address_has_cpf] = true
    @validator = CpfValidator.new({attributes: {}})
    @order = double('order')
    @order_errors = double('order errors')
    @order.stub(:errors).and_return(@order_errors)
  end

  describe 'invalid cpfs' do
    it 'invalidates a invalid cpf format' do
      @order.stub_chain(:ship_address, :cpf) { 'Invalid CPF :)' }
      @order.stub_chain(:bill_address, :cpf) { 'Invalid CPF :)' }
      @order_errors.should_receive(:add).with(:bill_address, :cpf_invalid)
      @order_errors.should_receive(:add).with(:ship_address, :cpf_invalid)
      @validator.validate(@order)
    end

    it 'invalidates nil cpf values' do
      @order_errors.should_receive(:add).with(:ship_address, :cpf_invalid).exactly(CpfValidator::NIL_CPFS.length)
      @order_errors.should_receive(:add).with(:bill_address, :cpf_invalid).exactly(CpfValidator::NIL_CPFS.length)
      CpfValidator::NIL_CPFS.each do |cpf|
        @order.stub_chain(:ship_address, :cpf) { cpf }
        @order.stub_chain(:bill_address, :cpf) { cpf }
        @validator.validate(@order)
      end
    end
  end

  describe 'valid cpfs' do
    let(:valid_cpfs) { ['236.371.868-29', '468.548.242-57', '387.366.318-09'] }

    it 'returns true to valid cpfs' do
      @order_errors.should_not_receive(:add)
      @order_errors.should_not_receive(:add)
      valid_cpfs.each do |cpf|
        @order.stub_chain(:ship_address, :cpf) { cpf }
        @order.stub_chain(:bill_address, :cpf) { cpf }
        @validator.validate(@order)
      end
    end
  end
end