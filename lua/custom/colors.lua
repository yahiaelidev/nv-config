local M = {}

M.highlights = function(colors)
	return {
		["@storageclass.c"] = { fg = colors.maroon },
		["@type.builtin.c"] = { fg = colors.yellow },
		["@type.qualifier.c"] = { fg = colors.mauve, style = { "italic" } },

		["@function.c"] = { fg = colors.teal, style = { "italic" }, },
		["@function.call.c"] = { fg = colors.blue, style = { "italic" } },
		["@function.builtin.c"] = { fg = colors.peach, style = { "italic" } },
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
		["@keyword.return.c"] = { fg = colors.mauve, style = { "italic" } },
		["@lsp.type.macro.c"] = { fg = colors.peach },
		["@keyword.conditional.c"] = { fg = colors.mauve, style = { "italic" } },

		["@comment.c"] = { fg = colors.surface2, style = { "italic" } },
	}
end

return M
