class Api::V1::PostsController < Api::V1::ApiController

  before_action :set_post, only: [:show, :update, :destroy]
  before_action :require_authorization!, only: [:update, :destroy]
 
  has_scope :by_topic, only: :index

  # GET /api/v1/posts

  # Filters:
  # /api/v1/posts?by_topic=1

  def index

    @posts = apply_scopes(Post).all
    render json: @posts.order('created_at DESC')
  
  end

  # GET /api/v1/posts/1
 
  def show
  
    render json: @post

  end

  # POST /api/v1/posts
 
  def create

    @post = Post.new(post_params.merge(user: current_user))

    if @post.save

      render json: @post, status: :created

    else

      render json: @post.errors, status: :unprocessable_entity

    end

  end

  # PATCH/PUT /api/v1/posts/1
 
  def update
 
    if @post.update(post_params)

      render json: @post

    else

      render json: @post.errors, status: :unprocessable_entity

    end

  end

   # DELETE /api/v1/posts/1
 
  def destroy
 
    @post.destroy

  end

  private
 
    def set_post
  
      @post = Post.find(params[:id])
  
    end
  
    def post_params
  
      params.require(:post).permit(:topic_id, :message, :imgUrl)
  
    end
  
    def require_authorization!
  
      unless current_user == @post.user
  
        render json: {}, status: :forbidden
  
      end
  
    end

end
