class Article < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :has_categories, dependent: :destroy
	has_many :categories, through: :has_categories

	
	#validaciones para el titulo del articulo y cuerpo del articulo
	validates :title, presence: true, length: { minimum: 2}, uniqueness: true
	validates :body, presence: true, length: { minimum: 10}
	#cada vez que se crea un articulo coloca el contador de visitas en 0
	before_create :set_visist_count
	after_create :save_categories
	#aqui le decimos el archivo que va a guardar y configuramos el temaño de la imagen
	has_attached_file :cover, styles: {medium:"1280x720", thumb:"400x400"}
	#validamos el tipo de archivo que queremos subir ya sea imagen, pdf, etc...
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	scope :ultimos, ->{ order("created_at DESC") }
	#scope :ultimos, ->{ order("created_at DESC").limit(9) }

	#setter personalizado
	def categories=(value)
		@categories = value
	end

	def update_visist_count
	 
		self.update(visist_count: self.visist_count + 1)
	end

	private

	def save_categories
		@categories.each do |category_id|
		HasCategory.create(category_id: category_id, article_id: self.id)
		end	
	end

	def set_visist_count
		self.visist_count ||= 0
	end
end
