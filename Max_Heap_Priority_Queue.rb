class MaxHeap
  attr_reader :heap

  def initialize
    @heap = []
  end

  def heapify(n, i)
    largest = i
    left_child = 2 * i + 1
    right_child = 2 * i + 2

    largest = left_child if left_child < n && heap[i] < heap[left_child]
    largest = right_child if right_child < n && heap[largest] < heap[right_child]

    if largest != i
      heap[i], heap[largest] = heap[largest], heap[i]
      heapify(n, largest)
    end
  end

  def insert(new_num)
    size = heap.size
    if size == 0
      heap << new_num
    else
      heap << new_num
      (size / 2 - 1).downto(0) do |i|
        heapify(size, i)
      end
    end
  end

  def delete_node(num)
    size = heap.size
    i = heap.index(num)
    return if i.nil?

    heap[i], heap[size - 1] = heap[size - 1], heap[i]
    heap.pop

    (heap.size / 2 - 1).downto(0) do |i|
      heapify(heap.size, i)
    end
  end

  def print_heap
    puts "Max-Heap array: #{heap}"
  end
end

max_heap = MaxHeap.new
max_heap.insert(3)
max_heap.insert(4)
max_heap.insert(9)
max_heap.insert(5)
max_heap.insert(2)

max_heap.print_heap

max_heap.delete_node(4)
max_heap.print_heap
