module FunWith
  module StringColors
    module StringPaintInclusions
      ############################## COLORS!!! ###############################
      ANSI_COLORS = {
        :bold       => "1",
        :dim        => "2",
        :underline  => "4",
        :blink      => "5",
        :reverse    => "7",
        :invisible  => "8",
        :clear      => "8",
        :black      => "30",
        :red        => "31",
        :green      => "32",
        :brown      => "33",
        :yellow     => "33",   # synonym :brown
        :blue       => "34",
        :magenta    => "35",
        :pink       => "35",   # synonym :magenta
        :cyan       => "36",
        :gray       => "39",
        :bg_black   => "40",
        :bg_red     => "41",
        :bg_green   => "42",
        :bg_brown   => "43",
        :bg_yellow  => "43",   # synonym :bg_brown
        :bg_blue    => "44",
        :bg_magenta => "45",
        :bg_pink    => "45",   # synonym :bg_magenta
        :bg_cyan    => "46",
        :bg_gray    => "47"
      }
      
      ANSI_COLOR_TERMINATORS = {
        :reverse => "\e[27m",
        7        => "\e[27m",
        :bold    => "\e[22m",
        1        => "\e[22m"
      }

      def paint( *colors )
        if paint?
          rval = self.dup
          terminations = []
          
          for color in colors
            case color
            when :reset, :unpaint
              regex = /\e\[\d+m/
              rval = rval.gsub( regex, '' )
              terminations = []
            when Symbol
              if ANSI_COLORS[color]
                rval = "\e[#{ANSI_COLORS[color]}m#{rval}"
                terminations << (ANSI_COLOR_TERMINATORS[color] || "\e[0m")
              end
            when /^\d+$/, Integer # you can give numbers/number strings directly
              rval = "\e[#{ANSI_COLORS[color] || color}m#{rval}"
              terminations << (ANSI_COLOR_TERMINATORS[color.to_i] || "\e[0m")
            end
          end

          rval + terminations.uniq.join
        else
          self
        end
      end

      def paint?
        self.class.colorize?
      end
    end
  end
end
