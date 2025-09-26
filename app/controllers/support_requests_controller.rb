class SupportRequestsController < ApplicationController
  layout "garage"

  before_action :set_support_request, only: %i[ show ]

  def index
    @support_requests = SupportRequest.order("created_at desc")
  end

  def show; end

  private

  def set_support_request
      @support_request = SupportRequest.find(params.expect(:id))
  end
end
