

def funcA(a)
  
  puts a.to_s + "A"

end

module NameSpace_A
    
  class AClz
  
    def funcA(a)
      
      puts a.to_s
      
    end
  
  end
  
  def func
      puts "this func belongs to module A"
      
  end

end