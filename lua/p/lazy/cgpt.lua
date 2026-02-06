return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
	    openai_api_key = { "cat", "/home/praneethch//open_api.key" },
        }
        require("gp").setup(conf)
    end,
}
