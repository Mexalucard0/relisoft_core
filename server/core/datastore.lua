--- @param name string
--- @param cb function
function getDatastore(name, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', name, function(store)
        cb(store)
    end)
end

--- @param identifier string
--- @param name string
--- @param cb function return with store instance
function getPlayerDatastore(identifier, name, cb)
    TriggerEvent('esx_datastore:getDataStore', name, identifier, function(store)
        cb(store)
    end)
end

--- @param name string
--- @param shared boolean
--- @param cb function return with store instance
function createDatastore(name, shared, cb)
    cb = cb or function() end
    --Firstly check if datastore exists!
    if isDatastoreExists(name) then
        rdebug(string.format('Datastore %s already exists! Skipping creation.', name))
        cb(true)
    else
        rdebug(string.format('Datastore %s not found! Starting creation.', name))
        MySQL.ready(function()
            MySQL.Async.execute('INSERT INTO datastore (name, label, shared) VALUES (@name, @name, @shared)', {
                ['@name'] = name,
                ['@shared'] = shared
            }, function(rowsChanges)
                rdebug(string.format('Datastore %s created.', name))
                cb(rowsChanges)
            end)
        end)
    end
end

--- @param name string
--- @return boolean
function isDatastoreExists(name)
    rdebug(string.format('Checking %s datastore if exists.', name))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchScalar('SELECT COUNT(name) FROM datastore WHERE name = @name', {
            ['@name'] = name
        })
        if data >= 1 then
            return true
        else
            return false
        end
    end)
end
