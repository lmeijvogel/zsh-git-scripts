#!/usr/bin/env ruby

require 'shellwords'

PARENTHESIZED_STATEMENTS_REGEX = /\([^\)]+\)/

def main(human_readable:)
  puts "unset _git_indices"
  puts "declare -Ag _git_indices"
  puts
  status = `git status`

  last_prefix = ""

  number_of_lines = status.each_line.count

  index = 1

  status.each_line.each_with_index do |line|
    line.rstrip!
    if line.start_with?(/\s+/)
      parenthesized_statements = line[PARENTHESIZED_STATEMENTS_REGEX]

      line_without_parenthesized_statements = line.gsub(PARENTHESIZED_STATEMENTS_REGEX, "")

      space_before_filename = line_without_parenthesized_statements.rindex(/\s[^(]/)

      start_of_line = line_without_parenthesized_statements[0..space_before_filename]
      filename = line_without_parenthesized_statements[space_before_filename+1..-1]

      filename_to_display = "#{filename} #{parenthesized_statements}"
      processed_line = format("%-13s%5s %s", start_of_line, "[#{index}]", filename_to_display)

      puts "_git_indices[#{index}]=#{filename}"
      if human_readable
        puts processed_line
      else
        escaped_line = Shellwords.shellescape(processed_line)
        puts "echo #{escaped_line}"
      end
      index += 1
    else
      if human_readable
        puts line
      else
        escaped_line = Shellwords.shellescape(line)
        puts "echo #{escaped_line}"
      end
    end
  end
end

human_readable = ARGV.include? "-h"

main(human_readable: human_readable)
