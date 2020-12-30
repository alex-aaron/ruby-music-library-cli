require 'pry'
class MusicLibraryController
    
    def initialize(path = "./db/mp3s")
        @path = path
        new_music = MusicImporter.new(@path)
        new_music.import
    end

    def call
        user_input = ""
        while user_input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            user_input = gets.chomp
            case user_input
                when "list songs"
                    list_songs
                when "list artists"
                    list_artists
                when "list genres"
                    list_genres
                when "list artist"
                    list_songs_by_artist
                when "list genre"
                    list_songs_by_genre
                when "play song"
                     play_song
            end
        end
    end


    def list_songs
        alphabetical_array = Song.all.sort_by! {|song| song.name}
        num = 1
        alphabetical_array.each do |song|
            puts "#{num}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            num += 1
        end
    end

    def list_artists
        alphabetized_artists = Artist.all.sort_by! {|artist| artist.name}
        num = 1
        alphabetized_artists.each do |artist|
            puts "#{num}. #{artist.name}"
            num += 1
        end
    end

    def list_genres
        alphabetized_genres = Genre.all.sort_by! {|genre| genre.name}
        num = 1
        alphabetized_genres.each do |genre|
            puts "#{num}. #{genre.name}"
            num += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp
        num = 1
        alphabetized_songs = Song.all.sort_by! {|song| song.name}
        alphabetized_songs.each do |song| 
            if song.artist.name == user_input
                #binding.pry
                puts "#{num}. #{song.name} - #{song.genre.name}"
                num += 1
            end
        end

    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp
        num = 1
        alphabetized_songs = Song.all.sort_by! {|song| song.name}
        alphabetized_songs.each do |song|
            if song.genre.name == user_input
                puts "#{num}. #{song.artist.name} - #{song.name}"
                num += 1
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.chomp.to_i

        alphabetical_array = Song.all.sort_by! {|song| song.name}
        alphabetical_array.each_with_index do |song, index|
            if index != 0 && index == user_input - 1
                puts "Playing #{song.name} by #{song.artist.name}"
            end 
        end
    end

            
end


