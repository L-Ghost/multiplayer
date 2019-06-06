class UsersQuery
  def find_user(params)
    if params[:user_id].nil?
      return User.find_by!('nickname = :q OR email = :q', q: params[:q])
    end

    User.find(params[:user_id])
  end

  def find_users(params)
    User.where('email like :q OR nickname like :q', q: "%#{params[:q]}%")
  end
end
