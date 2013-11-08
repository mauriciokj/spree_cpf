require 'spec_helper'

describe 'CpfValidator' do

  before(:each) do
    @validator = CpfValidator.new({attributes: {}})
    @mock = mock('model')
    @errors = double('model errors')
    @mock.stub(:errors).and_return(@errors)
  end

  describe 'invalid cpfs' do
    it 'invalidates a invalid cpf format' do
      @mock.stub(:cpf) { 'Invalid CPF :)' }
      @errors.should_receive(:add)
      @validator.validate(@mock)
    end

    it 'invalidates nil cpf values' do
      @errors.should_receive(:add).exactly(CpfValidator::NIL_CPFS.length)
      CpfValidator::NIL_CPFS.each do |cpf|
        @mock.stub(:cpf) { cpf }
        @validator.validate(@mock)
      end
    end

    it 'invalidates nil' do
      @mock.stub(:cpf) { nil }
      @errors.should_receive(:add)
      @validator.validate(@mock)
    end
  end

  describe 'valid cpfs' do
    let(:valid_cpfs) { ['236.371.868-29', '468.548.242-57', '387.366.318-09'] }

    it 'returns true to valid cpfs' do
      @errors.should_not_receive(:add)
      valid_cpfs.each do |cpf|
        @mock.stub(:cpf) { cpf }
        @validator.validate(@mock)
      end
    end
  end
end