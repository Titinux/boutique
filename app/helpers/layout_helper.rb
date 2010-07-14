module LayoutHelper
  def render_flash_messages
    out = ''

    flash.each do |name, msg|
      out += content_tag :p, :class => "flash #{name}" do
        flash_message = image_tag "icones/#{name}.png"
        flash_message += content_tag :strong, t("flash.names.#{name}")
        flash_message += ": #{msg}"
        flash_message
      end
    end

    out.html_safe
  end
end
