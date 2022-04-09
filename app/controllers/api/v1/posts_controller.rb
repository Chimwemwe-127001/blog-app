module Api
  module V1
    class PostsController < ApplicationController
      def index
        user = User.find_by_id(1)
        respond_to do |format|
          if user
            format.json { render json: user.posts }
          else
            format.json { render json: { success: false, message: ['User must exist'] } }
          end
        end
      end
    end
  end
end
