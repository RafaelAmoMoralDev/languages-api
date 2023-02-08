class UsersController < ApplicationController

  skip_before_action :authenticate_with_token!, only: [:sign_in, :sign_up]

  # Los errores del método sign_in no son errores de atributos de rails, por eso los tratamos de forma diferente. No obstante, podríamos
  # tratarlos de la misma forma que en el método sign_up por comodidad.

  def sign_in
    if (user = User.find_by_email(params[:email])) && user.authenticate(params[:password])
      render json: user, serializer: User::AuthenticatedUserSerializer, status: :ok
    else
      error = if user == nil
                { code: 1, message: "The user was not found", errors: [] }
              else
                { code: 2, message: "The password is invalid", errors: [] }
              end
      render json: error, status: :unauthorized
    end
  end

  def sign_up
    user = User.create(email: params[:email], name: params[:name])
    user.update(password_digest: params[:password])

    if !user.new_record?
      render json: user, serializer: User::AuthenticatedUserSerializer, status: :ok
    else
      errors = []
      errors << user.errors.messages.map { |message| { type: message[0].to_s, causes: message[1] } }
      render json: { code: 1, message: nil, errors: errors.flatten }, status: :conflict
    end
  end

  def show
    if (user = User.find_by_id(params[:id]))
      render json: user, serializer: User::BasicUserSerializer, current_user: @current_user, status: :ok
    else
      render json: { code: 1, message: nil, errors: nil }, status: :not_found
    end
  end

  def me
    render json: @current_user, serializer: User::UserSerializer, status: :ok
  end

  def like
    if (user = User.find_by_id(params[:id]))
      if user.users_likes.include?(@current_user)
        user.users_likes.delete(@current_user)
      else
        user.users_likes << @current_user
      end
      render status: :no_content
    else
      render json: { code: 1, message: nil, errors: nil }, status: :not_found
    end
  end

end
