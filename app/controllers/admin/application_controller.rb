# frozen_string_literal: true

# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin
    helper_method :decorate_has_many_objects

    def authenticate_admin
      # TODO: Add authentication logic here.
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
    # INFO: only implemented here because using helper modules did not seem to carry the method thorugh to the views properly
    private

    def decorate_has_many_objects(resource_arr)
      resource_arr.map { |resource| [human_readable_id(resource), resource.id] }
    end

    def human_readable_id(obj)
      return obj.name if obj.respond_to?(:name)
      return obj.title if obj.respond_to?(:title)

      "#{obj.class} ##{obj.id}"
    end
  end
end
