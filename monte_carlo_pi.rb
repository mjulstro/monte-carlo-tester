gem "parallel"
require "parallel"

def run(problem_size, num_threads)
	start_time = Time.now.nsec

	#each of these is an array to avoid the threads overwriting each other's output
	total = Array.new(num_threads, 0)
	num_in_circle = Array.new(num_threads, 0)

	# puts total
	# puts num_in_circle

	Parallel.each(0..problem_size, in_threads: num_threads) {
		id = Parallel.worker_number
		# puts total[id]
		total[id] += 1
		# puts total[id]
		# puts""
		if point_in_circle? then
			num_in_circle[id] += 1
		end
	}

	# puts total
	# puts num_in_circle

	#did the reduction by hand because I couldn't find a spot in the Parallel gem for it
	real_total = 0
	real_nic = 0
	for i in 0..num_threads
		real_total += total[i]
		real_nic += num_in_circle[i]
	end

	end_time = Time.now.nsec
	secs = (end_time - start_time) / 1000000000

	#area of a circle is pi*r^2; area of the square is 4, obv. r=1. (nic/total)*4 = pi*r^2 = pi
	puts "Pi: #{(nic/total)*4} \t This took #{secs} seconds."
end


def point_in_circle?
	x = rand(100000) / 100000
	y = rand(100000) / 100000

	if ((Math.sqrt(x^2 + y^2)) < 1)
		return true
	else
		return false
	end

end


problem_size = ARGV[0].to_i
num_threads = ARGV[1].to_i
run(problem_size, num_threads)
