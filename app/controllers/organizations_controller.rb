class OrganizationsController < ApplicationController
	before_action :login_required
	before_action :admin_only, except: [:new, :create]
	before_action :org_id, only: [:admin_edit]

	def approval
		@organizations = Organization.all.order(:approved)
	end

	def new
		@organization = Organization.new
	end

	def create
		@organization = Organization.new(org_params)
		@organization.user_id = current_user.id
		if @organization.save
			flash[:success] = "Organization has been successfully created!"
			redirect_to static_pages_skate_links_path
		else
			flash[:danger] = "Organization has been unsuccessfully created. Please try again."
			render :action => 'new'
		end
	end

	def admin_edit
		# @organization = Organization.find(params[:id])
	end

	def edit
		@organization = Organization.find(params[:id])
	end

	def update
		@organization = Organization.find(params[:id])
		if @organization.update(org_params)
			flash[:success] = "Organization has been successfully updated!"
			redirect_to organizations_approval_path
		else
			flash[:danger] = "Organization has been unsuccessfully updated. Please try again."
			# render :edit
			render :admin_edit
		end
	end

	def destroy
		Organization.find(params[:id]).destroy
		# redirect_to static_pages_skate_links_path
		redirect_to organizations_approval_path
	end

	private
	
		def org_id
			@organization = Organization.find(params["format"])
			return @organization
		end

    def admin_only
      redirect_to static_pages_skate_links_path unless current_user.admin?
    end

    def login_required
      redirect_to login_path unless logged_in?
    end

    def org_params
      params.require(:organization).permit(:name, :category, :website, :email, :phone_num, :youtube, :instagram, :facebook, :twitter, :image_logo, :approved)
    end
end
