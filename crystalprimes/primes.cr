def sieve(max_i64)
  vec = Array.new(max_i64+1, false)
  n_i64 = Math.sqrt(max_i64)
  (2..n_i64).each do |i_i64|
    (2*i_i64).step(to: max_i64, by: i_i64) { |j_i64| vec[j_i64] = true } unless vec[i_i64]
  end

  STDOUT.print "[ok: "
  (2..max_i64).each.with_index do |i,index|
    STDOUT.print ',' if index > 2
    STDOUT.print i
  end
  STDOUT.puts "]"
  STDOUT.flush
end

ARGF.each_line do |line|
  n_i64 = line.to_i
  if n_i64 <= 0
    ARGF.close
    puts "[error: Bad Input]"
    exit(1)
  end
  sieve(n_i64)
end
