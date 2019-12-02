module Response
	def json_response(object, status = :ok)
		render json: object, status: status
	end

  # def json_response(object, message = nil, status = :ok, page = nil)
  #   render json: { data: set_object(object), page: page, meta: response_meta(message, status) }, status: :ok
  # end

  def json_response_with_serializer(object, status = :ok, **options)
    # options[:url] = root_url
    serialized_object = ActiveModelSerializers::SerializableResource.new(set_object(object), options)
    serialized_object.serialization_scope = current_user
    # serialized_object.serialization_scope_name = "current_user"
    serialized_object = serialized_object.as_json

    # serialized_object2 = ActiveModelSerializers::SerializableResource.new(set_object_page(page), options)
    # serialized_object2.serialization_scope = current_user
    # # serialized_object.serialization_scope_name = "current_user"
    # serialized_object2 = serialized_object2.as_json

    json_response(serialized_object, status)
  end

  def set_object(object)
    object = object || {}

    return object
  end
end