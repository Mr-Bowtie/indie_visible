class UptimeController < ApplicationController
  def heartbeat
    head :ok
  end
end
