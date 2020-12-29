require 'pry'
class Artist

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
            @songs << song
        end
    end

    def genres
        genre_return = []
        Song.all.collect do |song|
            if song.artist == self
                genre_return << song.genre
            end
        end
        genre_return.uniq
        #binding.pry
    end
end