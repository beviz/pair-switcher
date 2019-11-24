class Assigner
  def self.assign(members)
    members = members.to_a.shuffle
    result_pairs = []

    while member = members.pop
      break if members.empty?

      pair_was = PairHistory.last_pair_of(member)
      selectable = members.reject { |m| m == pair_was }

      if selectable.empty?
        flyback = result_pairs.shuffle.pop
        flyback[1] = pair_was
        selectable << flyback[1]
      end

      next_pair = members.delete selectable.sample
      result_pairs << [member, next_pair]
    end

    result_pairs
  end

  def self.assign_and_save(members)
    pairs = assign(members)
    now = Time.current

    PairHistory.transaction do
      pairs.each do |pair|
        PairHistory.pair! pair[0], pair[1], now
      end
    end
  end
end
