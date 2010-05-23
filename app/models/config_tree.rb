class ConfigTree < ActiveRecord::Base
  set_table_name 'config_tree'

  #acts_as_nested_set

  has_many :configValues

  def self.value(configPath)
    ct = ConfigTree.root

    configPath.split('.').each do |path|
      ct = ct.children.select{|child| child.name == path}.first

      return '' if ct.blank?
    end

    ct.value
  end
end
