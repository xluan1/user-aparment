class UserJob
  include Sidekiq::Job

  def perform(org_name, username)
    OrganizationService.with_org org_name do
      if (@user = User.find_by_username username)
        puts @user
      else
        raise "not found User, username: #{args}"
      end
    end
  end
end
