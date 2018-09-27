DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;

CREATE TABLE artists (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE albums (
  id SERIAL8 PRIMARY KEY,
  artist_id INT8 REFERENCES artists(id),
  release_date DATE,
  album_name VARCHAR(255),
  album_genre VARCHAR(255)
);
