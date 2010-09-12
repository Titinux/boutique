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
      :link => cart_path
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
      :name => User.model_name.human,
      :link => admin_users_path
    },
    {
      :name => Administrator.model_name.human.pluralize,
      :link => admin_administrators_path
    },
    {
      :name => Category.model_name.human,
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
      :name => Job.model_name.human.pluralize,
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
      :link => destroy_administrator_session_path
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
