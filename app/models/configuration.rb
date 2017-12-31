class Configuration < ApplicationRecord
  def self.setting key
    find_by_key(key.to_s).try(:value)
  end
end
