require("pg")
require_relative("../db/sql_runner.rb")


class Artist
  attr_accessor(:first_name, :last_name)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i()
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = '
      INSERT INTO artists (
        first_name,
        last_name
      )
      VALUES ($1, $2)
      RETURNING id;
    '
    values = [@first_name, @last_name]
    @id = SqlRunner.run( sql, values )[0]["id"].to_i()

  end

  def albums()
    # We have @id
    sql = '
      SELECT * FROM albums
      WHERE artist_id = $1;
    '
    results = SqlRunner.run(sql, [@id])

    albums = results.map do | album_hash |
      Album.new(album_hash)
    end
    return albums
    # Return array of ArtistAlbum objects
  end

  def self.delete_all()
    sql = 'DELETE FROM artists;'
    SqlRunner.run(sql)
  end

  def update()
    sql = '
      UPDATE artists
      SET (first_name, last_name)
      = ($1, $2)
      WHERE id = $3;
    '
    SqlRunner.run(sql, [@first_name, @last_name, @id])
  end

  def self.all()
    sql = 'SELECT * FROM artists;'
    artist_hashes = SqlRunner.run(sql)
    artist_objects = artist_hashes.map do |artist_hash|
      artist.new(artist_hash)
    end
    return artist_objects
  end

  def self.find(id)
    sql = '
      SELECT * FROM artists
      WHERE id = $1;
    '
    results = SqlRunner.run(sql, [id])
    artist_hash = results[0]
    artist_object = artist.new(artist_hash)
    return artist_object
  end

  def delete()
    sql = '
      DELETE FROM artists
      WHERE id = $1;
    '
    SqlRunner.run(sql, [@id])
  end

end
