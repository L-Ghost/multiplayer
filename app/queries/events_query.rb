class EventsQuery
  def latest(n)
    Event.where('event_date >= ?', Time.zone.today).last(n)
  end

  def find_events(params)
    Event.where('lower(title) like lower(?)', "%#{params[:q]}%")
  end
end