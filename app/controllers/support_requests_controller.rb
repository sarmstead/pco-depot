class SupportRequestsController < ApplicationController
  layout "garage"

  before_action :set_support_request, only: %i[ show update ]

  def index
    @support_requests = SupportRequest.order("created_at asc")
  end

  def show; end

  def update
    @support_request.update(response: params.require(:support_request)[:response])
    SupportRequestMailer.respond(@support_request).deliver_now
    redirect_to support_requests_path
  end

  private

  def set_support_request
      @support_request = SupportRequest.find(params.expect(:id))
  end
end
