class ApplicationController < ActionController::API
  include RestController

  protected

  def with_org(&block)
    begin
      @org_name = params[:org_name]
      @org_name = "public" if @org_name.nil?
      OrganizationService.with_org params[:org_name], &block
    rescue Exception => e
      rest_error e.message
    end
  end
end
