module Api
  module V1
    class CommentsController < ApplicationController
      def index
        user = User.find_by_id(1)

        respond_to do |format|
          if user
            post = user.posts.first
            if post
              format.json { render json: post.comments }
            else
              format.json { render json: { success: false, message: ['Post must exist'] } }
            end
          else
            format.json { render json: { success: false, message: ['User must exist'] } }
          end
        end
      end

      def create
        user = User.find_by_id(1)

        respond_to do |format|
          if user
            post = user.posts.first
            if post
              comment = post.comments.new(author: user, post_id: post.id, Text: params[:Text])
              comment.users_id = user.id
              if comment.save
                format.json { render json: comment, status: :ok, message: 'Comment created successfully' }
              else
                format.json { render json: { success: false, message: ['Comment not saved'] } }
              end
            else
              format.json { render json: { success: false, message: ['Post must exist'] } }
            end
          else
            format.json { render json: { success: false, message: ['User must exist'] } }
          end
        end
      end
    end
  end
end