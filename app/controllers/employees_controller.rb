class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
    # api_employees_array = Unirest.get("http://localhost:3000/employees.json").body
    # @employees = []
    # api_employees_array.each { |api_employee| @employees << Employee.new(api_employee) }
  end

  def new
  end

  def create
    @employee = Unirest.post("http://localhost:3000/employees.json", headers:{ "Accept" => "application/json" }, parameters:{ first_name: params[:first_name], last_name: params[:last_name], email: params[:email] }).body

    render :show 
  end 

  def edit
    @employee = Unirest.get("http://localhost:3000/employees/#{params[:id]}/edit.json")
  end

  def update
    @employee = Unirest.patch("http://localhost:3000/employees.json", headers:{ "Accept" => "application/json" }, parameters:{ first_name: params[:first_name], last_name: params[:last_name], email: params[:email] }).body

    render :show 
  end

  def destroy
   @employee = Employee.find(params[:id])
   message = @employee.destroy

   flash[:message] = message["message"]
   redirect_to "/employees"

  end
end
