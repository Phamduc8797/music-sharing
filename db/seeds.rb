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
