class Uploader
  SALT = "nabro"
  SIZE = 16

  def self.encode(id)
    h = Hashids.new(SALT, SIZE)
    h.encode(id)
  end

  def self.path(id)
    str = encode(id)
    "/#{str[0]}/#{str[1]}/#{str[2]}/#{str}"
  end

end

class ActiveRecord::Base
  def encrypted_id
    h = Hashids.new(Uploader::SALT + self.class.table_name, Uploader::SIZE)
    h.encode(id)
  end

  def self.decrypt_id(token)
    h = Hashids.new(Uploader::SALT + self.table_name, Uploader::SIZE)
    h.decode(token).first
  end

  def self.find_by_encrypt_id(token)
    find decrypt_id(token)
  end
end
