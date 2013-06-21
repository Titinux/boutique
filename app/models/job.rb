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

class Job
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  attr_reader :sidekiq_worker
  delegate :klass, to: :sidekiq_worker

  def initialize(worker)
    @sidekiq_worker = worker
  end

  %w(queue args jid retry error_class error_message failed_at retry_count).each do |method|
    define_method(method) do
      @sidekiq_worker.item[method]
    end
  end

  %w(failed_at retried_at).each do |method|
    define_method(method) do
      value = @sidekiq_worker.item[method]
      Time.parse(value).in_time_zone if value
    end
  end

  def enqueued_at
    value = @sidekiq_worker.item['enqueued_at']
    Time.at(value) if value
  end

  def destroy
    @sidekiq_worker.delete
  end

  def to_param
    self.jid
  end
end
