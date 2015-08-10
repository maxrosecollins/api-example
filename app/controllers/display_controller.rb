require 'json'
class DisplayController < ApplicationController
  def index
    api = Display.new
    @qualifications = JSON.parse(api.qualifications)


    if params[:q].present?
      @qualifications = @qualifications.select{ |qualification| qualification["name"].downcase.include? params[:q].downcase }
      if @qualifications.empty?
        @qualifications = [{"id" => 0, "name" => "No qualifications for your search terms", "subjects" => {}}]
      end
    else
      @qualifications
    end


    respond_to do |format|
      format.html
      format.json { render json: @qualifications.to_json }
    end
  end
end
