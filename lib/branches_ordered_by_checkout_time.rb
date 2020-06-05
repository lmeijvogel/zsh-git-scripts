#!/usr/bin/env ruby

require 'date'

DAYS = %w[sunday monday tuesday wednesday thursday friday saturday]

LINE_REGEX = %r[([0-9a-f]+) HEAD@{([^}]+)}: checkout: moving from [a-zA-Z0-9_\-\/\.]+ to ([a-zA-Z0-9_\-\/\.]+)]

def main
  checkouts = get_checkouts

  not_checked_out_branches = existing_branches - checkouts

  branches = get_checkouts + not_checked_out_branches

  branch_width = branches.map { |checkout| checkout.name.length }.max

  # Reverse first and second entry since we'll never want to switch to the current branch
  branches = branches.values_at(1, 0) + branches[2..-1] if branches.length > 1

  puts branches.map { |checkout| checkout.to_displayable(branch_width) }
end

def get_checkouts
  @checkouts ||= begin
                   all_checkouts ||= begin
                                       `git reflog show --date=iso --grep-reflog="checkout: moving"`
                                         .each_line
                                         .map { |line| Checkout.new(line) }
                                         .uniq(&:name)
                                     end

                   all_checkouts & existing_branches
                 end
end

def existing_branches
  @existing_branches ||= begin
                      `git for-each-ref refs/heads --format "%(refname:short)"`
                        .each_line
                        .map { |line| Branch.new(line) }
                    end
end

class Branch
  attr_reader :name

  def initialize(name)
    @name = name.strip
  end

  def to_displayable(branch_width)
    format("%-#{branch_width}s", @name)
  end

  def eql?(other)
    return false if !(other.is_a? Branch)

    return other.name == self.name
  end
end

class Checkout < Branch
  attr_reader :date

  def initialize(line)
    matches = line.match(LINE_REGEX)

    super(matches[3])
    @date = DateTime.parse(matches[2])
  end

  def to_displayable(branch_width)
    format("%-#{branch_width}s (%s)", @name, format_date(@date))
  end

  private

  def format_date(date)
    now = DateTime.now
    two_hours_ago = now - (2.0 / 24)
    yesterday = now - 1
    last_6_days = now - 6

    if two_hours_ago < date
      minutes_ago(date)
    elsif yesterday < date
      format("yesterday %02d:%02d", date.hour, date.minute)
    elsif last_6_days < date
      format("last %s %02d:%02d", DAYS[date.wday], date.hour, date.minute)
    else
      format("%04d-%02d-%02d", date.year, date.month, date.day)
    end
  end

  def minutes_ago(date)
    minutes_f = (DateTime.now - date) * 60 * 24

    minutes = minutes_f.to_i

    if (minutes == 1)
      "#{minutes} minute ago"
    else
      "#{minutes} minutes ago"
    end
  end
end

main
