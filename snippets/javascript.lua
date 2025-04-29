---@type table<string, any>
local ls = require("luasnip")

---@type fun(trigger: string, nodes: table): table
local s = ls.snippet

---@type fun(text: string | table): table
local t = ls.text_node

---@type fun(position: number, placeholder: string): table
local i = ls.insert_node

return {
  s("clg", {
    t("console.log("),
    i(1, "value"),
    t(");"),
  }),
  s("fn", {
    t("function "),
    i(1, "name"),
    t("("),
    i(2, "params"),
    t(") {"),
    t({ "", "\t" }),
    i(3, "// body"),
    t({ "", "}" }),
  }),
  s("afn", {
    t("const "),
    i(1, "name"),
    t(" = ("),
    i(2, "params"),
    t(") => {"),
    t({ "", "\t" }),
    i(3, "// body"),
    t({ "", "}" }),
  }),
  s("imp", {
    t("import "),
    i(1, "module"),
    t(" from '"),
    i(2, "path"),
    t("';"),
  }),
  s("exp", {
    t("export "),
    i(1, "default "),
    i(2, "value"),
    t(";"),
  }),
}
