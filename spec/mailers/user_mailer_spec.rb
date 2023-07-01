# frozen_string_literal: true
# require 'rails_helper'

# RSpec.describe UserMailer, type: :mailer do
#   describe 'account_activation' do
#     let(:user) do
#       User.create(name: 'Michael', email: 'michael@example.com', password: 'password',
#                   password_confirmation: 'password', activation_token: User.new_token)
#     end

#     let(:mail) { UserMailer.account_activation(user) }

#     it 'renders the headers' do
#       expect(mail.subject).to eq(ACCOUNT_ACTIVATION)
#       expect(mail.to).to eq(['to@example.org'])
#       expect(mail.from).to eq(['from@example.com'])
#     end

#     #   it 'renders the body' do
#     #     expect(mail.body.encoded).to match('Hi')
#     #   end
#     # end

#     # describe 'password_reset' do
#     #   let(:mail) { UserMailer.password_reset }

#     #   it 'renders the headers' do
#     #     expect(mail.subject).to eq('Password reset')
#     #     expect(mail.to).to eq(['to@example.org'])
#     #     expect(mail.from).to eq(['from@example.com'])
#     #   end

#     #   it 'renders the body' do
#     #     expect(mail.body.encoded).to match('Hi')
#     #   end
#   end
# end
