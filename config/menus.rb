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
      :name => I18n.t('cart.name'),
      :link => carts_path
    },
    {
      :name => I18n.t('statistics.name'),
      :link => statistics_path
    },
    {
      :name => I18n.t('user.profile'),
      :link => user_path, :condition => user_session.login?
    },
    {
      :name => I18n.t('navigate.adminPart'),
      :link => admin_root_path,
      :condition => (user_session.login? and user_session.user.admin)
    },
    {
      :name => I18n.t('userSession.logout'),
      :link => logout_path,
      :link_opts => { :method => :delete },
      :condition => user_session.login?
    },
    {
      :name => I18n.t('userSession.authenticate'),
      :link => login_path,
      :condition => (not user_session.login?)
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
