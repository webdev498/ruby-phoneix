class SupervisingPrescriber < ActiveRecord::Base

    belongs_to :supervisor, foreign_key: "supervisor_id", class_name: "Prescriber"
    belongs_to :supervisee, foreign_key: "supervisee_id", class_name: "Prescriber"

    # prevent duplicate supervisions
    validates :supervisor_id, uniqueness: { scope: :supervisee_id }

#    validates  :supervisor_id, presence:   true
#    validates  :supervisee_id, presence:   true

    # The method below is a temporary kludge
    def self.add_supervision supervisor, supervisee
        sp = SupervisingPrescriber.new
        sp.supervisor_id = supervisor.id
        sp.supervisee_id = supervisee.id
        sp.save
    end

end
