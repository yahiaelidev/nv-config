local M = {}

M.highlights = function(colors)
	return {
		-- Javascript
		["@keyword.operator.javascript"] = { fg = colors.sky },
		["@keyword.coroutine.javascript"] = { fg = colors.sky },
		["@keyword.export.javascript"] = { fg = colors.sky },
		["@lsp.typemod.variable.readonly.javascript"] = { fg = colors.lavender },
		["@keyword.conditional.javascript"] = { fg = colors.pink },
		-- ["@variable.parameter.javascript"] = { fg = colors.red },

		-- C
		["@storageclass.c"] = { fg = colors.maroon },
		["@type.builtin.c"] = { fg = colors.yellow },
		-- ["@type.qualifier.c"] = { fg = colors.mauve, style = { "italic" } },
		["@type.qualifier.c"] = { fg = colors.mauve },

		-- ["@function.c"] = { fg = colors.teal, style = { "italic" }, },
		-- ["@function.call.c"] = { fg = colors.blue, style = { "italic" } },
		-- ["@function.builtin.c"] = { fg = colors.peach, style = { "italic" } },
		["@function.c"] = { fg = colors.teal },
		["@function.call.c"] = { fg = colors.blue },
		["@function.builtin.c"] = { fg = colors.peach },
		["@variable.parameter.c"] = { fg = colors.red },

		["@lsp.typemod.function.defaultLibrary.c"] = { fg = colors.blue },
		-- ["@lsp.type.property.c"] = { fg = colors.teal },

		["@keyword.import.c"] = { fg = colors.mauve },
		["@constant.macro.c"] = { fg = colors.red, },

		["@field.c"] = { fg = colors.teal },
		["@property.c"] = { fg = colors.teal },

		["@label.c"] = { fg = colors.peach },
		["@string.c"] = { fg = colors.green },
		["@character.c"] = { fg = colors.green },
		-- ["@keyword.return.c"] = { fg = colors.mauve, style = { "italic" } },
		-- ["@keyword.conditional.c"] = { fg = colors.mauve, style = { "italic" } },
		-- ["@comment.c"] = { fg = colors.surface2, style = { "italic" } },
		["@keyword.return.c"] = { fg = colors.mauve },
		["@keyword.conditional.c"] = { fg = colors.mauve },
		["@comment.c"] = { fg = colors.surface2 },

		["@lsp.type.macro.c"] = { fg = colors.peach },

	}
end

return M
