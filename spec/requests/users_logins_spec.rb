require 'rails_helper'

RSpec.describe 'UsersLogins', type: :request do
  let(:michael) do
    User.create(
      name: 'Michael Example',
      email: 'michael@example.com',
      password_digest: User.digest('password')
    )
  end

  describe 'POST /users_logins' do
    it 'logs in user with valid information' do
      post login_path, params: {
        session: {
          email: michael.email,
          password: 'password'
        }
      }

      expect(response).to redirect_to(user_path(michael))
      follow_redirect!
      expect(response).to render_template('users/show')
      expect(response.body).not_to include(login_path)
      expect(response.body).to include(logout_path)
      expect(response.body).to include(user_path(michael))
    end
  end
end
