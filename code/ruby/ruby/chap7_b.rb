
def funcB(a)
  
  puts a.to_s + "B"

end

module NameSpace_B
  
  class BClz
  
    def funcB(a)
      
      puts a.to_s
      
    end
  
  end
  
  def func
      puts "this func belongs to module B"
      
  end
end