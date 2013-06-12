class ApplicationController < ActionController::Base
  protect_from_forgery
  utf8_enforcer_workaround
end
