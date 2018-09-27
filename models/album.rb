require_relative('../db/sql_runner.rb')

class Album

  attr_accessor(:release_date, :album_name, :album_genre, :artist_id)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i()
    @artist_id = options['artist_id'].to_i()
    @release_date = options['release_date']
    @album_name = options['release_date']
    @album_genre = options['album_genre']
  end

  def save()
    sql = "
      INSERT INTO albums (
        artist_id,
        release_date,
        album_name,
        album_genre
      )
      VALUES ($1, $2, $3, $4)
      RETURNING id;
    "
    values = [
      @artist_id,
      @release_date,
      @album_name,
      @album_genre
    ]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i()
  end

  def artist()
    # We have @artist_id
    sql = '
      SELECT * FROM artists
      WHERE id = $1;
    '
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)
    result = Artist.new(artist.first)
    return result
  end

  def update()
    sql = "
      UPDATE albums
      SET (
        artist_id,
        release_date,
        album_name,
        album_genre
      ) = ( $1, $2, $3, $4)
      WHERE id = $5;
    "
    values = [
      @artist_id,
      @artist_id,
      @release_date,
      @album_name,
      @album_genre,
      @id
    ]
    SqlRunner.run(sql, values)
  end

  def delete() # EXTENSION
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM albums;'
    order_hashes = SqlRunner.run(sql)

    album_objects = album_hashes.map do |album_hash|
      Album.new(album_hash)
    end

    return album_objects
  end

  def self.delete_all()
    sql = 'DELETE FROM albums;'
    SqlRunner.run(sql)
  end

end
