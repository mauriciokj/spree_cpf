require 'spec_helper'

describe "Customer Details" do
  stub_authorization!

  let!(:address) { create(:address_with_documento) }
  let!(:order) { create(:order, :state => 'complete', :completed_at => "2011-02-01 12:36:15", :bill_address => address) }

  before do
    visit spree.admin_path
    click_link "Orders"
    within('table#listing_orders') { click_icon(:edit) }
  end

  context "editing an order", :js => true do
    context "ship address has documento" do
      before do
        Spree::Config[:ship_address_has_documento] = true
      end

      it "should have documento field on shipping and billing address" do
        click_link "Customer Details"
        page.should have_selector("#order_bill_address_attributes_documento")
        page.should have_selector("#order_ship_address_attributes_documento")
      end
    end

    context "ship address does not have documento" do
      before do
        Spree::Config[:ship_address_has_documento] = false
      end

      it "should not have documento field on shipping address" do
        click_link "Customer Details"
        page.should_not have_selector("#order_ship_address_attributes_documento")
      end
    end
  end
end