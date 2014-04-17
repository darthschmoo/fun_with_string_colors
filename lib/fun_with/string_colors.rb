module FunWith
  module StringColors
    def self.activate
      String.send( :include, StringPaintInclusions )
      String.send( :extend, StringPaintExtensions )
    end
  end
end
