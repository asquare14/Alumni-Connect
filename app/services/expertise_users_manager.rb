class ExpertiseUsersManager
  attr_reader :expertise_ids, :user
  def initialize(expertise_ids, user)
    @expertise_ids = expertise_ids
    @user = user
  end

  def clean_expertises
    expertise_ids.reject { |id| id == "" }
  end

  def checked_expertises
    clean_expertises.map { |id| Expertise.find(id) }
  end

  def unchecked_expertises
    Expertise.all.reject { |expertise| checked_expertises.include?(expertise) }
  end

  def create_expertise_users_from_checked_expertises
    checked_expertises.each do |expertise|
      ExpertiseUser.find_or_create_by(expertise: expertise, user: user)
    end
  end

  def destroy_expertise_users_from_unchecked_expertises
    unchecked_expertises.each do |expertise|
      expertise_user = ExpertiseUser.find_by(expertise: expertise, user: user)
      expertise_user.destroy if expertise_user
    end
  end

  def run
    create_expertise_users_from_checked_expertises
    destroy_expertise_users_from_unchecked_expertises
  end
end
