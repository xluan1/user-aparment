class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  after_create :create_tenant

  private

  def create_tenant
    Apartment::Tenant.create(name)
  end
end
