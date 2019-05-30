if !Admin.find_by(email: 'admin@admin.com')
  Admin.create(email: 'admin@admin.com', password: '12345678')
end

puts 'Creating Users...'

user1 = User.find_by(email: 'user@user.com')
if user1.nil?
  user1 = User.create(name: 'user', email: 'user@user.com', password: '123456', nickname: 'fire-user')
  user1.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'fire.png')), filename: 'fire.png')
  user1.save
end
user2 = User.find_by(email: 'user2@user.com')
if user2.nil?
  user2 = User.create(name: 'user 2', email: 'user2@user.com', password: '123456', nickname: 'air-user')
  user2.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'air.png')), filename: 'air.png')
  user2.save
end
user3 = User.find_by(email: 'user3@user.com')
if user3.nil?
  user3 = User.create(name: 'user 3', email: 'user3@user.com', password: '123456', nickname: 'water-user')
  user3.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'water.png')), filename: 'water.png')
  user3.save
end
user4 = User.find_by(email: 'user4@user.com')
if user4.nil?
  user4 = User.create(name: 'user 4', email: 'user4@user.com', password: '123456', nickname: 'earth-user')
  user4.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'earth.png')), filename: 'earth.png')
  user4.save
end

if (!City.find_by(name: 'São Paulo'))
  state = State.find_by(name: 'SP')
  if state.nil?
    state = State.create(name: 'SP')
  end
  City.create(name: 'São Paulo', state: state)
end

# empresas
puts 'Creating Companies...'

nintendo = Company.find_by(name: 'Nintendo')
if nintendo.nil?
  nintendo = Company.new(name: 'Nintendo')
  nintendo.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'nintendo.png')), filename: 'nintendo.png')
  nintendo.save
end

if !Company.find_by(name: 'Sega')
  c = Company.new(name: 'Sega')
  c.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'sega.png')), filename: 'sega.png')
  c.save
end

if !Company.find_by(name: 'Sony')
  c = Company.new(name: 'Sony')
  c.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'sony.png')), filename: 'sony.png')
  c.save
end

if !Company.find_by(name: 'Microsoft')
  c = Company.new(name: 'Microsoft')
  c.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'microsoft.png')), filename: 'microsoft.png')
  c.save
end

# plataformas
puts 'Creating Platforms...'

snes = Platform.find_by(name: 'Super Nintendo')
if snes.nil?
  snes = Platform.new(name: 'Super Nintendo', company: nintendo)
  snes.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'snes.png')), filename: 'snes.png')
  snes.save
end

megadrive = Platform.find_by(name: 'Mega Drive')
if megadrive.nil?
  megadrive = Platform.new(name: 'Mega Drive', company: Company.find_by(name: 'Sega'))
  megadrive.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'megadrive.png')), filename: 'megadrive.png')
  megadrive.save
end

if !Platform.find_by(name: 'Nintendo Switch')
  p = Platform.new(name: 'Nintendo Switch', company: nintendo)
  p.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'switch.png')), filename: 'switch.png')
  p.save
end

playstation4 = Platform.find_by(name: 'Playstation 4')
if playstation4.nil?
  playstation4 = Platform.new(name: 'Playstation 4', company: Company.find_by(name: 'Sony'))
  playstation4.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'ps4.png')), filename: 'ps4.png')
  playstation4.save
end

if !Platform.find_by(name: 'X Box One')
  p = Platform.new(name: 'X Box One', company: Company.find_by(name: 'Microsoft'))
  p.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'xone.png')), filename: 'xone.png')
  p.save
end

# categorias
puts 'Creating Categories...'

categories = ['RPG', 'FPS', 'Plataforma', 'Esporte', 'Aventura', 'Ação', 'Beat \'em Up', 'Dungeon Crawl']
categories.each do |name|
  if !Category.find_by(name: name)
    Category.create(name: name)
  end
end

# games
puts 'Creating Games...'

if !Game.find_by(name: 'Super Mario Kart')
  game = Game.new(name: 'Super Mario Kart', release_year: 1992)
  game.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'mariokart.jpg')), filename: 'mariokart.jpg')
  game.save
  GameRelease.create(game: game, platform: snes)
  GameCategorization.create(category: Category.find_by(name: 'Esporte'), game: game)
end

bomberman = Game.find_by(name: 'Super Bomberman')
if bomberman.nil?
  bomberman = Game.new(name: 'Super Bomberman', release_year: 1993)
  bomberman.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'bomberman.jpg')), filename: 'bomberman.jpg')
  bomberman.save
  GameRelease.create(game: bomberman, platform: snes)
  GameCategorization.create(category: Category.find_by(name: 'Ação'), game: bomberman)
  GameCategorization.create(category: Category.find_by(name: 'Aventura'), game: bomberman)
end

