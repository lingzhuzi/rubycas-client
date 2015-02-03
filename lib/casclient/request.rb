# encoding: utf-8
module CASClient
  class Request
    def self.logout_request?(request)
      logout_request_reg = %r{^<samlp:LogoutRequest.*?<samlp:SessionIndex>(.*)</samlp:SessionIndex>}m

      CASClient::Frameworks::Rails::Filter.config[:enable_single_sign_out] &&
      request.post? && request.params['logoutRequest'].present? &&
      [request.params['logoutRequest'], URI.unescape(request.params['logoutRequest'])].find{|xml| xml =~ logout_request_reg}
    end
  end
end