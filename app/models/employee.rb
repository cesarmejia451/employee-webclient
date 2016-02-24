class Employee 

  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :birthday

  def initialize(hash)
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @birthday = Time.new(hash["birthday"])
  end

  def pretty_birthday
    birthday.strftime("%b %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find(id)
    Employee.new(Unirest.get("#{ENV['API_BASE_URL']}/employees/#{id}.json").body)
  end

  def self.all
    api_employees_array = Unirest.get("#{ENV['API_BASE_URL']}/employees.json").body
    employees = []
    api_employees_array.each { |api_employee| employees << self.new(api_employee) }
    employees
  end

  def destroy
    Unirest.delete("#{ENV['API_BASE_URL']}/employees/#{id}.json", headers:{ "Accept" => "application/json" }).body
  end

end