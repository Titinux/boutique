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
  let(:order) { create(:quote_validation_order) }

  describe 'sending email to administrators' do
    before(:each) do
      5.times { create(:administrator) }
    end

    describe 'order_created_admin' do
      let(:email) { OrderMailer.order_created_admin(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to all admins via bcc header' do
        email.bcc.size.should eq(Administrator.count)

        Administrator.all.each do |admin|
          email.bcc.should include(admin.email)
        end
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end

        it 'mention the user name' do
          email.subject.should match(/#{order.user.name}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain the user name' do
          email.body.should match(/#{order.user.name}/)
        end

        it 'contain assets details (asset name and quantity)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
          end
        end
      end
    end

    describe 'order_in_preparation_admin' do
      let(:email) { OrderMailer.order_in_preparation_admin(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to all admins via bcc header' do
        email.bcc.size.should eq(Administrator.count)

        Administrator.all.each do |admin|
          email.bcc.should include(admin.email)
        end
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end

        it 'mention the user name' do
          email.subject.should match(/#{order.user.name}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain the user name' do
          email.body.should match(/#{order.user.name}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end

    describe 'order_canceled_admin' do
      let(:email) { OrderMailer.order_canceled_admin(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to all admins via bcc header' do
        email.bcc.size.should eq(Administrator.count)

        Administrator.all.each do |admin|
          email.bcc.should include(admin.email)
        end
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end

        it 'mention the user name' do
          email.subject.should match(/#{order.user.name}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain the user name' do
          email.body.should match(/#{order.user.name}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end

    describe 'order_ready_admin' do
      let(:email) { OrderMailer.order_ready_admin(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to all admins via bcc header' do
        email.bcc.size.should eq(Administrator.count)

        Administrator.all.each do |admin|
          email.bcc.should include(admin.email)
        end
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end

        it 'mention the user name' do
          email.subject.should match(/#{order.user.name}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain the user name' do
          email.body.should match(/#{order.user.name}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end

    describe 'order_achieved_admin' do
      let(:email) { OrderMailer.order_achieved_admin(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to all admins via bcc header' do
        email.bcc.size.should eq(Administrator.count)

        Administrator.all.each do |admin|
          email.bcc.should include(admin.email)
        end
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end

        it 'mention the user name' do
          email.subject.should match(/#{order.user.name}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain the user name' do
          email.body.should match(/#{order.user.name}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end
  end

  describe 'sending email to user' do
    describe 'order_created_user' do
      let(:email) { OrderMailer.order_created_user(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to the user via to header' do
        email.to.size.should eq(1)
        email.to.should eq([order.user.email])
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end
      end

      describe '#body' do
        it 'should contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'should contain assets details (asset name and quantity)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
          end
        end
      end
    end

    describe 'wait_estimate_validation_user' do
      let(:email) { OrderMailer.wait_estimate_validation_user(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to the user via to header' do
        email.to.size.should eq(1)
        email.to.should eq([order.user.email])
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end

        it 'contain a link to the order in the user profile' do
          email.body.should match(/#{user_order_url(order, :locale => I18n.locale)}/)
        end
      end
    end

    describe 'order_in_preparation_user' do
      let(:email) { OrderMailer.order_in_preparation_user(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to the user via to header' do
        email.to.size.should eq(1)
        email.to.should eq([order.user.email])
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end

    describe 'order_canceled_user' do
      let(:email) { OrderMailer.order_canceled_user(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to the user via to header' do
        email.to.size.should eq(1)
        email.to.should eq([order.user.email])
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end
      end
    end

    describe 'order_ready_user' do
      let(:email) { OrderMailer.order_ready_user(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to the user via to header' do
        email.to.size.should eq(1)
        email.to.should eq([order.user.email])
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end

    describe 'order_achieved_user' do
      let(:email) { OrderMailer.order_achieved_user(order.id) }

      it 'send exactly one email' do
        expect {
          email.deliver
        }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      it 'be sent to the user via to header' do
        email.to.size.should eq(1)
        email.to.should eq([order.user.email])
      end

      describe '#subject' do
        it 'mention the order id' do
          email.subject.should match(/#{order.id.to_s}/)
        end
      end

      describe '#body' do
        it 'contain the order id' do
          email.body.should match(/#{order.id.to_s}/)
        end

        it 'contain assets details (asset name, quantity, unitary price and price)' do
          order.lines.each do |line|
            email.body.should match(/#{line.asset.name}/)
            email.body.should match(/#{line.quantity}/)
            email.body.should match(/#{number_to_currency(line.unitaryPrice, unit: 'K', precision: 0)}/)
            email.body.should match(/#{number_to_currency(line.total, unit: 'K', precision: 0)}/)
          end
        end

        it 'contain order total' do
          email.body.should match(/#{number_to_currency(order.total, unit: 'K', precision: 0)}/)
        end
      end
    end
  end
end
