module AlbumsHelper
	def album_thumbnail(album) 
		if album.pictures.count > 0
			image_tag(album.pictures.first.asset.url(:small))
		else
			image_tag("http://lorempixel.com/400/200")
		end
	end
end
