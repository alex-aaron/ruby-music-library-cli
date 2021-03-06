class Genre

    extend Concerns::Findable
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        genre = Genre.new(name)
        genre.save
        genre
    end

    def songs
        @songs
    end

    def artists
        artist_return = []
        songs.collect do |song|
            if song.genre == self
                artist_return << song.artist
            end
        end
        artist_return.uniq
        #binding.pry
    end



    
end