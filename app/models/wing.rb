class Wing < ActiveRecord::Base

  belongs_to :facility
  has_many :beds
  
  enum print_monograph: [:no_monograph, :mono_on_new, :mono_on_all]
  enum require_hippa_privacy_notice: [:no_hippa, :required, :issue_warning]
  enum print_order: [:alphabetic, :pass_order]
  enum print_medication_guide: [:no_medication_guide, :guide_on_new, :guide_on_all]
  enum type_of_facility: [:undefined, :skilled, :intermediate, :nursing, :assisted_living, :group_home, :mental_health, :correctional]

end
