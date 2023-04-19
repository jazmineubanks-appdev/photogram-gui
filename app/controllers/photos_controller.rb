class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photo_templates/index.html.erb" })
  end

  def show
    # Parameters: {"path_id"=>"777"}
    url_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => url_id })
    @the_photo = matching_photos.at(0)

    render({ :template => "photo_templates/show.html.erb" })
  end

  def baii
    the_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.at(0)

    the_photo.destroy

    render({ :template => "photo_templates/baii.html.erb" })
  end

  def create
    user_id = params.fetch("query_owner_id")
    image = params.fetch("query_image")
    caption = params.fetch("query_caption")
    photo = Photo.new
    photo.owner_id = user_id
    photo.image = image
    photo.caption = caption
    photo.save
    redirect_to("/photos/#{photo.id}")
  end
def update
the_id = params.fetch("modify_id")
matching_photos = Photo.where({ :id => the_id })
the_photo = matching_photos.at(0)

input_image = params.fetch("input_image")
input_caption = params.fetch("input_caption")
    
the_photo.image = input_image
the_photo.caption = input_caption

the_photo.save

  #render({ :template => "photo_templates/update.html.erb" })
  next_url = "/photos/" + the_photo.id.to_s
  redirect_to(next_url)
end
def new_comment

  photo_id = params.fetch("photo_id_query")
  author_id = params.fetch("author_id_query")
  comment_id = params.fetch("body_query")

  a_new_comment = Comment.new
  a_new_comment.photo_id = photo_id
  a_new_comment.author_id = author_id
  a_new_comment.body = comment_id

  a_new_comment.save




#render({ :template => "photo_templates/new_comment.html.erb" })
redirect_to("/photos/#{a_new_comment.photo_id.to_s}")
#redirect_to(next_url)

end
end
