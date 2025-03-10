class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @free_post = FreePost.new
    @groups = Group.page(params[:page]).per(9).order(created_at: :desc)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: "グループを削除しました"
  end

end
