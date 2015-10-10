class Uploader
  SALT = "nabro"

  def self.encode(id)
    h = Hashids.new(SALT, 12)
    h.encode(id)
  end

  def self.path(id)
    str = encode(id)
    "/#{str[0]}/#{str[1]}/#{str[2]}/#{str}"
  end

end
