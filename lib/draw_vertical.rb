class DrawVertical
  def initialize(bitmap, coordinates_colours)
    @bitmap = bitmap
    @coordinates_colours = coordinates_colours
  end

  def exec
    raise "row and/or columns have not been supplied" if incomplete?
    raise "out of bounds needs to be between 1 to 250" if invalid_coordinates?

    @bitmap.pixels.tap do |pixels|
      row_indices.each { |row_index| pixels[row_index][column_index] = colour }
    end
  end

private

  def colour
    @colour ||= (colours.first || "")
  end

  def colours
    @colours ||= @coordinates_colours.fetch(:colours)
  end

  def coordinates
    @coordinates ||= @coordinates_colours.fetch(:coordinates).map(&:to_i)
  end

  def column_index
    coordinates.first - 1
  end

  def positions
    @positions ||= coordinates.last(2).map{ |coordinate| coordinate - 1 }.sort
  end

  def row_indices
    @row_indices ||= (positions.first..positions.last).to_a
  end

  def incomplete?
    coordinates.size != 3 && colours.size != 1
  end

  def invalid_coordinates?
    coordinates.all?{ |coordinate| coordinate < 1 || coordinate > 250 }
  end
end
