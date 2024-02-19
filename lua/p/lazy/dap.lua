return {
	"mfussenegger/nvim-dap",
	
	config = function()
		local dap = require("dap")
		
		-- Nordic nRF9160 adapter with JLinkDSBServerCL
		dap.adapters.jlink = {
			type = "executable",
			command = "JLinkGDBServerCL",
			args = {"-device", "nrf9160", 
				"-if", "swd", 
				"-port", "2331"}
		}

		-- STM32 adapter with OpenOCD
		dap.adapters.stlink = {
			type = "executable",
			command = "openocd",
			args = {"-f", "", -- path to interface config file  
				"-f", ""} -- path to target config file 
		}

		-- DAP C configs 
		dap.configurations.c = {
			{ -- for jlink and nRF9160 
				name = "Launch JLinkGDBServer",
				type = "jlink"}, 
			
			{ -- for stlink and STM32E5
				name = "Launch OpenOCD for STM32E5",
				type = "stlink"},

			{ -- for stlink and STM32U5
				name = "Launch OpenOCD for STM32U5",
				type = "stlink"}
		}

	end 
}	

