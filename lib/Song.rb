require 'pry'
class Song

    attr_accessor :name, :genre, :artist

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist)
        self.genre=(genre)
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        if artist != nil 
            @artist = artist
            artist.add_song(self)
        else
            @artist = nil
        end
    end
    
    def genre=(genre)
        if genre != nil
            @genre = genre
            if !genre.songs.include?(self)
              genre.songs << self
            end
        else
            @genre = nil
        end
    end

    def self.find_by_name(song_instance)
        Song.all.find do |song|
            song.name == song_instance
        end
    end

    def self.find_or_create_by_name(song_instance)
        if self.find_by_name(song_instance)
            self.find_by_name(song_instance)
        else
            Song.create(song_instance)
        end

    end

    def self.new_from_filename(file)
        file_array = file.split(" - ")
        artist = file_array[0]
        title = file_array[1]
        genre = file_array[2].gsub(".mp3", "")
        new_song = self.new(title)
        new_song.genre =  Genre.find_or_create_by_name(genre)
        new_song.artist = Artist.find_or_create_by_name(artist)
        return new_song
    end
    
    def self.create_from_filename(file)
        new_song = new_from_filename(file)
        new_song.save
    end

end