megaman = Game.find_by(name: 'Mega Man X')
if megaman.nil?
  megaman = Game.new(name: 'Mega Man X', release_year: 1994)
  megaman.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'megamanx.jpg')), filename: 'megamanx.jpg')
  megaman.save
  GameRelease.create(game: megaman, platform: snes)
  GameCategorization.create(category: Category.find_by(name: 'Ação'), game: megaman)
  GameCategorization.create(category: Category.find_by(name: 'Plataforma'), game: megaman)
end

if !Game.find_by(name: 'Streets of Rage')
  game = Game.new(name: 'Streets of Rage', release_year: 1991)
  game.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'streetsofrage.jpg')), filename: 'streetsofrage.jpg')
  game.save
  GameRelease.create(game: game, platform: megadrive)
  GameCategorization.create(category: Category.find_by(name: 'Beat \'em Up'), game: game)
end

sonic = Game.find_by(name: 'Sonic the Hedgehog')
if sonic.nil?
  sonic = Game.new(name: 'Sonic the Hedgehog', release_year: 1991)
  sonic.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'sonic.jpg')), filename: 'sonic.jpg')
  sonic.save
  GameRelease.create(game: sonic, platform: megadrive)
  GameCategorization.create(category: Category.find_by(name: 'Plataforma'), game: sonic)
end

dark_souls = Game.find_by(name: 'Dark Souls')
if dark_souls.nil?
  dark_souls = Game.new(name: 'Dark Souls', release_year: 2011)
  dark_souls.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'darksouls.jpg')), filename: 'darksouls.jpg')
  dark_souls.save
  GameRelease.create(game: dark_souls, platform: playstation4)
  GameRelease.create(game: dark_souls, platform: Platform.find_by(name: 'X Box One'))
  GameRelease.create(game: dark_souls, platform: Platform.find_by(name: 'Nintendo Switch'))
  GameCategorization.create(category: Category.find_by(name: 'Ação'), game: dark_souls)
  GameCategorization.create(category: Category.find_by(name: 'RPG'), game: dark_souls)
  GameCategorization.create(category: Category.find_by(name: 'Dungeon Crawl'), game: dark_souls)
end

# events
puts 'Creating Events...'

today = Time.zone.today
if !Event.find_by(title: 'Noite difícil com Dark Souls')
  event1 = Event.create(
    user: user1,
    title: 'Noite difícil com Dark Souls',
    game_release: GameRelease.find_by(game: dark_souls, platform: playstation4),
    description: 'Se divertir vendo as outras pessoas sofrendo para completar o game',
    event_date: today + 2.days,
    user_limit: 4,
    event_type: :presential,
    event_location: 'Alameda Santos, 1293'
  )
  EventParticipation.create(event: event1, user: user1)
end

if !Event.find_by(title: 'Batalha explosiva de Bomberman')
  event2 = Event.create(
    user: user2,
    title: 'Batalha explosiva de Bomberman',
    game_release: GameRelease.find_by(game: bomberman, platform: snes),
    description: 'Cada perdedor das batalhas vira uma dose de Seleta',
    event_date: today + 3.days,
    user_limit: 5,
    event_type: :presential,
    event_location: 'Rua Voluntários da Pátria, 1000'
  )
  EventParticipation.create(event: event2, user: user2)
end

if !Event.find_by(title: 'Speedrun Mega Man X')
  event3 = Event.create(
    user: user3,
    title: 'Speedrun Mega Man X',
    game_release: GameRelease.find_by(game: megaman, platform: snes),
    description: 'Observar um jogador muito habilidoso completar este game em tempo recorde',
    event_date: today + 5.days,
    user_limit: 4,
    event_type: :presential,
    event_location: 'Rua Barra Funda, 500'
  )
  EventParticipation.create(event: event3, user: user3)
  EventInvite.create(event: event3, user: user3, invitee: user1, invite_status: :sent)
  EventInvite.create(event: event3, user: user3, invitee: user2, invite_status: :sent)
end

if !Event.find_by(title: 'Jogar Sonic')
  event4 = Event.create(
    user: user4,
    title: 'Jogar Sonic',
    game_release: GameRelease.find_by(game: sonic, platform: megadrive),
    description: 'Jogar Sonic e coletar 10 mil argolas, revezando entre os jogadores',
    event_date: today + 1.days,
    user_limit: 4,
    event_type: :presential,
    event_location: 'Rua Domingos de Morais, 2200'
  )
  EventParticipation.create(event: event4, user: user4)
  EventInvite.create(event: event4, user: user4, invitee: user1, invite_status: :sent)
  EventInvite.create(event: event4, user: user4, invitee: user2, invite_status: :sent)
  EventInvite.create(event: event4, user: user4, invitee: user3, invite_status: :sent)
end

puts 'Done!'
