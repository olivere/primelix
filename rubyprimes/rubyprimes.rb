#!/usr/bin/env ruby

def sieve(max)
  vec = Array.new(max, false)
  n = Math.sqrt(max)
  (2..n).each do |i|
    (2*i).step(max, i) { |j| vec[j] = true } unless vec[i]
  end

  STDOUT.print "[ok: "
  (2..max).select { |i| STDOUT.print "#{i>2 ? ',' : ''}#{i}" }
  STDOUT.puts "]"
  STDOUT.flush
end

ARGF.each_line do |line|
  n = line.to_i
  if n <= 0
    ARGF.close
    puts "[error: Bad Input]"
    exit(1)
  end
  sieve(n)
end
