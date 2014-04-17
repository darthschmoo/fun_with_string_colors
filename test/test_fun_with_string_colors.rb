require 'helper'

class TestFunWithStringColors < FunWith::StringColors::TestCase
  should "test basics" do
    assert defined?( FunWith::StringColors )
    assert defined?( FunWith::StringColors::StringPaintExtensions )
    
    assert FunWith::StringColors.respond_to?( :activate )
    FunWith::StringColors.activate
    
    assert defined?( String::ANSI_COLORS )
    
    for method in [:paint, :paint?]
      assert "".respond_to?(method), "String.new doesn't respond to #{method.inspect}"
    end
  end
  
  should "print prettily" do
    for color in String::ANSI_COLORS.keys
      puts "[" + "Hello World".paint(color) + "]" + "[" + "Hello World".paint(color, :bold) + "]" + "[" + "Hello World".paint(color, :bold, :reverse ) + "]" + "[" + "Hello World".paint(color, :bold, :reverse, :reset ) + "]"
    end
    
    str = ""
    for color in %w("1 2 3 4 5 6 7 8 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107)
      str <<  "#{color}: #{ 'hello world'.paint(color) } <done>\n"
    end
    
    puts str
  end
  
  should "clear strings properly" do
    s1 = "hello"
    s2 = "hello".paint( :bold, :reverse, :bg_pink, :blue, :underline )
    puts "#{s1}  =>  #{s2}"
    assert_equal s1, s2.paint( :reset )
  end
  
  should "not alter output when .paint() receives nil/unrecognized" do
    assert_equal "hello", "hello".paint(nil)
  end
end
