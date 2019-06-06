require 'spec_helper'

describe "Checkout" do

  let!(:country) { create(:country, :states_required => true) }
  let!(:state) { create(:state, :country => country) }
  let!(:shipping_method) { create(:shipping_method) }
  let!(:stock_location) { create(:stock_location) }
  let!(:mug) { create(:product, :name => "RoR Mug") }
  let!(:payment_method) { create(:payment_method) }
  let!(:zone) { create(:zone) }

  context "visitor makes checkout as guest without registration" do
    before(:each) do
      stock_location.stock_items.update_all(count_on_hand: 1)
    end

    describe 'errors messages', js: true do
      before(:each) do
        Spree::Config[:ship_address_has_documento] = true
      end

      it 'has a valid error message regarding CPF field' do
        add_mug_and_checkout
        fill_in_address type: 'bill', documento: 'invalid documento', fill_documento: true
        click_button "Save and Continue"

        page.should have_content 'Bill address CPF is invalid'
        page.should have_content 'Ship address CPF is invalid'
      end
    end

    context "full checkout", js: true do
      before do
        shipping_method.calculator.preferred_amount = 10
        mug.shipping_category = shipping_method.shipping_categories.first
        mug.save!
      end

      after do
        click_button "Save and Continue"
        page.should have_content("DELIVERY")
        click_button "Save and Continue"
        page.should have_content("PAYMENT INFORMATION")
        click_button "Save and Continue"
        page.should have_content("Your order has been processed successfully")
      end

      describe 'ship address documento' do
        describe 'has documento' do
          before do
            Spree::Config[:ship_address_has_documento] = true
          end

          it 'fill in ship address documento, bill address documento and checkout' do
            add_mug_and_checkout
            fill_in_address type: 'bill', fill_documento: true
            uncheck 'Use Billing Address'
            fill_in_address type: 'ship', fill_documento: true
          end
        end

        describe 'does not have documento' do
          before do
            Spree::Config[:ship_address_has_documento] = false
          end

          it 'fill in bill address documento and checkout' do
            add_mug_and_checkout
            fill_in_address type: 'bill', fill_documento: true
            uncheck 'Use Billing Address'
            fill_in_address type: 'ship', fill_documento: false
          end
        end
      end
    end
  end

  def fill_in_address(opts = {})
    documento = opts[:documento] || "036.142.049-87"
    type = opts[:type] || 'bill'
    fill_documento ||= opts[:fill_documento]

    address = "order_#{type}_address_attributes"
    fill_in "#{address}_firstname", :with => "Ryan"
    fill_in "#{address}_lastname", :with => "Bigg"
    fill_in "#{address}_address1", :with => "143 Swan Street"
    fill_in "#{address}_city", :with => "Richmond"
    fill_in "#{address}_documento", :with => documento if fill_documento
    select "United States of America", :from => "#{address}_country_id"
    select "Alabama", :from => "#{address}_state_id"
    fill_in "#{address}_zipcode", :with => "12345"
    fill_in "#{address}_phone", :with => "(555) 555-5555"
  end

  def add_mug_and_checkout
    add_mug_to_cart
    click_button "Checkout"
    fill_in "order_email", :with => "ryan@spreecommerce.com"
  end

  def add_mug_to_cart
    visit spree.root_path
    click_link mug.name
    click_button "add-to-cart-button"
  end
end