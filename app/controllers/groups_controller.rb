class GroupsController < ApplicationController
    def index
      @groups = current_user.groups
    end

    def new
        @group = Group.new
    end

    def create
      @group = Group.new(params[:group])
      @membership = Membership.new(group: @group, user: current_user)
      @membership.owner = true
      @membership.contributor = true
      @group.memberships << @membership

      if @group.save
        redirect_to @group
      else
        render "new"
      end
    end

    def show
      @group = Group.find(params[:id])
    end
end
