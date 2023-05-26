---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme = 'chadracula',
  tabufline = {
     overriden_modules = function()
       return {
         buttons = function()
           return ""
         end,
       }
     end,
  },
 }
 M.plugins = "custom.plugins"
 return M
