require( 'pg' )
require_relative('../db/sql_runner')

class Album

  attr_accessor(:genre, :name)
  attr_reader(:id, :artists_id)

  def initialize( album_details )
    @artists_id = album_details['artists_id']
    @name = album_details['name']
    @genre = album_details['genre']
    @id = album_details['id'].to_i() if album_details['id']
  end

  def artist
    sql = 'SELECT * FROM artists
      WHERE id = $1;'
    artists_array = SqlRunner.run(sql, [@artists_id])

    artists_hash = artists_array[0]

    artist_object = Artist.new(artists_hash)

    return artist_object
  end

  def Album.all()
    db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
    sql = 'SELECT * FROM albums;'
    db.prepare('all', sql)
    orders = db.exec_prepared('all', [])
    db.close()
    return albums.map { |albums_hash| Album.new( albums_hash ) }
  end

  def save()
    db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
    sql = '
      INSERT INTO albums (
        artists_id,
        name,
        genre
      ) VALUES (
        $1, $2, $3
      )
      RETURNING id;'
      values = [@artists_id, @name, @genre]
      db.prepare('save', sql)
      saved_order_hash = db.exec_prepared('save', values)[0]
      @id = saved_order_hash['id'].to_i()
      db.close()
    end

    def Album.delete_all()
      db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
      sql = 'DELETE FROM albums;'
      db.prepare('delete_all', sql)
      db.exec_prepared('delete_all', [])
      db.close()
    end

    def save()
      db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
      sql = '
        INSERT INTO albums (
          artists_id,
          name,
          genre
        ) VALUES (
          $1, $2, $3
        )
        RETURNING id;'
      values = [@artists_id, @name, @genre]
      db.prepare('save', sql)
      saved_order_hash = db.exec_prepared('save', values)[0]
      @id = saved_order_hash['id'].to_i()
      db.close()
    end

    def delete()
      db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
      sql = 'DELETE FROM albums
      WHERE id = $1;'
      values = [@id]
      db.prepare('delete', sql)
      db.exec_prepared('delete', values)
      db.close()
    end

end
