require "required_files/version"

module RequiredFiles

  class MetaClass

    def initialize( set_all_files_under_the_top_namespace: true )
      @array = ::Array.new
      @set_all_files_under_the_top_namespace = set_all_files_under_the_top_namespace
      set_array
    end

    attr_reader :array
    alias :files :array
    alias :required_files :array

    private

    def set_all_files_under_the_top_namespace?
      @set_all_files_under_the_top_namespace
    end

    def set_array
      set_top_file
      set_other_files
      set_all_files_under_the_top_namespace
    end

    def set_top_file
      _ignored_files = ignored_files
      _top_file = top_file
      unless _ignored_files.present? and _ignored_files.include?( _top_file )
        @array << _top_file
      end
    end

    def set_other_files
      _ignored_files = ignored_files
      _other_files = other_files
      if _other_files.present?
        _other_files.each do | file |
          unless _ignored_files.present? and _ignored_files.include?( file )
            set_files( file )
          end
        end
      end
    end
    
    def set_all_files_under_the_top_namespace
      if set_all_files_under_the_top_namespace?
        _ignored_files = ignored_files
        all_files_under_the_top_namespace.each do | file |
          unless _ignored_files.present? and _ignored_files.include?( file )
            @array << file
          end
        end
      end
    end

    def set_files( *files )
      files.flatten.each do | file |
        filename_without_extension = file.gsub( /\.rb\Z/ , "" )
        filename_with_extension = filename_without_extension + ".rb"
        if ::File.exist?( filename_with_extension ) and !( @array.include?( filename_without_extension ) )
          @array << filename_without_extension
        end
      end
    end

    def set_files_starting_with( *dir_root )
      set_files( self.class.files_starting_with( *dir_root ) )
    end

    [ :top_file , :all_files_under_the_top_namespace ].each do | class_method_name |
      eval <<-DEF
        def #{ class_method_name }
          self.class.#{ class_method_name }
        end
      DEF
    end

    def other_files
      other_or_ignored_files( self.class.other_files )
    end

    def ignored_files
      other_or_ignored_files( self.class.ignored_files )
    end

    def other_or_ignored_files( files )
      if files.present?
        [ files ].flatten
      else
        nil
      end
    end

    def self.files
      self.new.files
    end

    def self.top_file
      if settings_for_auto_loading.present?
        used_part_of_namespace = self.name.gsub( /\A#{ settings_for_auto_loading[ :namespace ].name }/ , "" ).split( "::" ).map { | dir | dir.underscore }
        ::File.join( settings_for_auto_loading[ :filename ] , *used_part_of_namespace )
      else
        raise "This method \'#{self.name}.#{ __method__ }\' is not defined yet."
      end
    end

    def self.other_files
      nil
    end
    
    def self.ignored_files
      nil
    end

    def self.all_files_under_the_top_namespace
      ::Dir.glob( "#{ top_file }/**/**.rb" ).sort
    end

    def self.files_not_be_required
      ( all_files_under_the_top_namespace.map { | str | str.gsub( /\.rb\Z/ , "" ) } - required_files.map { | str | str.gsub( /\.rb\Z/ , "" ) } ).sort
    end

    def self.files_starting_with( *dir_root )
      d_root = dir_root.flatten
      [ ::File.join( *dir_root ) ] + ::Dir.glob( "#{ d_root.join( "/" ) }/**/**.rb" ).sort
    end

    class << self

      alias :required_files :files
      
      private
      
      def settings_for_auto_loading
        nil
      end
      
    end

  end

end