module Devise
  module Encryptable
    module Encryptors
      class UserEncryptor < Base
        def self.digest(password, stretches, salt, pepper)
          str = [password, salt].compact.flatten.join
          Digest::SHA256.hexdigest(str)
        end
      end
    end
  end
end
