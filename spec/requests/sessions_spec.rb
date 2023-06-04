# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get login_path
      expect(response).to render_template('sessions/new')
      post login_path, params: {
        session: {
          email: '',
          password: ''
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('sessions/new')
      expect(flash).not_to be_empty
      get login_path
      expect(flash).to be_empty
    end
  end
end
