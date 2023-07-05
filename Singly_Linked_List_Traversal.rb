class Node
    attr_accessor :dataval, :nextval

    def initialize(data)
        @dataval = data
        @nextval = nil
    end
end

class SLinkedList
    attr_accessor :headval

    def initialize
        @headval = nil
    end

    def listprint
        printval = @headval
        while printval != nil
            puts "Value: #{printval.dataval}"
            printval = printval.nextval
        end
    end
end

list = SLinkedList.new
list.headval = Node.new("Monday")
e2 = Node.new("Tuesday")
e3 = Node.new("Wednesday")

list.headval.nextval = e2
e2.nextval = e3

list.listprint
