require 'spec_helper'

describe "Customer Details" do
  stub_authorization!

  let!(:address) { create(:address_with_cpf) }
  let!(:order) { create(:order, :state => 'complete', :completed_at => "2011-02-01 12:36:15", :bill_address => address) }

  before do
    visit spree.admin_path
    click_link "Orders"
    within('table#listing_orders') { click_icon(:edit) }
  end

  context "editing an order", :js => true do
    it "should have cpf field on shipping and billing address" do
      click_link "Customer Details"
      page.should have_selector("#order_bill_address_attributes_cpf")
      page.should have_selector("#order_ship_address_attributes_cpf")
    end
  end
end