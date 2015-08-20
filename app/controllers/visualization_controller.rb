class VisualizationController < ApplicationController

  def index
  end

  def projects
    client = Mongo::Client.new('mongodb://farhan:123456@ds031903.mongolab.com:31903/donorschoose')
    #client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'donorschoose')
    #client = Mongo::Client.new('mongodb://127.0.0.1:27017/donorschoose')
    fields = {'school_state' => true , 'resource_type' => true, 'poverty_level' => true, 'date_posted' => true, 'total_donations' => true, '_id' => false }
    @projects = client[:projects].find.projection(fields)

    respond_to do |format|
      format.json { render json: @projects }
    end
  end

  def get_geo_json
    filename ||= "#{Rails.root}/lib/us-states.json"
    file = File.read(filename)

    respond_to do |format|
      format.json { render json: JSON.parse(file) }
    end

  end

end
