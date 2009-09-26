{
  :public => [
    {
      :name => I18n.t('navigate.welcomepage'),
      :link => welcome_path
    },
    {
      :name => Asset.human_name.pluralize,
      :link => categories_path
    },
    {
      :name => I18n.t('cart.name'),
      :link => cart_index_path
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
      :name => Guild.human_name.pluralize,
      :link => admin_guilds_path
    },
    {
      :name => User.human_name,
      :link => admin_users_path
    },
    {
      :name => Category.human_name,
      :link => admin_categories_path
    },
    {
      :name => Asset.human_name.pluralize,
      :link => admin_assets_path
    },
    {
      :name => Order.human_name.pluralize,
      :link => admin_orders_path
    },
    {
      :name => I18n.t('deposite.waitingDeposites'),
      :link => admin_deposites_path
    },
    {
      :name => 'Config Tree',
      :link => admin_config_tree_index_path
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
        :link => statistic_path('stock')
      }
    ],
    :admin => [
      {
        :name => I18n.t('statistics.stockStatistics'),
        :link => statistic_path('stock')
      }
    ]
  }
}
