def search_in_rotated_array(nums, target)
    n = nums.length

    # Logic
    start = 0
    end_ = n - 1

    while start <= end_
        mid = (start + end_) / 2

        if nums[mid] == target
            return mid
        end

        # Two cases
        if nums[start] <= nums[mid]
            # Left
            if target >= nums[start] && target <= nums[mid]
                end_ = mid - 1
            else
                start = mid + 1
            end
        else
            # Right
            if target >= nums[mid] && target <= nums[end_]
                start = mid + 1
            else
                end_ = mid - 1
            end
        end
    end

    -1
end

nums = [4, 5, 6, 7, 0, 1, 2, 3]
target = 0

result = search_in_rotated_array(nums, target)
puts result
