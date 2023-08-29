AUTOCMD_GROUP('EventManager', { clear = true })

function EventManager()
       local this = {}
       this.__index = this
       this.group = "EventManager"
       this.listeners = {}

    local function unsubscribe( eventType, listener )
        local removed
        for i, element in pairs(this.eventType) do
            if element == listener then
                removed = table.remove(this.listeners[ eventType ], i)
                break
            end
        end

        return removed ~= nil
    end

    local function notify( eventType )
        AUTOCMD( eventType, {
            group = this.group
            ,callback = function ()
                for _, listener in pairs( this.listeners[ eventType ] ) do
                    listener()
                end
            end
        })
    end

    local function subscribe( eventType, listener )
        if this.listeners[ eventType ] == nil then
            this.listeners[ eventType ] = {}
            notify( eventType )
        end

        table.insert( this.listeners[ eventType ], listener )
        return true
    end

    return {
        subscribe = subscribe
        ,unsubscribe = unsubscribe
        ,notify = notify
    }
end
