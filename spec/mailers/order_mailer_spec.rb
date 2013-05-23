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
include ActionView::Helpers::NumberHelper

describe OrderMailer do
  describe 'order_created_admin' do
    before(:each) do
      @order = build(:order)
      5.times { create(:administrator) }
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_created_admin(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to all admins via bcc header' do
      email = OrderMailer.order_created_admin(@order).deliver
      email.bcc.size.should eq(Administrator.count)

      Administrator.all.each do |admin|
        email.bcc.should include(admin.email)
      end
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.order_created_admin(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end

      it 'should mention the user name' do
        email = OrderMailer.order_created_admin(@order).deliver

        email.subject.should match(/#{@order.user.name}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.order_created_admin(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain the user name' do
        email = OrderMailer.order_created_admin(@order).deliver

        email.body.should match(/#{@order.user.name}/)
      end

      it 'should contain assets details (asset name and quantity)' do
        email = OrderMailer.order_created_admin(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
        end
      end
    end
  end

  describe 'order_created_user' do
    before(:each) do
      @order = build(:order)
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_created_user(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to the user via to header' do
      email = OrderMailer.order_created_user(@order).deliver
      email.to.size.should eq(1)
      email.to.should eq([@order.user.email])
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.order_created_user(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.order_created_user(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain assets details (asset name and quantity)' do
        email = OrderMailer.order_created_user(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
        end
      end
    end
  end

  describe 'wait_estimate_validation_user' do
    before(:each) do
      @order = build(:estimated_order)
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.wait_estimate_validation_user(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to the user via to header' do
      email = OrderMailer.wait_estimate_validation_user(@order).deliver
      email.to.size.should eq(1)
      email.to.should eq([@order.user.email])
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.wait_estimate_validation_user(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.wait_estimate_validation_user(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        email = OrderMailer.wait_estimate_validation_user(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
          email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        email = OrderMailer.wait_estimate_validation_user(@order).deliver

        email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end

      it 'should contain a link to the order in the user profile' do
        email = OrderMailer.wait_estimate_validation_user(@order).deliver

        email.body.should match(/#{user_order_url(@order, :locale => I18n.locale)}/)
      end
    end
  end

  describe 'order_in_preparation_admin' do
    before(:each) do
      @order = build(:in_preparation_order)
      5.times { create(:administrator) }
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_in_preparation_admin(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to all admins via bcc header' do
      email = OrderMailer.order_in_preparation_admin(@order).deliver
      email.bcc.size.should eq(Administrator.count)

      Administrator.all.each do |admin|
        email.bcc.should include(admin.email)
      end
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.order_in_preparation_admin(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end

      it 'should mention the user name' do
        email = OrderMailer.order_in_preparation_admin(@order).deliver

        email.subject.should match(/#{@order.user.name}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.order_in_preparation_admin(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain the user name' do
        email = OrderMailer.order_in_preparation_admin(@order).deliver

        email.body.should match(/#{@order.user.name}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        email = OrderMailer.order_in_preparation_admin(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
          email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        email = OrderMailer.order_in_preparation_admin(@order).deliver

        email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

  describe 'order_in_preparation_user' do
    before(:each) do
      @order = build(:in_preparation_order)
      @email = OrderMailer.order_in_preparation_user(@order).deliver
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_in_preparation_user(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to the user via to header' do
      @email.to.size.should eq(1)
      @email.to.should eq([@order.user.email])
    end

    describe '#subject' do
      it 'should mention the order id' do
        @email.subject.should match(/#{@order.id.to_s}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        @email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        @order.lines.each do |line|
          @email.body.should match(/#{line.asset.name}/)
          @email.body.should match(/#{line.quantity}/)
          @email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          @email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        @email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

  describe 'order_canceled_admin' do
    before(:each) do
      @order = build(:canceled_order)
      5.times { create(:administrator) }
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_canceled_admin(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to all admins via bcc header' do
      email = OrderMailer.order_canceled_admin(@order).deliver
      email.bcc.size.should eq(Administrator.count)

      Administrator.all.each do |admin|
        email.bcc.should include(admin.email)
      end
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.order_canceled_admin(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end

      it 'should mention the user name' do
        email = OrderMailer.order_canceled_admin(@order).deliver

        email.subject.should match(/#{@order.user.name}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.order_canceled_admin(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain the user name' do
        email = OrderMailer.order_canceled_admin(@order).deliver

        email.body.should match(/#{@order.user.name}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        email = OrderMailer.order_canceled_admin(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
          email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        email = OrderMailer.order_canceled_admin(@order).deliver

        email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

  describe 'order_canceled_user' do
    before(:each) do
      @order = build(:canceled_order)
      @email = OrderMailer.order_canceled_user(@order).deliver
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_canceled_user(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to the user via to header' do
      @email.to.size.should eq(1)
      @email.to.should eq([@order.user.email])
    end

    describe '#subject' do
      it 'should mention the order id' do
        @email.subject.should match(/#{@order.id.to_s}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        @email.body.should match(/#{@order.id.to_s}/)
      end
    end
  end

  describe 'order_ready_admin' do
    before(:each) do
      @order = build(:ready_order)
      5.times { create(:administrator) }
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_ready_admin(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to all admins via bcc header' do
      email = OrderMailer.order_ready_admin(@order).deliver
      email.bcc.size.should eq(Administrator.count)

      Administrator.all.each do |admin|
        email.bcc.should include(admin.email)
      end
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.order_ready_admin(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end

      it 'should mention the user name' do
        email = OrderMailer.order_ready_admin(@order).deliver

        email.subject.should match(/#{@order.user.name}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.order_ready_admin(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain the user name' do
        email = OrderMailer.order_ready_admin(@order).deliver

        email.body.should match(/#{@order.user.name}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        email = OrderMailer.order_ready_admin(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
          email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        email = OrderMailer.order_ready_admin(@order).deliver

        email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

  describe 'order_ready_user' do
    before(:each) do
      @order = build(:ready_order)
      @email = OrderMailer.order_ready_user(@order).deliver
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_ready_user(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to the user via to header' do
      @email.to.size.should eq(1)
      @email.to.should eq([@order.user.email])
    end

    describe '#subject' do
      it 'should mention the order id' do
        @email.subject.should match(/#{@order.id.to_s}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        @email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        @order.lines.each do |line|
          @email.body.should match(/#{line.asset.name}/)
          @email.body.should match(/#{line.quantity}/)
          @email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          @email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        @email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

  describe 'order_achieved_admin' do
    before(:each) do
      @order = build(:achieved_order)
      5.times { create(:administrator) }
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_achieved_admin(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to all admins via bcc header' do
      email = OrderMailer.order_achieved_admin(@order).deliver
      email.bcc.size.should eq(Administrator.count)

      Administrator.all.each do |admin|
        email.bcc.should include(admin.email)
      end
    end

    describe '#subject' do
      it 'should mention the order id' do
        email = OrderMailer.order_achieved_admin(@order).deliver

        email.subject.should match(/#{@order.id.to_s}/)
      end

      it 'should mention the user name' do
        email = OrderMailer.order_achieved_admin(@order).deliver

        email.subject.should match(/#{@order.user.name}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        email = OrderMailer.order_achieved_admin(@order).deliver

        email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain the user name' do
        email = OrderMailer.order_achieved_admin(@order).deliver

        email.body.should match(/#{@order.user.name}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        email = OrderMailer.order_achieved_admin(@order).deliver

        @order.lines.each do |line|
          email.body.should match(/#{line.asset.name}/)
          email.body.should match(/#{line.quantity}/)
          email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        email = OrderMailer.order_achieved_admin(@order).deliver

        email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

  describe 'order_achieved_user' do
    before(:each) do
      @order = build(:achieved_order)
      @email = OrderMailer.order_achieved_user(@order).deliver
    end

    it 'should send exactly one email' do
      expect {
        OrderMailer.order_achieved_user(@order).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it 'should be sent to the user via to header' do
      @email.to.size.should eq(1)
      @email.to.should eq([@order.user.email])
    end

    describe '#subject' do
      it 'should mention the order id' do
        @email.subject.should match(/#{@order.id.to_s}/)
      end
    end

    describe '#body' do
      it 'should contain the order id' do
        @email.body.should match(/#{@order.id.to_s}/)
      end

      it 'should contain assets details (asset name, quantity, unitary price and price)' do
        @order.lines.each do |line|
          @email.body.should match(/#{line.asset.name}/)
          @email.body.should match(/#{line.quantity}/)
          @email.body.should match(/#{number_to_currency(line.unitaryPrice)}/)
          @email.body.should match(/#{number_to_currency(line.price)}/)
        end
      end

      it 'should contain order total' do
        @email.body.should match(/#{number_to_currency(@order.totalAmount)}/)
      end
    end
  end

end
