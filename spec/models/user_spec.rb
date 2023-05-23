# frozen_string_literal: true

RSpec.describe User, type: :model do
  let(:user) do
    User.new(name: 'example user', email: 'user@example.com',
             password: 'foobar', password_confirmation: 'foobar')
  end

  it 'should be valid' do
    expect(user).to be_valid
  end

  it 'should be invalid when name is blank' do
    user.name = '  '
    expect(user).not_to be_valid
  end

  it 'should be invalid when email is blank' do
    user.email = '  '
    expect(user).not_to be_valid
  end

  context 'email ' do
    let(:valid_addresses) do
      %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
         first.last@foo.jp alice+bob@baz.cn]
    end

    let(:invalid_addresses) do
      %w[userexample.com USERoo.COM A_US-ERfoo.bar.org
         first.lastfoo.jp alice+bobbaz.cn]
    end

    let(:mixed_email) do
      'useR@exAmple.com'
    end

    it 'should accept valid addresses' do
      valid_addresses.each do |address|
        user.email = address
        expect(user).to be_valid, "#{address.inspect} should be valid"
      end
    end

    it 'should reject invalid addresses' do
      invalid_addresses.each do |address|
        user.email = address
        expect(user).not_to be_valid, "#{address.inspect} should be invalid"
      end
    end

    it 'addresses should be unique' do
      duplicate_user = user.dup
      # duplicate_user.email=user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'address is saved as lower case' do
      user.email = mixed_email
      user.save

      expect(user.reload.email).to eq mixed_email.downcase
    end
  end

  context 'password' do
    it 'password should be present(nonblank)' do
      user.password = user.password_confirmation = ' ' * 6
      expect(user).not_to be_valid
    end
    it 'password should have a minimum length' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).not_to be_valid
    end
  end
end
