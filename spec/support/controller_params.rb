module ControllerParams
  def get(action, parameters = {}, session = nil, flash = nil)
    parameters.merge!(:locale => I18n.locale)

    super
  end

  def post(action, parameters = {}, session = nil, flash = nil)
    parameters.merge!(:locale => I18n.locale)

    super
  end

  def put(action, parameters = {}, session = nil, flash = nil)
    parameters.merge!(:locale => I18n.locale)

    super
  end

  def delete(action, parameters = {}, session = nil, flash = nil)
    parameters.merge!(:locale => I18n.locale)

    super
  end
end
