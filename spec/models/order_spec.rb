# Boutique is a saleroom website for Dofus resources, originally created
# for the merchant guild "Les Marchands d'Hyze"
# Copyright (C) 2013 - Jérémie Horhant (jeremie dot horhant at titinux dot net)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper'

describe Order do
  let(:order) { build(:order) }

  it 'is valid with valid attributes' do
    order.should be_valid
  end

  describe 'relations' do
    it { should belong_to :user }
    it { should have_many(:lines).class_name('OrderLine') }
  end

  describe '#lines' do
    it 'at least one line is present' do
      build(:order, lines: []).should_not be_valid
    end
  end

  describe '#state' do
    it 'initial state is quotation' do
      order.state.should eq('quotation')
    end
  end

  describe '#total' do
    it 'is the sum of lines prices' do
      OrderLine.any_instance.stub(:total).and_return(42)

      order.total.should eq(42*order.lines.size)
    end
  end

  describe 'quote_ready?' do
    let(:order) { Order.new }

    it 'return true if all lines have unitaryPrice defined' do
      order.lines << build(:order_line, unitaryPrice: 5)
      order.lines << build(:order_line, unitaryPrice: 12)

      order.quote_ready?.should be_true
    end

    it 'return false if there is one line with undefined unitaryPrice' do
      order.lines << build(:order_line, unitaryPrice: 5)
      order.lines << build(:order_line)

      order.quote_ready?.should be_false
    end
  end

  describe 'available?' do
    let(:order) { build(:quote_validation_order) }

    context 'stock are sufficient' do
      before(:each) do
        order.lines.each do |line|
          create(:validated_deposit, asset_id: line.asset.id, quantity: line.quantity)
        end

        it 'return true' do
          order.available?.should be_true
        end
      end
    end

    context 'stock are insufficient' do
      before(:each) do
        order.lines.each do |line|
          create(:validated_deposit, asset_id: line.asset.id, quantity: line.quantity-1)
        end

        it 'return false' do
          order.available?.should_not be_true
        end
      end
    end
  end

  context "quotation" do
    it "can be canceled" do
      order.state_events.should include(:cancel)
    end

    context "quote is not ready" do
      before(:each) { Order.any_instance.stub(:quote_ready?).and_return(false) }

      it "quote_done event is not available if quote_ready? is false" do
        order.state_events.should_not include(:quote_done)
      end
    end

    context "quote is ready" do
      before(:each) { Order.any_instance.stub(:quote_ready?).and_return(true) }

      it "quote_done event is available if quote_ready? is true" do
        order.state_events.should include(:quote_done)
      end

      it "change state from quotation to quote_validation when quote_done event is fired" do
        expect{
          order.quote_done
        }.to change{order.state}.from('quotation').to('quote_validation')
      end
    end
  end

  context "quote_validation" do
    let(:order) { build(:quote_validation_order) }

    it "quote_accepted event is available" do
      order.state_events.should include(:quote_accepted)
    end

    it "can be canceled" do
      order.state_events.should include(:cancel)
    end

    it "change state from quote_validation to preparation when quote_accepted event is fired" do
      expect{
        order.quote_accepted
      }.to change{order.state}.from('quote_validation').to('preparation')
    end
  end

  context "preparation" do
    let(:order) { build(:preparation_order) }

    it "prepared event is available" do
      order.state_events.should include(:prepared)
    end

    it "can be canceled" do
      order.state_events.should include(:cancel)
    end

    it "change state from preparation to delivery when prepared event is fired" do
      expect{
        order.prepared
      }.to change{order.state}.from('preparation').to('delivery')
    end
  end

  context "delivery" do
    let(:order) { build(:delivery_order) }

    it "delivered event is available" do
      order.state_events.should include(:delivered)
    end

    it "can be canceled" do
      order.state_events.should include(:cancel)
    end

    it "change state from delivery to complete when delivered event is fired" do
      expect{
        order.delivered
      }.to change{order.state}.from('delivery').to('complete')
    end
  end

  context "complete" do
    let(:order) { build(:complete_order) }

    it "can't be canceled" do
      order.state_events.should_not include(:cancel)
    end
  end

  context "canceled" do
    let(:order) { build(:canceled_order) }

    it "can't be canceled again" do
      order.state_events.should_not include(:cancel)
    end
  end
end
