AUTOCMD_GROUP('EventManager', { clear = true })

local this = {}
this.__index = this
this.group = "EventManager"
this.listeners = {}

function EventManager()
    this.new = function()
        return setmetatable( {}, this )
    end

    this.subscribe = function( eventType, ... )
        if this.listeners[ eventType ] == nil then
            this.listeners[ eventType ] = {}
            this.notify( eventType )
        end

        for _, listener in pairs{ ... } do
            table.insert( this.listeners[ eventType ], listener )
        end

        return true
    end

    this.unsubscribe = function( eventType, listener )
        local removed
        for i, element in pairs(this.eventType) do
            if element == listener then
                removed = table.remove(this.listeners[ eventType ], i)
                break
            end
        end

        return removed ~= nil
    end

    this.notify = function ( eventType )
        AUTOCMD( eventType, {
            group = this.group
            ,callback = function ()
                for _, listener in pairs( this.listeners[ eventType ] ) do
                    listener()
                end
            end
        })
    end

    return {
        new = this.new
        ,subscribe = this.subscribe
        ,unsubscribe = this.unsubscribe
        ,notify = this.notify
    }
end
