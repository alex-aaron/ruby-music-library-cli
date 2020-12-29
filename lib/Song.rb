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
            value = genre.songs.include?(self)
            if value == false
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
    

end