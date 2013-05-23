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

module FormsHelper
  def errors_for(o)
    unless o.errors[:base].empty?
      capture_haml do
        haml_tag 'div#errors' do
          haml_tag 'p.error_title' do
            haml_concat I18n.t('form.errors.title', :count => o.errors[:base].count)
          end

          haml_tag :ul do
            o.errors[:base].each do |msg|
              haml_tag :li do
                haml_concat msg
              end
            end
          end
        end
      end
    end
  end

  module FormBuilderAdditions
    def errors()
      @template.errors_for(@object)
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, FormsHelper::FormBuilderAdditions)
