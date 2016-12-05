class AdminsController < ApplicationController

	before_filter :authenticate_admin!

	def show_referrers
		#@referrers = User.where(role: User.roles[:referrer]).where.not(invitation_accepted_at: nil)
		@referrers = Form.where(form_type: 1)
		if params[:status] and params[:status] != 'Status'
			@referrers = @referrers.where(status: params[:status])
		end
		@status = params[:status]
		render :show_referrers
	end

	def show_clients
		@clients = Form.where(form_type: 3).order("created_at DESC")
		if params[:status] and params[:status] != 'Status'
			@clients = @clients.where(status: params[:status]).all
		end
		@status = params[:status]
		render :show_clients
	end

	def show_referrals
		@forms = Form.where(:form_type => 2)
		render :show_referrals
	end

	def mark_referrer_status
		id = params[:id]
		form_id = params[:form_id]
		status = params[:status]
		@referrer = User.find_by_id(id)
		@form = Form.find_by_id(form_id)
		@form.status = status
		@form.save
		flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}"
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(@referrer).deliver_now # sends the email
		end
		redirect_to referrers_path
	end

	def mark_client_status
		id = params[:id]
		form_id = params[:form_id]
		status = params[:status]
		@client = User.find_by_id(id)
		@form = Form.find_by_id(form_id)
		@form.status = status
		@form.save
		flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}"
		if status == "Incomplete"
			# send notification to them via email
			NotifierMailer.incomplete_referrer_profile(@client).deliver_now # sends the email
		end
		redirect_to clients_path
	end

	def mark_form_status
		id = params[:id]
		status = params[:status]
		@form = Form.find(id)
		@form.status = status
		@form.save
		flash[:notice] = "#{@form.first_name} #{@form.last_name} has been marked as #{@form.status.downcase}"
		redirect_to admin_referrals_path
	end

	def show
		@user = Admin.find_by_id(params[:id])
	end
end
