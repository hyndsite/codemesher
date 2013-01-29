module ApplicationHelper
  def full_title(page_tile)
    base_title = "CodeMesher:  Mesh your CodeMash Experience"

    if (page_tile.empty?)
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
