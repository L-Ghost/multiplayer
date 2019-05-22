class GameDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all

  def add_to_profile
    link_to(
      I18n.t('add.to_my_profile'),
      add_game_path(object),
      method: :patch,
      class: 'btn btn-primary'
    )
  end
end
