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
  public: [
    {
      name: I18n.t('navigate.welcomepage'),
      link: root_path
    },
    {
      name: Asset.model_name.human.pluralize(I18n.locale),
      link: categories_path
    },
    {
      name: Cart.model_name.human,
      link: cart_path(id: 'current')
    },
    {
      name: I18n.t('statistics.name'),
      link: statistics_path
    },
    {
      name: I18n.t('user.profile'),
      link: user_path
    },
    {
      name: I18n.t('admin.about'),
      link: about_path
    }
  ],
  statistics: {
    public: [
      {
        name: I18n.t('statistics.stockStatistics'),
        link: statistic_path(id: 'stock')
      }
    ],
    admin: [
      {
        name: I18n.t('statistics.stockStatistics'),
        link: admin_statistic_path(id: 'stock')
      },
      {
        name: I18n.t('statistics.pigMoneyBoxStatistics'),
        link: admin_statistic_path(id: 'pigmoneybox')
      }
    ]
  }
}
