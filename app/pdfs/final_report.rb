class FinalReport < PdfReport
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["Code", "Nama", "Deskripsi"]

  def initialize(project=[], groups)
    super()
    @project = project
    @groups = groups 

    # header 'Functional Specification Document'
    # project_title "Project: #{@project.name}"
    # display_event_table
    # footer
  end
    
  

  def display_event_table
    if table_data.empty?
      text "No Events Found"
    else
      
      t = make_table([ ["this is the first row"],
       ["this is the second row"] ])
      t.draw
      
      
      # table table_data,
      #   headers: TABLE_HEADERS,
      #   column_widths: TABLE_WIDTHS,
      #   row_colors: TABLE_ROW_COLORS,
      #   font_size: TABLE_FONT_SIZE
    end
  end

  def table_data
    @table_data ||= @groups.map { |e| [e.code, e.name, e.description] }
  end

end