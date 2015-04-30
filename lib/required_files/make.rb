module RequiredFiles::Make

  # [ :txt , :yaml ].each do | file_type |
  [ :txt ].each do | file_type |
    eval <<-DEF
      def self.#{ file_type }( required_files , top_dir , filename = "required_files" )
        #{ file_type.capitalize }.new( required_files , top_dir , filename ).generate_file
      end
    DEF
  end

end