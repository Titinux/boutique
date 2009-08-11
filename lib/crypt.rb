require 'digest/sha2'

module Crypt
  def computeSalt
    [Array.new(6){rand(256).chr}.join].pack("m").chomp
  end
  
  def computePassword(salt, clear_password)
    Digest::SHA256.hexdigest(clear_password + salt)
  end
  
  def self.makeRandomSequence(length)
    [Array.new(length){rand(256).chr}.join].pack("m").chomp
  end
end

    
