User.create! name: "Pham Duc",
  email: "admin@gmail.com",
  password: "111111",
  activated: true,
  activated_at: Time.zone.now,
  role: 1

10.times do |n|
  name = FFaker::Name.name
  email = FFaker::Internet.email
  User.create! name: name,
  email: email,
  password: "111111",
  activated: true,
  activated_at: Time.zone.now
end

# #create category
20.times do |n|
  name = FFaker::Music.genre
  info = "info"
  user_id = rand 1..10
  Category.create! name: name,
    info: info,
    user_id: user_id
end
#   User.create!(email: email, name: name, phone: phone, password: password)
# end

# #create category
# 20.times do |n|
#   user_id = n + 1
#   name = FFaker::Music.genre
#   info = FFaker::Music.artist
#   Category.create!(user_id: user_id, name: name, info: info)
# end

# #create songs
# name_songs = [ "dunderpatrullen-singularity",
#           "nobuo-uematsu-the-promise",
#           "lol-bit-rush",
#           "lol-worlds-collide",
#           "hatsune-miku-secret-police",
#           "hatsune-miku-senbonzakura",
#           "hatsune-miku-talent-shredder",
#           "one-punch-man-opening-1",
#         ]
# name_songs.each do |name_song|
#   name = name_song
#   song_url = "https://cdn.zekken.rocks/mp3/#{name_song}.mp3"
#   user_id = 1
#   category_id = 1
#   view = 1856
#   Song.create(name: name, song_url: song_url, user_id: user_id, category_id: category_id, view: view)
# end

# #create album
# 20.times do
#   name = FFaker::Music.album
#   user_id = 1
#   Album.create!(name: name, user_id: user_id)
# end

# 8.times do |n|
#   song_id = n + 1
#   album_id = n + 5
#   AlbumSong.create!(song_id: song_id, album_id: album_id)
# end

10.times do |n|
  name = FFaker::Music.album
  user_id = rand 1..10
  Album.create! name: name,
    user_id: user_id
end
