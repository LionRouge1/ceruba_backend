require "json"

class Api::V1::DataEntriesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  before_action :set_form, only: [ :create ]
  before_action :authenticate_token_user, only: [ :create ]

  # def index
  #   @data_entries = DataEntry.all
  #   render json: @data_entries
  # end

  def create
    origin = request.headers["Origin"]
    remote_ip = request.remote_ip
    location = country_from_ip(remote_ip)
    user_agent = request.user_agent
    return render json: { error: "Origin is required" }, status: :forbidden if origin.nil?
    data_to_json = params.except(:controller, :action, :format, :form_id, :data_entry).to_json
    print "Data to JSON: #{data_to_json}"
    data_entry = @form.data_entries.new({ location: location, origin: origin, ip_address: remote_ip, user_agent: user_agent, payload: data_to_json })

    if data_entry.save
      render json: data_entry, status: :created
    else
      render json: data_entry.errors, status: :unprocessable_entity
    end
  end

  # def update
  #   if @data_entry.update(data_entry_params)
  #     render json: @data_entry
  #   else
  #     render json: @data_entry.errors, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @data_entry.destroy
  #   head :no_content
  # end


  private

  def set_data_entry
    @data_entry = DataEntry.find(params[:id])
  end

  def authenticate_token_user
    token = request.headers["Authorization"]&.split(" ")&.last
    return render json: { error: "Token missing" }, status: :unauthorized if token.nil?

    user = User.decrypt_id(token)
    return render json: { error: "Invalid token" }, status: :unauthorized if user.nil?

    if user != @form.user
      return render json: { error: "Unauthorized" }, status: :unauthorized
    end
    @current_user = user
  end

  def country_from_ip(ip)
    require "net/http"
    require "json"
    return nil if ip.blank? || ip == "127.0.0.1" || ip == "::1"
    begin
      uri = URI("https://ipapi.co/#{ip}/json/")
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      "#{data['city']}, #{data['region']}, #{data['country_name']}"
    rescue
      nil
    end
  end

  def set_form
    @form = Form.find(params[:form_id])
  end
  # def data_entry_params
  #   params.require(:data_entry).permit(:name, :value)
  # end
end
