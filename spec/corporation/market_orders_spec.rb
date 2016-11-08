vcr_opts = {
  cassette_name: "corporation/market_orders",
}

vcr_opts_with_order_id = {
  cassette_name: "corporation/market_orders_order_id",
}

describe Greeve::Corporation::MarketOrders, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) {
    Greeve::Corporation::MarketOrders.new(key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:orders) { should be_a Greeve::Rowset }
  end

  context "orders" do
    subject { resource.orders.first }

    its(:order_id) { should eq 4664702626 }
    its(:char_id) { should eq 462421468 }
    its(:station_id) { should eq 60003652 }
    its(:vol_entered) { should eq 100 }
    its(:vol_remaining) { should eq 100 }
    its(:min_volume) { should eq 1 }
    its(:order_state) { should eq 0 }
    its(:type_id) { should eq 222 }
    its(:range) { should eq 0 }
    its(:account_key) { should eq 1000 }
    its(:duration) { should eq 90 }
    its(:escrow) { should eq BigDecimal.new("26.58") }
    its(:price) { should eq BigDecimal.new("1.12") }
    its(:bid) { should eq true }
    its(:issued) { should eq Time.parse("2016-10-29 20:23:04 UTC") }

    context "with option order_id", vcr: vcr_opts_with_order_id do
      let(:order_id) { 4664745441 }
      let(:resource) {
        Greeve::Corporation::MarketOrders.new(order_id: order_id, key: key, vcode: vcode)
      }

      its(:order_id) { should eq order_id }
      its(:char_id) { should eq 462421468 }
      its(:station_id) { should eq 60003652 }
      its(:vol_entered) { should eq 1000 }
      its(:vol_remaining) { should eq 1000 }
      its(:min_volume) { should eq 1 }
      its(:order_state) { should eq 0 }
      its(:type_id) { should eq 209 }
      its(:range) { should eq 0 }
      its(:account_key) { should eq 1000 }
      its(:duration) { should eq 90 }
      its(:escrow) { should eq BigDecimal.new("500.71") }
      its(:price) { should eq BigDecimal.new("2.11") }
      its(:bid) { should eq true }
      its(:issued) { should eq Time.parse("2016-10-29 21:21:05 UTC") }
    end
  end
end
