# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comment = @commentable.comments.build
    @comments = @commentable.comments.order(:id).page(params[:page])
    render 'comments/index'
  end

  def show
    render 'comments/show'
  end

  def new
    @comment = @commentable.comments.build
    render 'comments/new'
  end

  def edit
    render 'comments/edit'
  end

  def create
    @comment = @commentable.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to [@commentable, @comment], notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@commentable, @comment], notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @comment.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
