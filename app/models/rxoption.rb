class Rxoption < ActiveRecord::Base

	 enum cost_report_option: [ :acquisition, :user, :custom, :awp ]
	 enum switch_type: [ :no_switch, :relay_health, :emdeon ]
	 enum erx_interface: [ :no_erx, :sure_scripts, :emdeon_erx ]
	 enum default_paytype_option: [ :primary, :last_used ]
	 enum system_type: [ :mac, :windows, :linux ]
	 enum system_network_type: [ :local, :wide_area, :cloud, :hosted ]

end
