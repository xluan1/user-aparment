# frozen_string_literal: true

class OrganizationController < ApplicationController
  before_filter :set_org, only: [:show]

  def index
    rest_response @organizations = Organization.all
  end

  def show
    rest_response @organization
  end

  def create
    begin
      return @organization if (@organization = Organization.create!(org_params))
      raise "Create organization failed"
    rescue Exception => e
      rest_error e.message
    end
  end

  private

  def set_org
    org_id = params[:id]
    return @organization if (@organization = Organization.find_by_id(org_id))
    rest_error "Not found Organization, id: #{org_id}"
  end

  def org_params
    params.require(:org).permit(:name)
  end
end
