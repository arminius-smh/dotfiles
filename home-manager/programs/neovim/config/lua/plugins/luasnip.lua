-- snippet engine
local M = {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"honza/vim-snippets",
	},
}

M.config = function()
	local ls = require("luasnip")
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node
	local extras = require("luasnip.extras")
	local rep = extras.rep
	local fmt = require("luasnip.extras.fmt").fmt
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()

	ls.add_snippets("lua", {
		s(
			{
				trig = "plugin",
				name = "Plugin Template",
				desc = "Plugin Template for Lazy",
			},
			fmt(
				[[
                -- {}
                local M = {{
                    "{}",
                }}

                M.config = function()
                    require("{}").setup()
                end

                return M
            ]],
				{
					i(1, "description"),
					i(2, "source"),
					i(0, "name"),
				}
			)
		),
	})

	ls.add_snippets("sh", {
		s(
			{
				trig = "bashmain",
				name = "Main Function",
				desc = "Main Function Template",
			},
			fmt(
				[[
                #!/usr/bin/env bash
                main() {{
                    echo "Hello, World!"
                }}

                main "$@"
            ]],
				{}
			)
		),
	})

	ls.add_snippets("nix", {
		s(
			{
				trig = "module",
				name = "Create module template",
				desc = "Create module template Template",
			},
			fmt(
				[[
                {{
                    config,
                    lib,
                    ...
                }}:
                let
                 cfg = config.cave.{};
                in
                {{
                    options.cave = {{
                        {}.enable = lib.mkEnableOption "enable {} config";
                    }};

                    config = lib.mkIf cfg.enable {{

                    }};
                }}
            ]],
				{
					i(1, "option"),
					rep(1),
					rep(1),
				}
			)
		),
	})

	ls.add_snippets("nix", {
		s(
			{
				trig = "sysmodule",
				name = "Create systemd module template",
				desc = "Create systemd module template Template",
			},
			fmt(
				[[
                    {{
                      config,
                      lib,
                      pkgs,
                      ...
                    }}:
                    let
                      cfg = config.cave.systemd.services.{};
                    in
                    {{
                      options.cave = {{
                        systemd.services.{}.enable = lib.mkEnableOption "enable systemd.services.{} config";
                      }};
                    
                      config = lib.mkIf cfg.enable {{
                        systemd.user = {{
                          services = {{
                            {} = {{
                              Unit = {{
                                Description = "${{pkgs.{}.meta.description}}";
                                Documentation = "${{pkgs.{}.meta.homepage}}";
                                Requires = [
                                  "tray.target"
                                ];
                                After = [
                                  "graphical-session.target"
                                  "tray.target"
                                ];
                                PartOf = [ "graphical-session.target" ];
                              }};
                    
                              Service = {{
                                ExecStart = "${{pkgs.{}}}/bin/{}";
                                Restart = "on-failure";
                                KillMode = "mixed";
                              }};
                    
                              Install = {{
                                WantedBy = [ "graphical-session.target" ];
                              }};
                            }};
                          }};
                        }};
                      }};
                    }}
            ]],
				{
					i(1, "option"),
					rep(1),
					rep(1),
					rep(1),
					rep(1),
					rep(1),
					rep(1),
					rep(1),
				}
			)
		),
	})
end

return M
