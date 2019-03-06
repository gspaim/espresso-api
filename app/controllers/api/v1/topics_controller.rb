class Api::V1::TopicsController < Api::V1::ApiController

  # Metodos são disparados antes da 'Action' solicitada
  before_action :set_topic, only: [:show, :update, :destroy]
  before_action :require_authorization!, only: [:update, :destroy]

  # GET /api/v1/topics
 
  def index

    @topics = Topic.all
    render json: @topics

  end

  # GET /api/v1/topics/1
 
  def show
 
    render json: @topic

  end

  # POST /api/v1/topics
 
  def create
    
    #binding.pry

    @topic = Topic.new(topic_params.merge(user: current_user))

    if @topic.save

      render json: @topic, status: :created

    else

      render json: @topic.errors, status: :unprocessable_entity

    end

  end

  # PATCH/PUT /api/v1/topics/1
 
  def update
 
    if @topic.update(topic_params)

      render json: @topic

    else

      render json: @topic.errors, status: :unprocessable_entity

    end

  end

   # DELETE /api/v1/topics/1
 
  def destroy
 
    @topic.destroy

  end


  private
 
    def set_topic
  
      @topic = Topic.find(params[:id])
  
    end
  
    def topic_params
  
      params.require(:topic).permit(:title, :description)
  
    end
  
    def require_authorization!
  
      unless current_user == @topic.user
  
        render json: {}, status: :forbidden
  
      end
  
    end
 
end