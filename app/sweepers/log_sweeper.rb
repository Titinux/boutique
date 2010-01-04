class LogSweeper < ActionController::Caching::Sweeper
  observe Asset, Category, Deposit, Guild, Job, Order, OrderLine, User

  def after_create(record)
    LogTools::log_me(record, { :user => current_user_name, :action => 'create' })
  end

  def after_update(record)
    LogTools::log_me(record, { :user => current_user_name, :action => 'update', :data => record.attributes.merge(record.changes) })
  end

  def before_destroy(record)
    LogTools::log_me(record, { :user => current_user_name, :action => 'destroy' })
  end

  private

  def current_user_name
    if user_session.nil?
      'system'
    elsif user_session.login?
      user_session.user.name
    else
      'anonymous'
    end
  end
end
