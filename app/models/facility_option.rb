class FacilityOption < ActiveRecord::Base

    enum print_monograph: [ :no_monograph, :mono_on_new, :mono_on_all ]
    enum require_hippa_privacy_notice: [ :no_hippa, :required, :issue_warning ]
    enum print_medication_guide: [ :no_medication_guide, :guide_on_new, :guide_on_all ]
    enum print_order: [ :alphabetic, :pass_order ]
    enum type_of_facility: [ :undefines, :skilled, :intermediate, :nursing, :assisted_living, :group_home, :mental_health, :correctional_institution ]
    
end
