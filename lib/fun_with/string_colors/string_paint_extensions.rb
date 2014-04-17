module FunWith
  module StringColors
    module StringPaintExtensions
      # When set to false, no color codes are added.  Good for 
      # adding colors only when output goes to interactive shell
      def colorize( setting = nil )
        @colorize_setting = setting unless setting.nil?
        @colorize_setting
      end
      
      def colorize?
        @colorize_setting
      end
      
      def colorize_if_tty_out( out = STDOUT )
        self.colorize( out.tty? )
      end
    end
  end
end
