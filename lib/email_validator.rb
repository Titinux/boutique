# Thanks to Ramihajamalala Hery
# https://github.com/hallelujah/valid_email/blob/master/lib/valid_email/email_validator.rb

require 'active_model'
require 'active_model/validations'
require 'mail'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    begin
      m = Mail::Address.new(value)

      # Verify domain format
      r = /^\S+\.\S+$/.match(m.domain).present?
    rescue Exception
      r = false
    end

    record.errors[attribute] << (options[:message] || I18n.t('errors.invalid')) unless r
  end
end
