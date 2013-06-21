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

class JobQueue
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def initialize(sidekiq_queue)
    @sidekiq_queue = sidekiq_queue
  end

  def jobs
    @sidekiq_queue.map { |a| Job.new(a) }
  end

  def delete_job(jid)
    jobs.map { |w| w.destroy if w.jid == jid }
  end

  def name
    case @sidekiq_queue.class.to_s
      when 'Sidekiq::ScheduledSet' then 'scheduled'
      when 'Sidekiq::RetrySet' then 'retry'
      else @sidekiq_queue.name
    end
  end

  def size
    @sidekiq_queue.size
  end

  def to_param
    self.name
  end

  def self.find(name)
    case name
      when 'scheduled' then new(Sidekiq::ScheduledSet.new)
      when 'retry'     then new(Sidekiq::RetrySet.new)
      else new(Sidekiq::Queue.new(name))
    end
  end

  def self.all
    queues = stats.queues.keys
    queues << 'scheduled'
    queues << 'retry'

    queues.map { |q| find(q) }
  end

  def self.stats
    @stats ||= Sidekiq::Stats.new
  end
end
