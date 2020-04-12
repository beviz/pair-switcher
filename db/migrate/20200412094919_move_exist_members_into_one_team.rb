class MoveExistMembersIntoOneTeam < ActiveRecord::Migration[6.0]
  class Team < ActiveRecord::Base
    has_secure_token
  end

  class Member < ActiveRecord::Base
  end

  def change
    dissociative_members = Member.where(team_id: nil)
    if dissociative_members.any?
      team = Team.create
      dissociative_members.update_all(team_id: team.id)
    end
  end
end
