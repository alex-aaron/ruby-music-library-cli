require 'pry'
class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        @files = Dir.glob("#{path}/*mp3").collect {|song_files| song_files.gsub("#{path}/", "") }
    end

    def import 
        self.files.each do |song_info|
            Song.create_from_filename(song_info)
        end
    end
end