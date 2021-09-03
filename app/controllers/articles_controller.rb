class ArticlesController < ApplicationController
	#con esto evitamos el ingreo a cualquier pagina si no esta logido o iniciado sesion
	#before_action :validate_user, except: [:show, :index]
	before_action :authenticate_user!
	before_action :set_article, except: [:index, :new, :create, :from_author]
	#esto sirve para el nivel de permiso 
	#before_action :authenticate_editor!, only: [:new, :create, :update]
	#before_action :authenticate_admin!, only: [:destroy]


	# llama por el metodo get /articles
	def index
		@articles = Article.paginate(page: params[:page], per_page: 9).ultimos

	end
	# llama por el metodo get /articles/:id
	def show
		@article.update_visist_count
		@comment = Comment.new
				
	end

	# llama por el metodo get /articles/new

	def new
		@article = Article.new
		@categories = Category.all 
	end
	
	def create
		#guarda los datos en la base de datos 
		#@article = Article.new(title: params[:article][:title], body: params[:article][:body])
		#esto sustitulle como se guarda los datos en la base de datos inicial y lo realiza el strong_params
		@article = current_user.articles.new(article_params)
		@article.categories = params[:categories]
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def edit
		

	end

	def destroy
		
		@article.destroy 
		redirect_to articles_path

		


	end

	def update
		
		if @article.update (article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	def from_author
		@user = User.find(params[:user_id])	
		#@category = Category.includes(:articles).find(params[:id])
    	@articles = @user.articles.paginate(page: params[:page], per_page: 9).ultimos	
	end

	private

		
		def validate_user
			redirect_to new_user_session_path, notice: "Nesecitas iniciar sesion"

		end

		def article_params
			params.require(:article).permit(:title,:body,:cover,:link_video,:categories)
		
		end

		def set_article
			@article = Article.find (params[:id]) 
		end

end