# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # どこからでもsessionコントローラーのメソッドが呼び出せるようにした
  include SessionsHelper
end
