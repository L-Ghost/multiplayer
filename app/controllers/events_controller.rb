class EventsController < ApplicationController
  def new
    @event = Event.new
    @game_platforms = current_user.game_platforms
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.save
    EventParticipation.create(event: @event, user: current_user)
    flash[:notice] = 'Seu evento foi criado'
    redirect_to @event
  end

  def show
    @event = Event.find(params[:id]).decorate
    @received_requests = EventRequest.where(
      event_owner: current_user,
      request_status: :sent
    ).decorate
  end

  def invite
    @event = Event.find(params[:id])
    @invited_user = User.find_by('nickname = :q OR email = :q', q: params[:q])

    @message = 'Não foi encontrado um usuário com este email'
    invite_user_procedure unless @invited_user.nil?

    flash[:notice] = @message
    redirect_to @event
  end

  def event_request
    @event = Event.find(params[:id])
    @request = create_event_request
    @request.sent!
    flash[:notice] = 'Pedido de participação enviado com sucesso!'
    redirect_to event_path(@event)
  end

  def search
    search_param = params[:search]
    return if search_param.blank?

    @events = Event.where('lower(title) like lower(?)', "%#{search_param[:q]}%")
  end

  def create_event_request
    EventRequest.create(
      event: @event, user: current_user, event_owner: @event.user
    )
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :game_platform_id,
      :event_date, :user_limit, :event_type, :event_location
    )
  end

  def invite_user_procedure
    if invite_exists?
      @message = 'Este usuário já foi convidado anteriormente'
    else
      create_event_invite
      @message = invited_user_message
    end
  end

  def invited_user_message
    "Convite enviado para o usuário #{@invited_user.nickname}"
  end

  def invite_exists?
    @event_invite = EventInvite.find_by(
      event: @event, user: current_user, invitee: @invited_user
    )
    !@event_invite.nil?
  end

  def create_event_invite
    EventInvite.create(
      event: @event,
      user: current_user,
      invitee: @invited_user
    )
  end
end
