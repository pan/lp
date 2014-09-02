module LonelyPlanet
  module Utils
    # strip and squeeze space from a string, then replace space with underscore
    def str_strip(string) 
      string.strip.squeeze.gsub(' ', '_')
    end

    # tidy a +filename+ and add "html" extention name
    def normalize(filename)
      str_strip(filename) + ".html"
    end
  end
end
