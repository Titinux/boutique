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

{
  :public => [
    {
      :name => I18n.t('navigate.welcomepage'),
      :link => root_path
    },
    {
      :name => Asset.model_name.human.pluralize,
      :link => categories_path
    },
    {
      :name => Cart.model_name.human,
      :link => cart_path(:id => 'current')
    },
    {
      :name => I18n.t('statistics.name'),
      :link => statistics_path
    },
    {
      :name => I18n.t('user.profile'),
      :link => user_path
    }
  ],
  :admin => [
    {
      :name => Guild.model_name.human.pluralize,
      :link => admin_guilds_path
    },
    {
      :name => User.model_name.human.pluralize,
      :link => admin_users_path
    },
    {
      :name => Administrator.model_name.human.pluralize,
      :link => admin_administrators_path
    },
    {
      :name => Category.model_name.human.pluralize,
      :link => admin_categories_path
    },
    {
      :name => Asset.model_name.human.pluralize,
      :link => admin_assets_path
    },
    {
      :name => Order.model_name.human.pluralize,
      :link => admin_orders_path
    },
    {
      :name => Deposit.model_name.human.pluralize,
      :link => admin_deposits_path
    },
    {
      :name => I18n.t('statistics.name'),
      :link => admin_statistics_path
    },
    {
      :name => Delayed::Job.model_name.human.pluralize,
      :link => admin_jobs_path
    },
    {
      :name => Log.model_name.human.pluralize,
      :link => admin_logs_path
    },
    {
      :name => I18n.t('navigate.publicPart'),
      :link => root_path
    },
    {
      :name => I18n.t('devise.links.sign_out'),
      :link => destroy_administrator_session_path,
      :link_opts => { method: :delete }
    }
  ],
  :statistics => {
    :public => [
      {
        :name => I18n.t('statistics.stockStatistics'),
        :link => statistic_path(:id => 'stock')
      }
    ],
    :admin => [
      {
        :name => I18n.t('statistics.stockStatistics'),
        :link => admin_statistic_path(:id => 'stock')
      },
      {
        :name => I18n.t('statistics.pigMoneyBoxStatistics'),
        :link => admin_statistic_path(:id => 'pigmoneybox')
      }
    ]
  }
}
