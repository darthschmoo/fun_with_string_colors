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
        1        => "\e[22m",
        :color   => "\e[0m"
      }

      # Note:  use :reset and :unpaint in isolation (no other args).  It will nullify everything prior.
      def paint( *colors )
        if paint?
          # debugger if colors.first == "95"
          # puts "\e[27m\e[0m\e[22mcalling paint(*#{colors.inspect})"
          
          colors.flatten!
          highlight_regex = colors.first.is_a?(Regexp) ? colors.shift : nil
        
          rval = self.dup
          prependers, terminations, reset = self.fwsc_map_color_args_to_prepend_and_terminate( colors )
          rval = rval.gsub( /\e\[\d+m/, '' ) if reset
          
          if highlight_regex.nil?
            #puts "prependers #{prependers.inspect}"
            #puts "terminations #{terminations.inspect}"
            prependers.uniq.join + rval + terminations.uniq.join
          else
            rval.gsub( /(#{highlight_regex})/, prependers.uniq.join + "\\1" + terminations.uniq.join )
          end
        else
          self.dup   # Since it returns a duplicate of the original when in paint mode, this is more consistent behavior
        end
      end

      def paint?
        self.class.colorize?
      end
      
      protected
      def fwsc_map_color_args_to_prepend_and_terminate( colors )
        prependers = []
        terminations = []
        reset = false
        
        for color in colors
          case color
          when :reset, :unpaint
            prependers = []
            terminations = []
            reset = true
          when Symbol
            if ANSI_COLORS[color]
              prependers << "\e[#{ANSI_COLORS[color]}m"
              terminations << (ANSI_COLOR_TERMINATORS[color] || ANSI_COLOR_TERMINATORS[:color])
            end
          when /^\d+$/, Integer # you can give numbers/number strings directly
            prependers << "\e[#{ANSI_COLORS[color] || color}m"
            terminations << (ANSI_COLOR_TERMINATORS[color.to_i] || ANSI_COLOR_TERMINATORS[:color])
          end
        end
        
        [prependers, terminations, reset]
      end
    end
  end
end
