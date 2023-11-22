# frozen_string_literal: true

class OrganizationService
  def self.with_org(org_name, &block)
      if org_name
        Apartment::Tenant.switch(org_name) do
          puts "change to tenant of company, name: #{org_name}"
          block&.call
        end
      else
        block&.call
      end
  end
end
