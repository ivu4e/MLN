---
--- Generated by MLN Team (http://www.immomo.com)
--- Created by MLN Team.
--- DateTime: 2019-09-05 12:05
---

local _class = {
    _name = 'MessageTableView',
    _version = '1.0'
}

---@public
function _class:new()
    local o = {}
    setmetatable(o, {__index = self})
    self.CELL_TYPE1 = "cellType1"
    self.CELL_TYPE2 = "cellType2"
    return o
end

---@public
function _class:tableView()
    self:setupDataSource()
    self:setupTableView()
    self:setupRefreshLoadData()
    return self.tableView
end

---@private
function _class:setupTableView()
    self.tableView = TableView(true, true)
    self.tableView:width(window:width()):height(MeasurementType.MATCH_PARENT)
    self.tableView:showScrollIndicator(true)

    self.cellHeight = 70
    self.adapter = TableViewAdapter()

    self.adapter:sectionCount(function()
        return 1
    end)

    self.adapter:rowCount(function(_)
        return self.dataList:size()
    end)

    self.adapter:reuseId(function(_, row)
        if row < 3 then
            return self.CELL_TYPE1
        end
        return self.CELL_TYPE2
    end)

    -- 初始化第一种类型cell
    self.adapter:initCellByReuseId(self.CELL_TYPE1, function(cell)
        cell.layout = LinearLayout(LinearType.HORIZONTAL):height(self.cellHeight)
        cell.contentView:addView(cell.layout)

        --图标
        cell.imageView  = ImageView():width(25):height(25):marginLeft( 30):setGravity(Gravity.CENTER)
        cell.imageView:contentMode(ContentMode.SCALE_ASPECT_FIT):cornerRadius(cell.imageView:height() / 2)
        cell.layout:addView(cell.imageView)

        --标题
        cell.textLabel = Label():width(MeasurementType.WRAP_CONTENT):height(self.cellHeight):marginLeft(10):setGravity(Gravity.CENTER_VERTICAL)
        cell.textLabel:textAlign(TextAlign.LEFT)
        cell.layout:addView(cell.textLabel)

        --附件图片
        cell.attachImageView = ImageView():width(22):height(22):marginLeft( window:width() - 32):setGravity(Gravity.CENTER_VERTICAL)
        cell.attachImageView:contentMode(ContentMode.SCALE_ASPECT_FIT)
        cell.contentView:addView(cell.attachImageView)
    end)

    -- 初始化第二种类型cell
    self.adapter:initCellByReuseId(self.CELL_TYPE2, function(cell)
        cell.layout = LinearLayout(LinearType.HORIZONTAL):setGravity(Gravity.CENTER_VERTICAL)
        cell.contentView:addView(cell.layout)

        --图标
        cell.imageView  = ImageView():width(40):height(40):marginLeft( 20):setGravity(Gravity.CENTER_VERTICAL)
        cell.imageView:contentMode(ContentMode.SCALE_ASPECT_FILL):cornerRadius(20)
        cell.imageView:bgColor(_Color.LightGray)
        cell.layout:addView(cell.imageView)

        --标题与副标题布局
        cell.titleLayout = LinearLayout(LinearType.VERTICAL):marginLeft(10):setGravity(Gravity.CENTER_VERTICAL)
        cell.layout:addView(cell.titleLayout)

        cell.titleLabel = Label():width(MeasurementType.WRAP_CONTENT):height(MeasurementType.WRAP_CONTENT):marginTop(10)
        cell.titleLabel:textAlign(TextAlign.LEFT):setTextFontStyle(FontStyle.BOLD):fontSize(14)
        cell.titleLayout:addView(cell.titleLabel)

        cell.textLabel = Label():width(MeasurementType.WRAP_CONTENT):height(MeasurementType.WRAP_CONTENT):marginLeft(5):marginTop(10)
        cell.textLabel:textAlign(TextAlign.LEFT):fontSize(14)
        cell.layout:addView(cell.textLabel)

        --副标题
        cell.descLabel = Label():width(MeasurementType.WRAP_CONTENT):height(MeasurementType.WRAP_CONTENT):marginTop(5):marginBottom(5)
        cell.descLabel:textAlign(TextAlign.LEFT):fontSize(12):textColor(Color(150,150,150))
        cell.titleLayout:addView(cell.descLabel)

        --附件图片
        cell.attachImageView = ImageView():width(45):height(45):setGravity(Gravity.CENTER_VERTICAL)
        cell.attachImageView:marginLeft( window:width() - cell.attachImageView:width() - 10)
        cell.attachImageView:contentMode(ContentMode.SCALE_ASPECT_FILL)
        cell.contentView:addView(cell.attachImageView)

        --附件按钮
        cell.attachButton = Label():width(55):height(30):setGravity(Gravity.CENTER_VERTICAL)
        cell.attachButton:marginLeft( window:width() - cell.attachButton:width() - 10)
        cell.attachButton:cornerRadius(3)
                :borderWidth(1):borderColor(Color(200,200,200))
        cell.attachButton:text("+关注"):textAlign(TextAlign.CENTER):fontSize(13):textColor(_Color.Black)
        cell.attachButton:onClick(function()
            if cell.attachButton:text() == "+关注" then
                cell.attachButton:text("已关注")
            else
                cell.attachButton:text("+关注")
            end
        end)
        cell.contentView:addView(cell.attachButton)
    end)

    self.adapter:fillCellDataByReuseId(self.CELL_TYPE1, function(cell, _, row)
        local item = self.dataList:get(row)
        cell.imageView:image(item:get("icon"))
        cell.textLabel:text(item:get("title"))
        cell.attachImageView:image(item:get("attach"))
    end)

    self.adapter:fillCellDataByReuseId(self.CELL_TYPE2, function(cell, _, row)
        local item = self.dataList:get(row)
        cell.titleLabel:text(item:get("title"))
        cell.imageView:image(item:get("icon"))
        cell.descLabel:text(item:get("desc"))
        if item:get("follow") == true then
            cell.attachButton:gone(true)
            cell.attachImageView:gone(false)
            cell.attachImageView:image(item:get("attach"))
            cell.textLabel:text("喜欢了你")
        else
            cell.attachButton:gone(false)
            cell.attachImageView:gone(true)
            cell.textLabel:text("关注了你")
        end
    end)


    self.adapter:heightForCell(function(_, _)
        return self.cellHeight
    end)

    self.adapter:selectedRow(function(cell, section, row)
        if row == 1 then
            --Toast("客服当前时间不在线哦")
            if System:Android() then
                Navigator:gotoPage("file://android_asset/MMLuaKitGallery/CustomerService.lua",Map(),1)
            else
                Navigator:gotoPage("CustomerService",Map(),0)
            end
        elseif row == 2 then
            --Toast("官方尚未发布通知")
            if  System:Android() then
                Navigator:gotoPage("file://android_asset/MMLuaKitGallery/Notification.lua",Map(),1)
            else
                Navigator:gotoPage("Notification",Map(),0)
            end
        else
            --Toast(cell.titleLabel:text(), 1)
           -- Navigator:gotoPage("file://android_asset/MMLuaKitGallery/Notification.lua",Map(),1)
        end
    end)

    self.tableView:adapter(self.adapter)
end

---@private
function _class:setupDataSource()
    self.dataList = Array()
    local item1 = Map(1)
    item1:put("icon", "https://s.momocdn.com/w/u/others/2019/08/31/1567263950353-service.png")
    item1:put("title", "私信/客服")
    item1:put("attach", "https://s.momocdn.com/w/u/others/2019/08/31/1567264720561-rightarrow.png")

    local item2 = Map(1)
    item2:put("icon", "https://s.momocdn.com/w/u/others/2019/08/31/1567263950294-notice.png")
    item2:put("title", "官方通知")
    item2:put("attach", "https://s.momocdn.com/w/u/others/2019/08/31/1567264720561-rightarrow.png")

    self.dataList:add(item1):add(item2)
end

--- 加载数据
--- @private
function _class:setupRefreshLoadData()
    --首先展示第一页数据
    self:request(true,function(success, _)
        if success then
            self.tableView:reloadData()
        end
    end)

    --下拉刷新
    self.tableView:setRefreshingCallback(function ()
        self:request(true,function(success, _)
            self.tableView:stopRefreshing()
            self.tableView:resetLoading()
            if success then
                self.tableView:reloadData()
            end
        end)
    end)

    --上拉加载
    self.tableView:setLoadingCallback(function ()
        self:request(false,function(success, data)
            self.tableView:stopLoading()
            if not data then
                self.tableView:noMoreData()
            end
            if success then
                self.tableView:reloadData()
            end
        end)
    end)
end

--- 数据请求
--- @param first boolean 是否请求第一页
--- @param complete function 数据请求结束的回调
--- @private
function _class:request(first, complete)
    if first then
        self.requestIndex = 1
    else
        self.requestIndex = self.requestIndex + 1
    end

    if System:Android() then

        File:asyncReadMapFile('file://android_asset/MMLuaKitGallery/message.json', function(codeNumber, response)

            print("codeNumber: " .. tostring(codeNumber))

            if codeNumber == 0 then
                local data = response:get("data")
                self:constructData(first, data)
                complete(true, data)
            else
                --error(err:get("errmsg"))
                complete(false, nil)
            end
        end)

        return
    end

    HTTPHandler = require("MMLuaKitGallery.HTTPHandler")
    HTTPHandler:GET("https://www.apiopen.top/femaleNameApi", {page = self.requestIndex}, function(success, response, err)
        if success then
            result = response:get('result')
            data = result:get("data")
            self:constructData(first, data)
            complete(success, data)
        else
            error(err:get("errmsg"))
            complete(false, nil)
        end
    end)
end

---@private
function _class:constructData(remove, data)
    if remove and self.dataList:size() > 2 then
        self.dataList:removeObjectsAtRange(3, self.dataList:size() - 3)
    end
    for i = 1, data:size() do
        local item = Map(1)
        item:put("title", data:get(i):get("title"))
        item:put("desc", os.date("%m-%d %H:%M:%S", os.time()))
        item:put("icon", data:get(i):get("icon"))
        --item:put("follow", (math.random(0, 10000) % 2 == 0))
        self.dataList:add(item)
    end
end

return _class
