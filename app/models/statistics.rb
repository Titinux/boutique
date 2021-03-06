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

class Statistics

  def self.stockStats
    assets   = Asset.arel_table
    deposits = Deposit.arel_table
    orders   = Order.arel_table
    lines    = OrderLine.arel_table

    stocks = deposits.
                     project(deposits[:asset_id], deposits[:quantity].sum.as('stock')).
                     where(deposits[:validated].eq(true)).
                     group(deposits[:asset_id])

    ordereds = lines.
                    project(lines[:asset_id], lines[:quantity].sum.as('ordered')).
                    join(orders, Arel::Nodes::OuterJoin).on(orders[:id].eq(lines[:order_id])).
                    where(orders[:state].in ['preparation', 'delivery']).
                    group(lines[:asset_id])

    s = Arel::Table.new('stocks')
    o = Arel::Table.new('ordereds')
    a = s[:stock] - o[:ordered]

    query = assets.
                  project(assets[:id], assets[:name], s[:stock], o[:ordered], "#{a.to_sql} AS \"available\"").
                  join(  stocks.as('stocks'), Arel::Nodes::OuterJoin).on(assets[:id].eq(s[:asset_id])).
                  join(ordereds.as('ordereds'), Arel::Nodes::OuterJoin).on(assets[:id].eq(o[:asset_id])).
                  order(assets[:name])

    out = ActiveRecord::Base.connection.execute(query.to_sql).to_a
    out.each do |row|
      row['stock']     = row['stock'].to_i
      row['ordered']   = row['ordered'].to_i

      #TODO Utiliser le résultat de la requête directement dès qu'Arel disposera de la fonction coalesce
      row['available'] = row['stock'] - row['ordered']
    end
  end

  def self.pigmoneyboxStats
    users = User.arel_table

    sum_query = users.project(users[:pigMoneyBox].sum)

    out = {}

    out[:sum]      = ActiveRecord::Base.connection.execute(sum_query.to_sql).first['sum_id']
    out[:richests] = User.order(users[:pigMoneyBox].desc).limit(3)

    out
  end
end
