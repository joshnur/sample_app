class User
    attr_accessor :name, :email

  def initialize (attributes ={})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end

def return11
  return 11
end