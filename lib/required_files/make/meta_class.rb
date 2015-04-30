class RequiredFiles::Make::MetaClass

  def initialize( file_type , required_files , top_dir , filename = "required_files" )
    @file_type = file_type
    @required_files = required_files
    @top_dir = top_dir
    @filename = filename
  end

  private

  def filename_including_dir
    "#{ @top_dir }/#{ @filename }.#{ @file_type }"
  end

  def actually_required_files
    @required_files.map { | str | str.gsub( "#{ @top_dir }/" , "" ) + ".rb" }
  end

end