ExpertSkill.destroy_all

30.times do
  expert = Expert.find(Expert.ids.sample)
  skill = Skill.find(Skill.ids.sample)
  ExpertSkill.create!(
    expert: expert,
    skill: skill,
  )
end
