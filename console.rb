require_relative('./models/artist.rb')
require_relative('./models/album.rb')
require('pry')


# Artist.delete_all()
# Album.delete_all()

artist1 = Artist.new({
  'first_name' => 'Michael',
  'last_name' => 'Jackson'
})
artist1.save()

artist2 = Artist.new({
  'first_name' => 'Britney',
  'last_name' => 'Spears'
})
artist2.save()

artist2.first_name = 'Jermane'
artist2.update()

album1 = Album.new({
  'artist_id' => artist1.id,
  'release_date' => "1986-01-01",
  'album_name' => "Bad",
  'album_genre' => "Pop"
})
album1.save()

album2 = Album.new({
  'artist_id' => artist1.id,
  'release_date' => "2000-01-02",
  'album_name' => "Britney",
  'album_genre' => "Pop"
})
album2.save()
#
# album1.album_name = "Bad: Ultimate Collection"
# album1.update()
# albums = Album.all()

# artist1.albums()

binding.pry
nil
