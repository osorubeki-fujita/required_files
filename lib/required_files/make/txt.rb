class RequiredFiles::Make::Txt < RequiredFiles::Make::MetaClass

  def initialize( required_files , top_dir , filename = "required_files" )
    super( "txt" , required_files , top_dir , filename = "required_files" )
  end

  def generate_file
    ::File.open( filename_including_dir , "w:utf-8" ) do |f|
      f.print actually_required_files.join( "\n" )
    end
  end

end
