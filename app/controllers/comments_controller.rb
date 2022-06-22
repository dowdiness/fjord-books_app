# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :only_author, only: %i[edit update destroy]

  def show
    render 'comments/show'
  end

  def edit
    render 'comments/edit'
  end

  def create
    @comment = @commentable.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to [@commentable, @comment], notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @commentable, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@commentable, @comment], notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render 'comments/edit', status: :unprocessable_entity
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @comment.destroy

    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_commentable(model, model_name)
    @commentable = model.find(params["#{model_name}_id".to_sym])
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def only_author
    return if @comment.author?(current_user)

    redirect_to @commentable, status: :unauthorized, alert: t('controllers.common.notice_only_author', name: Comment.model_name.human)
  end
end
