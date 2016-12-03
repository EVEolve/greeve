vcr_opts = {
  cassette_name: "character/market_orders",
}

vcr_opts_order_id = {
  cassette_name: "character/market_orders_order_id",
}

describe Greeve::Character::MarketOrders, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::MarketOrders.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:orders) { should be_a Greeve::Rowset }
  end

  context "orders" do
    subject { resource.orders.first }

    its(:order_id) { should eq 4683769748 }
    its(:char_id) { should eq 462421468 }
    its(:station_id) { should eq 60009520 }
    its(:vol_entered) { should eq 1 }
    its(:vol_remaining) { should eq 0 }
    its(:min_volume) { should eq 1 }
    its(:order_state) { should eq 2 }
    its(:type_id) { should eq 18067 }
    its(:range) { should eq -1 }
    its(:account_key) { should eq 1000 }
    its(:duration) { should eq 0 }
    its(:escrow) { should eq BigDecimal.new("0.00") }
    its(:price) { should eq BigDecimal.new("100000.00") }
    its(:bid) { should eq true }
    its(:issued) { should eq Time.parse("2016-11-20 20:00:54 UTC") }

    context "with option order_id", vcr: vcr_opts_order_id do
      let(:order_id) { 4691584200 }

      let(:resource) {
        Greeve::Character::MarketOrders.new(character_id, order_id: order_id, key: key, vcode: vcode)
      }

      specify { resource.orders.count.should eq 1 }

      its(:order_id) { should eq order_id }
      its(:char_id) { should eq 462421468 }
      its(:station_id) { should eq 60011866 }
      its(:vol_entered) { should eq 5090 }
      its(:vol_remaining) { should eq 0 }
      its(:min_volume) { should eq 1 }
      its(:order_state) { should eq 2 }
      its(:type_id) { should eq 9836 }
      its(:range) { should eq 32767 }
      its(:account_key) { should eq 1000 }
      its(:duration) { should eq 90 }
      its(:escrow) { should eq BigDecimal.new("0.00") }
      its(:price) { should eq BigDecimal.new("10803.00") }
      its(:bid) { should eq false }
      its(:issued) { should eq Time.parse("2016-11-27 00:50:40 UTC") }
    end
  end
end
