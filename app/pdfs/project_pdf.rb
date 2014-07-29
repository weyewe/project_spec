class FinalReport < PdfReport
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["Code", "Nama", "Deskripsi"]

  def initialize(projects=[], groups)
    super()
    @projects = projects

    header 'Event Summary Report'
    display_event_table
    footer
  end

  private

  def display_event_table
    if table_data.empty?
      text "No Events Found"
    else
      table table_data,
        headers: TABLE_HEADERS,
        column_widths: TABLE_WIDTHS,
        row_colors: TABLE_ROW_COLORS,
        font_size: TABLE_FONT_SIZE
    end
  end

  def table_data
    @table_data ||= @groups.map { |e| [e.code, e.name, e.description] }
  end

end