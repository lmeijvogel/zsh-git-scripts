#!/usr/bin/env ruby

def main
  lines = ARGF.read.lines

  conflicts, non_conflicts = lines.partition {|line| is?("UU", line) }
  additions, rest = non_conflicts.partition {|line| is?("??", line) }

  puts conflicts + additions + rest
end

def is?(status, line)
  line.split(/\s+/)[0] == status
end

main
