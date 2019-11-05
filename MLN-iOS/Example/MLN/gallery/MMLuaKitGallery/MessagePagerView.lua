---
--- Generated by MLN Team (http://www.immomo.com)
--- Created by MLN Team.
--- DateTime: 2019-09-05 12:05
---

local _class = {
    _name = 'MessagePagerView',
    _version = '1.0'
}

---@public
function _class:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

---@public
function _class:rootView()
    if self.containerView then
        return self.containerView
    end
    self:createSubviews()
    return self.containerView
end

---@private
function _class:createSubviews()
    --容器视图
    self.containerView = View():width(MeasurementType.MATCH_PARENT):height(MeasurementType.MATCH_PARENT)
    self.containerView:bgColor(_Color.White)

    --导航栏
    self.navigation = require("MMLuaKitGallery.NavigationBar"):new()
    self.navibar = self.navigation:bar("消息", nil)
    self.containerView:addView(self.navibar)

    --表视图
    self.tableView = require('MMLuaKitGallery.MessageTableView'):new()
    self.containerView:addView(self.tableView:tableView(self.navibar:marginTop() + self.navibar:height()))
end

return _class
