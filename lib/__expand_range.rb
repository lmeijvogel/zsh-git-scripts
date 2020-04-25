distinct_args = $stdin.read.strip.split

result = distinct_args.flat_map do |arg|
  matches = arg.match(/(\d+)-(\d+)/)

  if matches
    min, max = matches[1..2]
    (min..max).to_a
  else
    [arg]
  end
end

puts result.join(" ")
