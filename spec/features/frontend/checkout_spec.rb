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

      describe 'ship address cpf' do
        describe 'has cpf' do
          before do
            Spree::Config[:ship_address_has_cpf] = true
          end

          it 'fill in ship address cpf, bill address cpf and checkout' do
            add_mug_and_checkout
            fill_in_address type: 'bill', fill_cpf: true
            uncheck 'Use Billing Address'
            fill_in_address type: 'ship', fill_cpf: true
          end
        end

        describe 'does not have cpf' do
          before do
            Spree::Config[:ship_address_has_cpf] = false
          end

          it 'fill in bill address cpf and checkout' do
            add_mug_and_checkout
            fill_in_address type: 'bill', fill_cpf: true
            uncheck 'Use Billing Address'
            fill_in_address type: 'ship', fill_cpf: false
          end
        end
      end
    end
  end

  def fill_in_address(opts = {})
    type = opts[:type] || 'bill'
    fill_cpf ||= opts[:fill_cpf]

    address = "order_#{type}_address_attributes"
    fill_in "#{address}_firstname", :with => "Ryan"
    fill_in "#{address}_lastname", :with => "Bigg"
    fill_in "#{address}_address1", :with => "143 Swan Street"
    fill_in "#{address}_city", :with => "Richmond"
    fill_in "#{address}_cpf", :with => "036.142.049-87" if fill_cpf
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