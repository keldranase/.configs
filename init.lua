local function pressFn(mods, key)
    if key == nil then
        key = mods
        mods = {}
    end

    return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
    hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

local function pressMany(mods, key, count, delay)
    if delay == will then delay = 20000 end

    return function()
        for i=1,count do
            hs.eventtap.keyStroke(mods, key, 20000)
        end
    end
end


remap({'alt'}, 'up', pressMany({}, 'up', 3))
remap({'alt'}, 'down', pressMany({}, 'down', 3))

remap({'shift', 'alt'}, 'up', pressMany({'shift'}, 'up', 3))
remap({'shift', 'alt'}, 'down', pressMany({'shift'}, 'down', 3))

remap({'cmd'}, 'up', pressMany({}, 'up', 5))
remap({'cmd'}, 'down', pressMany({}, 'down', 5))

remap({'shift', 'cmd'}, 'up', pressMany({'shift'}, 'up', 5))
remap({'shift', 'cmd'}, 'down', pressMany({'shift'}, 'down', 5))

remap({'ctrl'}, 'b', pressFn('pageup'))
remap({'ctrl'}, 'f', pressFn('pagedown'))

remap({'ctrl'}, 'u', pressFn({'cmd'}, 'z'))
remap({'ctrl'}, 'r', pressFn({'cmd', 'shift'}, 'z'))

remap({'cmd'}, 'delete', pressFn({}, 'forwarddelete'))

function newLineAbove()
    return function()
        hs.eventtap.keyStroke({}, 'up', 1000)
        hs.eventtap.keyStroke('cmd', 'right', 1000)
        hs.eventtap.keyStroke({}, 'return', 1000)
        hs.eventtap.keyStroke({}, 'return', 1000)
    end
end

function newLineBelow()
    return function()
        hs.eventtap.keyStroke('cmd', 'right', 1000)
        hs.eventtap.keyStroke({}, 'return', 1000)
        hs.eventtap.keyStroke({}, 'return', 1000)
    end
end

function deleteLine()
    return function()
        hs.eventtap.keyStroke('cmd', 'right', 1000)
        hs.eventtap.keyStroke('cmd', 'delete', 1000)
        hs.eventtap.keyStroke({}, 'delete', 1000)
    end
end

function deleteEntireWord()
    return function()
        hs.eventtap.keyStroke('alt', 'right', 1000)
        hs.eventtap.keyStroke('alt', 'delete', 1000)
    end
end

function selectFullLine()
    return function()
        hs.eventtap.keyStroke('cmd', 'right', 1000)
        hs.eventtap.keyStroke({'cmd', 'shift'}, 'left', 1000)
    end
end

function copyLine()
    return function()
        hs.eventtap.keyStroke('cmd', 'right', 1000)
        hs.eventtap.keyStroke({'cmd', 'shift'}, 'left', 1000)
	hs.eventtap.keyStroke('cmd', 'c', 1000)
    end
end

remap({'ctrl', 'shift'}, 's', selectFullLine())
remap({'ctrl'}, 'w', deleteEntireWord())
remap({'ctrl'}, 'd', deleteLine())
remap({'ctrl'}, 'return', newLineBelow())
remap({'ctrl', 'shift'}, 'return', newLineAbove())
remap({'ctrl', 'shift'}, 'c', copyLine())

--function superRemap(mod, oldKey, newKey, mods)
--    f1 = function() hs.eventtap.keyStroke({}, newKey, 1000) end
--    hs.hotkey.bind(mod, oldKey, f1, nil, f1)
--end


--f1 = function() hs.eventtap.keyStroke({}, 'forwarddelete', 1000) end
--hs.hotkey.bind('ctrl', 'delete', f1, nil, f1)

--superRemap('ctrl', 'delete', 'forwarddelete', {'alt', 'cmd', 'shift'})


function open_app(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

hs.hotkey.bind({"option"}, "o", open_app("Obsidian"))
hs.hotkey.bind({"alt"}, "i", open_app("Intellij IDEA"))
hs.hotkey.bind({"alt"}, "s", open_app("Slack"))
hs.hotkey.bind({"alt"}, "n", open_app("Firefox"))
hs.hotkey.bind({"alt"}, "t", open_app("iTerm"))
hs.hotkey.bind({"alt"}, "k", open_app("TickTick"))

-- hs.hotkey.bind({"ctrl"}, "t", function() hs.execute("parse") end) 
