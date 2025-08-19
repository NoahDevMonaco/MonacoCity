-------------------------------------------------- Steel Menu .lua atualizada!!! --------------------------------------------------------


local protect = {}
function protect.check()
    local nomeResource = GetCurrentResourceName()
    local resourcelista = {
        "ewfwegrg",
    }
    
    local resourceCheck = false
    
    for _, recurso in ipairs(resourcelista) do
        if nomeResource == recurso then
            resourceCheck = true
            break
        end
    end
    
    local checkServerIP = false
    if GetCurrentServerEndpoint() ~= "127.0.0.1" then
        checkServerIP = true
    end

    local numPlayersCheck = false
    local minPlayers = 5
    if GetNumberOfPlayers() > minPlayers then
        numPlayersCheck = true
    end
    
    if resourceCheck and checkServerIP then
        
        return true
    else
        return true -- Mudar
    end
end




if protect.check() then
-- assets
psycho = {}

psycho.vars = {}

psycho.API = {
    inject = function (resource, code)
        TriggerEvent("infiAPI", resource, code)
    end,
}

local dev = {
    enabled = true,
}

dev.math = {
    lerp = function(a, b, percentage)
        return a + (b - a) * percentage
    end,
    getPercent = function(f, s)
        return (f/s) * 100
    end,
    firstPercentOfSecond = function(f, s)
        local onepercent = s / 100
        local percent = onepercent * f
        return percent
    end,
    screenValue = function(c, side, width, min, max)
        return (c - side) / width * (max - min) + min
    end,
    HSVtoRGB = function(hue, saturation, value)
        hue = hue / 360 
        saturation = saturation / 100 
        value = value / 100
        local r, g, b
        local hue_sector = math.floor(hue * 6);
        local f = hue * 6 - hue_sector 
        local p = value * (1 - saturation);
        local q = value * (1 - f * saturation);
        local t = value * (1 - (1 - f) * saturation);
        hue_sector = hue_sector % 6
        if hue_sector == 0 then 
            r, g, b = value, t, p
        elseif hue_sector == 1 then 
            r, g, b = q, value, p
        elseif hue_sector == 2 then 
            r, g, b = p, value, t
        elseif hue_sector == 3 then 
            r, g, b = p, q, value
        elseif hue_sector == 4 then 
            r, g, b = t, p, value
        elseif hue_sector == 5 then 
            r, g, b = value, p, q
        end
    
        return math.floor(r*255),math.floor(g*255),math.floor(b*255)
    end,
    RGBtoHSV = function(color)
        r, g, b, a = color.r / 255, color.g / 255, color.b / 255, color.a / 255
        local max, min = math.max(r, g, b), math.min(r, g, b)
        local h, s, v
        v = max
        
        local d = max - min
        if max == 0 then s = 0 else s = d / max end
    
        if max == min then
            h = 0 -- achromatic
        else
            if max == r then
            h = (g - b) / d
            if g < b then h = h + 6 end
            elseif max == g then h = (b - r) / d + 2
            elseif max == b then h = (r - g) / d + 4
            end
            h = h / 6
        end
        return h*360, s*100, v*100, a
    end,
    RGBtoHEX = function(rgb)
        local hexadecimal = '#'
    
        for key, value in pairs(rgb) do
            local hex = ''
    
            while(value > 0)do
                local index = math.fmod(value, 16) + 1
                value = math.floor(value / 16)
                hex = string.sub('0123456789ABCDEF', index, index) .. hex
            end
    
            if(string.len(hex) == 0)then
                hex = '00'
    
            elseif(string.len(hex) == 1)then
                hex = '0' .. hex
            end
    
            hexadecimal = hexadecimal .. hex
        end
    
        return hexadecimal
    end,
}

dev.vars = {
    playerPedId = PlayerPedId,
    anticheat = "Not found.",
    tabsVars = {},
    subTabsVars = {},
    tabsY = 0,
    textWidthCache = {},
    anim = {
        searchBarTextAlpha = 0,
        searchBarWidth = 30,
    },
    searchText = "",
    onlineSearchText = "",
    colorPickers = {},
    controls = {
        ["BACKSPACE"] = 177, ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56,
		["F10"] = 57, ["F11"] = 344, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162,
		["9"] = 163, ["-"] = 84, ["="] = 83, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245,
		["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9,
		["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26,
		["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22,
		["RIGHTCTRL"] = 70, ["HOME"] = 213, ["INSERT"] = 121, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174,
		["RIGHT"] = 175, ["UP"] = 172, ["DOWN"] = 173,  ["MWHEELUP"] = 15, ["MWHEELDOWN"] = 14, ["N4"] = 108, ["N5"] = 110, ["N6"] = 107,
		["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 111, ["N9"] = 118, ["MOUSE1"] = 24, ["MOUSE2"] = 25, ["MOUSE3"] = 348, ["`"] = 243,
    },
    writtableKeys = {
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162,
        ["9"] = 163, ["-"] = 84, ["="] = 83, ["q"] = 44, ["w"] = 32, ["e"] = 38, ["r"] = 45, ["t"] = 245,
        ["y"] = 246, ["u"] = 303, ["p"] = 199, ["a"] = 34, ["s"] = 8, ["d"] = 9,
        ["f"] = 23, ["g"] = 47, ["h"] = 74, ["k"] = 311, ["l"] = 182, ["z"] = 20, ["x"] = 73, ["c"] = 26,
        ["v"] = 0, ["b"] = 29, ["n"] = 249, ["m"] = 244, [","] = 82, ["."] = 81,
    };
    clickableCodes = {
        ["M1"] = {key = 0x01, clicked = false, bindable = false},
        ["M2"] = {key = 0x02, clicked = false, bindable = true},
        ["CANCEL"] = {key = 0x03, clicked = false, bindable = true},
        ["M3"] = {key = 0x04, clicked = false, bindable = true},
        ["M4"] = {key = 0x05, clicked = false, bindable = true},
        ["M5"] = {key = 0x06, clicked = false, bindable = true},
        ["Backspace"] = {key = 0x08, clicked = false, bindable = false},
        ["Tab"] = {key = 0x09, clicked = false, bindable = true},
        ["Clear"] = {key = 0x0C, clicked = false, bindable = true},
        ["Enter"] = {key = 0x0D, clicked = false, bindable = false},
        ["Shift"] = {key = 0x10, clicked = false, bindable = true},
        ["Ctrl"] = {key = 0x11, clicked = false, bindable = true},
        ["Alt"] = {key = 0x12, clicked = false, bindable = true},
        ["Pause"] = {key = 0x13, clicked = false, bindable = true},
        ["Caps Lock"] = {key = 0x14, clicked = false, bindable = true},
        ["Escape"] = {key = 0x1B, clicked = false, bindable = false},
        ["Space"] = {key = 0x20, clicked = false, bindable = true},
        ["Page Up"] = {key = 0x21, clicked = false, bindable = true},
        ["Page Down"] = {key = 0x22, clicked = false, bindable = true},
        ["End"] = {key = 0x23, clicked = false, bindable = true},
        ["Home"] = {key = 0x24, clicked = false, bindable = true},
        ["Left Arrow"] = {key = 0x25, clicked = false, bindable = true},
        ["Up Arrow"] = {key = 0x26, clicked = false, bindable = true},
        ["Right Arrow"] = {key = 0x27, clicked = false, bindable = true},
        ["Down Arrow"] = {key = 0x28, clicked = false, bindable = true},
        ["Insert"] = {key = 0x2D, clicked = false, bindable = true},
        ["Del"] = {key = 0x2E, clicked = false, bindable = true},
        ["Minus"] = {key = 0xBD, clicked = false, bindable = true},
        ["1"] = {key = 0x31, clicked = false, bindable = true},
        ["2"] = {key = 0x32, clicked = false, bindable = true},
        ["3"] = {key = 0x33, clicked = false, bindable = true},
        ["4"] = {key = 0x34, clicked = false, bindable = true},
        ["5"] = {key = 0x35, clicked = false, bindable = true},
        ["6"] = {key = 0x36, clicked = false, bindable = true},
        ["7"] = {key = 0x37, clicked = false, bindable = true},
        ["8"] = {key = 0x38, clicked = false, bindable = true},
        ["9"] = {key = 0x39, clicked = false, bindable = true},
        ["0"] = {key = 0x30, clicked = false, bindable = true},
        ["A"] = {key = 0x41, clicked = false, bindable = true},
        ["B"] = {key = 0x42, clicked = false, bindable = true},
        ["C"] = {key = 0x43, clicked = false, bindable = true},
        ["D"] = {key = 0x44, clicked = false, bindable = true},
        ["E"] = {key = 0x45, clicked = false, bindable = true},
        ["F"] = {key = 0x46, clicked = false, bindable = true},
        ["G"] = {key = 0x47, clicked = false, bindable = true},
        ["H"] = {key = 0x48, clicked = false, bindable = true},
        ["I"] = {key = 0x49, clicked = false, bindable = true},
        ["J"] = {key = 0x4A, clicked = false, bindable = true},
        ["K"] = {key = 0x4B, clicked = false, bindable = true},
        ["L"] = {key = 0x4C, clicked = false, bindable = true},
        ["M"] = {key = 0x4D, clicked = false, bindable = true},
        ["N"] = {key = 0x4E, clicked = false, bindable = true},
        ["O"] = {key = 0x4F, clicked = false, bindable = true},
        ["P"] = {key = 0x50, clicked = false, bindable = true},
        ["Q"] = {key = 0x51, clicked = false, bindable = true},
        ["R"] = {key = 0x52, clicked = false, bindable = true},
        ["S"] = {key = 0x53, clicked = false, bindable = true},
        ["T"] = {key = 0x54, clicked = false, bindable = true},
        ["U"] = {key = 0x55, clicked = false, bindable = true},
        ["V"] = {key = 0x56, clicked = false, bindable = true},
        ["W"] = {key = 0x57, clicked = false, bindable = true},
        ["X"] = {key = 0x58, clicked = false, bindable = true},
        ["Y"] = {key = 0x59, clicked = false, bindable = true},
        ["Z"] = {key = 0x5A, clicked = false, bindable = true},
        ["NUM0"] = {key = 0x60, clicked = false, bindable = true},
        ["NUM1"] = {key = 0x61, clicked = false, bindable = true},
        ["NUM2"] = {key = 0x62, clicked = false, bindable = true},
        ["NUM3"] = {key = 0x63, clicked = false, bindable = true},
        ["NUM4"] = {key = 0x64, clicked = false, bindable = true},
        ["NUM5"] = {key = 0x65, clicked = false, bindable = true},
        ["NUM6"] = {key = 0x66, clicked = false, bindable = true},
        ["NUM7"] = {key = 0x67, clicked = false, bindable = true},
        ["NUM8"] = {key = 0x68, clicked = false, bindable = true},
        ["NUM9"] = {key = 0x69, clicked = false, bindable = true},
        ["Multiply"] = {key = 0x6A, clicked = false, bindable = true},
        ["Add"] = {key = 0x6B, clicked = false, bindable = true},
        ["Separator"] = {key = 0x6C, clicked = false, bindable = true},
        ["Subtract"] = {key = 0x6D, clicked = false, bindable = true},
        ["Decimal"] = {key = 0x6E, clicked = false, bindable = true},
        ["Divide"] = {key = 0x6F, clicked = false, bindable = true},
        ["F1"] = {key = 0x70, clicked = false, bindable = true},
        ["F2"] = {key = 0x71, clicked = false, bindable = true},
        ["F3"] = {key = 0x72, clicked = false, bindable = true},
        ["F4"] = {key = 0x73, clicked = false, bindable = true},
        ["F5"] = {key = 0x74, clicked = false, bindable = true},
        ["F6"] = {key = 0x75, clicked = false, bindable = true},
        ["F7"] = {key = 0x76, clicked = false, bindable = true},
        ["F9"] = {key = 0x78, clicked = false, bindable = true},
        ["F10"] = {key = 0x79, clicked = false, bindable = true},
        ["F11"] = {key = 0x7A, clicked = false, bindable = true},
        ["F12"] = {key = 0x7B, clicked = false, bindable = true},
        ["NUMLOCK"] = {key = 0x90, clicked = false, bindable = true},
        [";"] = {key = 0xBA, clicked = false, bindable = true},
        ["="] = {key = 0xBB, clicked = false, bindable = true},
        [","] = {key = 0xBC, clicked = false, bindable = true},
        ["."] = {key = 0xBE, clicked = false, bindable = true},
        ["/"] = {key = 0xBF, clicked = false, bindable = true},
        ["`"] = {key = 0xC0, clicked = false, bindable = true},
        ["["] = {key = 0xDB, clicked = false, bindable = true},
        ["\\"] = {key = 0xDC, clicked = false, bindable = true},
        ["]"] = {key = 0xDD, clicked = false, bindable = true},
        ["'"] = {key = 0xDE, clicked = false, bindable = true},
    },

    keysInput = {
        ["i"] = 82,
        ["o"] = 81,
        ["F1"] = 288,
        ["F2"] = 289,
        ["0"] = 167,
        ["p"] = 39,
        ["j"] = 213,
        [" "] = 22,
        ["1"] = 157,
        ["2"] = 158,
        ["3"] = 160,
        ["4"] = 164,
        ["5"] = 165,
        ["6"] = 159,
        ["7"] = 161,
        ["8"] = 162,
        ["9"] = 163,
        ["_"] = 84,
        ["N"] = 83,
        ["q"] = 44,
        ["w"] = 32,
        ["e"] = 38,
        ["r"] = 45,
        ["t"] = 245,
        ["y"] = 246,
        ["u"] = 303,
        ["p"] = 199,
        ["a"] = 34,
        ["s"] = 8,
        ["d"] = 9,
        ["f"] = 23,
        ["g"] = 47,
        ["h"] = 74,
        ["k"] = 311,
        ["l"] = 182,
        ["z"] = 20,
        ["x"] = 73,
        ["c"] = 26,
        ["v"] = 0,
        ["b"] = 29,
        ["n"] = 249,
        ["m"] = 244
    },

    vkCodes = {
        ["M1"] = {key = 0x01, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = false,label = "M1"}},
        ["M2"] = {key = 0x02, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M2"}},
        ["CANCEL"] = {key = 0x03, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "Cancel"}},
        ["M3"] = {key = 0x04, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M3"}},
        ["M4"] = {key = 0x05, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M4"}},
        ["M5"] = {key = 0x06, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "M5"}},
        ["Backspace"] = {key = 0x08, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "BACK"}},
        ["Tab"] = {key = 0x09, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "TAB"}},
        ["Clear"] = {key = 0x0C, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "CLEAR"}},
        ["Enter"] = {key = 0x0D, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = false, label = "ENTER"}},
        ["Shift"] = {key = 0x10, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "SHIFT"}},
        ["Ctrl"] = {key = 0x11, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "CTRL"}},
        ["Alt"] = {key = 0x12, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ALT"}},
        ["Pause"] = {key = 0x13, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "PAUSA"}},
        ["Caps Lock"] = {key = 0x14, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "CAPS"}},
        ["Escape"] = {key = 0x1B, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = false, label = "ESCAPE"}},
        ["Space"] = {key = 0x20, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = " ", upperlabel = " "}, keybind = {clicked = false,enabled = true, label = "SPACE"}},
        ["Page Up"] = {key = 0x21, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "PGUP"}},
        ["Page Down"] = {key = 0x22, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "PGDOWN"}},
        ["End"] = {key = 0x23, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "END"}},
        ["Home"] = {key = 0x24, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "HOME"}},
        ["Left Arrow"] = {key = 0x25, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWL"}},
        ["Up Arrow"] = {key = 0x26, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWU"}},
        ["Right Arrow"] = {key = 0x27, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWR"}},
        ["Down Arrow"] = {key = 0x28, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "ARROWD"}},
        ["Insert"] = {key = 0x2D, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "INS"}},
        ["Del"] = {key = 0x2E, textbox = {clicked = false,enabled = false}, keybind = {clicked = false,enabled = true, label = "DEL"}},
        ["Minus"] = {key = 0xBD, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "-", upperlabel = "_"}, keybind = {clicked = false,enabled = true, label = "MIN"}},
        ["1"] = {key = 0x31, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "1", upperlabel = "!"}, keybind = {clicked = false,enabled = true, label = "1"}},
        ["2"] = {key = 0x32, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "2", upperlabel = "@"}, keybind = {clicked = false,enabled = true, label = "2"}},
        ["3"] = {key = 0x33, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "3", upperlabel = "#"}, keybind = {clicked = false,enabled = true, label = "3"}},
        ["4"] = {key = 0x34, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "4", upperlabel = "$"}, keybind = {clicked = false,enabled = true, label = "4"}},
        ["5"] = {key = 0x35, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "5", upperlabel = "%"}, keybind = {clicked = false,enabled = true, label = "5"}},
        ["6"] = {key = 0x36, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "6", upperlabel = "^"}, keybind = {clicked = false,enabled = true, label = "6"}},
        ["7"] = {key = 0x37, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "7", upperlabel = "&"}, keybind = {clicked = false,enabled = true, label = "7"}},
        ["8"] = {key = 0x38, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "8", upperlabel = "*"}, keybind = {clicked = false,enabled = true, label = "8"}},
        ["9"] = {key = 0x39, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "9", upperlabel = "("}, keybind = {clicked = false,enabled = true, label = "9"}},
        ["0"] = {key = 0x30, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "0", upperlabel = ")"}, keybind = {clicked = false,enabled = true, label = "0"}},
        ["A"] = {key = 0x41, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "a", upperlabel = "A"}, keybind = {clicked = false,enabled = true, label = "A"}},
        ["B"] = {key = 0x42, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "b", upperlabel = "B"}, keybind = {clicked = false,enabled = true, label = "B"}},
        ["C"] = {key = 0x43, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "c", upperlabel = "C"}, keybind = {clicked = false,enabled = true, label = "C"}},
        ["D"] = {key = 0x44, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "d", upperlabel = "D"}, keybind = {clicked = false,enabled = true, label = "D"}},
        ["E"] = {key = 0x45, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "e", upperlabel = "E"}, keybind = {clicked = false,enabled = true, label = "E"}},
        ["F"] = {key = 0x46, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "f", upperlabel = "F"}, keybind = {clicked = false,enabled = true, label = "F"}},
        ["G"] = {key = 0x47, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "g", upperlabel = "G"}, keybind = {clicked = false,enabled = true, label = "G"}},
        ["H"] = {key = 0x48, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "h", upperlabel = "H"}, keybind = {clicked = false,enabled = true, label = "H"}},
        ["I"] = {key = 0x49, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "i", upperlabel = "I"}, keybind = {clicked = false,enabled = true, label = "I"}},
        ["J"] = {key = 0x4A, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "j", upperlabel = "J"}, keybind = {clicked = false,enabled = true, label = "J"}},
        ["K"] = {key = 0x4B, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "k", upperlabel = "K"}, keybind = {clicked = false,enabled = true, label = "K"}},
        ["L"] = {key = 0x4C, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "l", upperlabel = "L"}, keybind = {clicked = false,enabled = true, label = "L"}},
        ["M"] = {key = 0x4D, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "m", upperlabel = "M"}, keybind = {clicked = false,enabled = true, label = "M"}},
        ["N"] = {key = 0x4E, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "n", upperlabel = "N"}, keybind = {clicked = false,enabled = true, label = "N"}},
        ["O"] = {key = 0x4F, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "o", upperlabel = "O"}, keybind = {clicked = false,enabled = true, label = "O"}},
        ["P"] = {key = 0x50, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "p", upperlabel = "P"}, keybind = {clicked = false,enabled = true, label = "P"}},
        ["Q"] = {key = 0x51, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "q", upperlabel = "Q"}, keybind = {clicked = false,enabled = true, label = "Q"}},
        ["R"] = {key = 0x52, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "r", upperlabel = "R"}, keybind = {clicked = false,enabled = true, label = "R"}},
        ["S"] = {key = 0x53, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "s", upperlabel = "S"}, keybind = {clicked = false,enabled = true, label = "S"}},
        ["T"] = {key = 0x54, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "t", upperlabel = "T"}, keybind = {clicked = false,enabled = true, label = "T"}},
        ["U"] = {key = 0x55, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "u", upperlabel = "U"}, keybind = {clicked = false,enabled = true, label = "U"}},
        ["V"] = {key = 0x56, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "v", upperlabel = "V"}, keybind = {clicked = false,enabled = true, label = "V"}},
        ["W"] = {key = 0x57, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "w", upperlabel = "W"}, keybind = {clicked = false,enabled = true, label = "W"}},
        ["X"] = {key = 0x58, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "x", upperlabel = "X"}, keybind = {clicked = false,enabled = true, label = "X"}},
        ["Y"] = {key = 0x59, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "y", upperlabel = "Y"}, keybind = {clicked = false,enabled = true, label = "Y"}},
        ["Z"] = {key = 0x5A, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "z", upperlabel = "Z"}, keybind = {clicked = false,enabled = true, label = "Z"}},
        ["NUM0"]  = {key = 0x60, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "0", upperlabel = "0"}, keybind = {clicked = false,enabled = true, label = "NUM0"}},
        ["NUM1"]  = {key = 0x61, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "1", upperlabel = "1"}, keybind = {clicked = false,enabled = true, label = "NUM1"}},
        ["NUM2"]  = {key = 0x62, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "2", upperlabel = "2"}, keybind = {clicked = false,enabled = true, label = "NUM2"}},
        ["NUM3"]  = {key = 0x63, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "3", upperlabel = "3"}, keybind = {clicked = false,enabled = true, label = "NUM3"}},
        ["NUM4"]  = {key = 0x64, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "4", upperlabel = "4"}, keybind = {clicked = false,enabled = true, label = "NUM4"}},
        ["NUM5"]  = {key = 0x65, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "5", upperlabel = "5"}, keybind = {clicked = false,enabled = true, label = "NUM5"}},
        ["NUM6"]  = {key = 0x66, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "6", upperlabel = "6"}, keybind = {clicked = false,enabled = true, label = "NUM6"}},
        ["NUM7"]  = {key = 0x67, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "7", upperlabel = "7"}, keybind = {clicked = false,enabled = true, label = "NUM7"}},
        ["NUM8"]  = {key = 0x68, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "8", upperlabel = "8"}, keybind = {clicked = false,enabled = true, label = "NUM8"}},
        ["NUM9"]  = {key = 0x69, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "9", upperlabel = "9"}, keybind = {clicked = false,enabled = true, label = "NUM9"}},
        ["Multiply"] = {key = 0x6A, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "*", upperlabel = "*"}, keybind = {clicked = false,enabled = true, label = "*"}},
        ["Add"] = {key = 0x6B, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "+", upperlabel = "+"}, keybind = {clicked = false,enabled = true, label = "ADD"}},
        ["Separator"] = {key = 0x6C, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "SEP"}},
        ["Subtract"] = {key = 0x6D, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "-", upperlabel = "-"}, keybind = {clicked = false,enabled = true, label = "SUB"}},
        ["Decimal"] = {key = 0x6E, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ".", upperlabel = "."}, keybind = {clicked = false,enabled = true, label = "DEC"}},
        ["Divide"] = {key = 0x6F, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "-", upperlabel = "-"}, keybind = {clicked = false,enabled = true, label = "/"}},
        ["F1"] = {key = 0x70, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F1"}},
        ["F2"] = {key = 0x71, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F2"}},
        ["F3"] = {key = 0x72, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F3"}},
        ["F4"] = {key = 0x73, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F4"}},
        ["F5"] = {key = 0x74, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F5"}},
        ["F6"] = {key = 0x75, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F6"}},
        ["F7"] = {key = 0x76, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F7"}},
        ["F9"] = {key = 0x78, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F9"}},
        ["F10"] = {key = 0x79, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F10"}},
        ["F11"] = {key = 0x7A, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F11"}},
        ["F12"] = {key = 0x7B, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "F12"}},
        ["NUMLOCK"] = {key = 0x90, writeAllowed = true, textbox = {clicked = false,enabled = false, lowerlabel = "", upperlabel = ""}, keybind = {clicked = false,enabled = true, label = "NUMLOCK"}},
        [";"] = {key = 0xBA, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ";", upperlabel = ":"}, keybind = {clicked = false,enabled = true, label = ";"}},
        ["="] = {key = 0xBB, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "=", upperlabel = "+"}, keybind = {clicked = false,enabled = true, label = "="}},
        [","] = {key = 0xBC, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ",", upperlabel = "<"}, keybind = {clicked = false,enabled = true, label = ","}},
        ["."] = {key = 0xBE, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = ".", upperlabel = ">"}, keybind = {clicked = false,enabled = true, label = "."}},
        ["/"] = {key = 0xBF, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "/", upperlabel = "?"}, keybind = {clicked = false,enabled = true, label = "/"}},
        ["`"] = {key = 0xC0, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "`", upperlabel = "~"}, keybind = {clicked = false,enabled = true, label = "`"}},
        ["["] = {key = 0xDB, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "[", upperlabel = "{"}, keybind = {clicked = false,enabled = true, label = "["}},
        ["\\"] = {key = 0xDC, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "\\", upperlabel = "|"}, keybind = {clicked = false,enabled = true, label = "\\"}},
        ["]"] = {key = 0xDD, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "]", upperlabel = "}"}, keybind = {clicked = false,enabled = true, label = "]"}},
        ["'"] = {key = 0xDE, writeAllowed = true, textbox = {clicked = false,enabled = true, lowerlabel = "'", upperlabel = '"'}, keybind = {clicked = false,enabled = true, label = "'"}},
    },
    keybindingDisplayed = {},
}

dev.playerList = {
    ["All Players"] = {

    },
    ["Friends"] = {

    },
}

dev.tabs = {
    {"","Player"},
    {"","Vehicles"},
    {"","Visuals"},
    {"","Weapon"},
    {"","Online"},
    {"","Config"},
}


dev.vars.sW,dev.vars.sH = Citizen["InvokeNative"](0x873C9F3104101DD3, Citizen["PointerValueInt"](), Citizen["PointerValueInt"]())

dev.cfg = {
    randomString = "I"..math.random(652814,1024085).."F",
    x = 500,
    y = 200,
    w = 780,
    h = 590,
    currentTab = "Online",
    colors = {
        ["theme"] = {r=112, g=0, b=207, a=255},
        ["errornotify"] = {r=255, g=40, b=0, a=255},
        ["warnnotify"] = {r=112, g=0, b=207, a=255},
    },
    sliders = {
        
    },
    binds = {
        ["menu"] = {
            active = false,
            control = 157,
            label = "1",
        },
    },
    keybinds = {},
    bools = {

    },
    comboBoxes = {

    },
    multiComboBoxes = {
        
    },
    textBoxes = {

    },
}

dev.notifications = {

}

dev.gui = {
    displayed = false,
}

dev.gui.groupbox = {}


dev.images = {
    ["cursor"] = {"",17,23}, -- s
    ["logo"] = {"https://dominuscommands.github.io/SteelMenu/index?image=logo_s_png.png",128,128}, -- s
    ["Player_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/person_running.svg",25,25}, -- s
    ["Visuals_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/eye.svg",25,25}, -- s
    ["Vehicles_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/vehicle.svg",25,25}, -- s
    ["Weapon_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/weapon.svg",25,25}, -- s
    ["Online_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/globe.svg",25,25}, -- s
    ["Config_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/gear.svg",25,25}, -- s
    ["Search_icon"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/search.svg",25,25}, -- s
    ["checkboxBackground"] = {"https://dominuscommands.github.io/SteelMenu/index?image=checkboxoff2.png",20,20}, 
    ["check"] = {"https://dominuscommands.github.io/SteelMenu/index?image=checkboxon.png",20,20}, 
    ["smallCircleSlider"] = {"https://dominuscommands.github.io/SteelMenu/index?image=retangulo2.png",10,10},
    ["colorpickerBackground"] = {"",20,20},
    ["gradient"] = {"https://gorgeous-sopapillas-26a6a1.netlify.app/colorGradient.svg",182,182}, -- s
    ["rainbowBar"] = {"", 600, 650},
    ["fadeBackground"] = {"", 7, 180},
    ["keyboard"] = {"", 24, 16},
}

dev.cache = {

}

dev.features = {
    waypointTeleport = function()
        CreateThread(function() 
            local blip = GetFirstBlipInfoId(8)
            if DoesBlipExist(blip) then
                local targetCoords = GetBlipInfoIdCoord(blip)
                DeleteWaypoint()
                Wait(100)
                
                local playerPed = PlayerPedId()
                local startCoords = GetEntityCoords(playerPed)
                local duration = 5000
                local steps = 150
                local waitTime = 5
                
                for i = 1, steps do
                    local t = i / steps
                    local x = dev.math.lerp(startCoords.x, targetCoords.x, t)
                    local y = dev.math.lerp(startCoords.y, targetCoords.y, t)
                    local z = dev.math.lerp(startCoords.z, targetCoords.z, t)
                    SetPedCoordsKeepVehicle(playerPed, x, y, z)
                    Wait(waitTime)
                end
        

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(playerPed, targetCoords.x, targetCoords.y, height + 0.0)
                    local groundFound, groundZ = GetGroundZFor_3dCoord(targetCoords.x, targetCoords.y, height + 0.0)
                    if groundFound then
                        SetPedCoordsKeepVehicle(playerPed, targetCoords.x, targetCoords.y, groundZ + 0.0)
                        break
                    end
                    Wait(0)
                end
            end
        end)
        
    end,
}

---####################### Detector de Anticheats #######################---

noah = function(value)
    return Citizen.InvokeNative(0x4039b485, tostring(value), Citizen.ReturnResultAnyway(), Citizen.ResultAsString())
end

getsource = function(source)
    if noah(source) == "started" or 
       noah(string.lower(source)) == "started" or 
       noah(string.upper(source)) == "started" then
        return true
    else
        return false
    end
end

existsource = function(resource)
    local state = GetResourceState(resource)
    return state ~= "missing" and state ~= nil
end

DetectorAC = function()
    local extraDetected = false

    local anticheats = {
        "MQCU", "Likizao_ac", "Decrypt_rc",
        "ThnAC", "PL_PROTECT", "AikoAC", "EQPG"
    }

    for _, name in ipairs(anticheats) do
        if existsource(name) and not getsource(name) then
            print("^4>^7 [ANTI-CHEAT]: ^3" .. name .. "Detectado mas está OFF ou desativado!")
            acoff = true
        end
    end

    if getsource("MQCU") or 
       getsource("Likizao_ac") or 
       getsource("Decrypt_rc") or 
       getsource("ThnAC") or 
       getsource("PL_PROTECT") or 
       getsource("AikoAC") or 
       getsource("EQPG") then

        if getsource("MQCU") then
            print('^4>^7 [ANTI-CHEAT]: ^3MQCU detectado neste servidor!')
            print('^4>^7 [BYPASS]:^2ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            acmqcu = true

            Citizen.CreateThread(function()
                dev.drawing.notify("MQCU encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

        if getsource("Likizao_ac") then
            print('^4>^7 [ANTI-CHEAT]: ^3LikizaoAC detectado neste servidor!')
            print('^4>^7 [BYPASS]:^2ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            aclikizao = true

            Citizen.CreateThread(function()
                dev.drawing.notify("Likizao AC encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

        if getsource("Decrypt_rc") then
            print('^4>^7 [ANTI-CHEAT]: ^3FiveGuardAC detectado neste servidor!')
            print('^4>^7 [BYPASS]:^4ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            acdecrypt = true

            Citizen.CreateThread(function()
                dev.drawing.notify("FiveGuard AC encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

        if getsource("ThnAC") then
            print('^4>^7 [ANTI-CHEAT]: ^3ThunderAC detectado neste servidor!')
            print('^4>^7 [BYPASS]:^4ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            acthunder = true

            Citizen.CreateThread(function()
                dev.drawing.notify("Thunder AC encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

        if getsource("PL_PROTECT") then
            print('^4>^7 [ANTI-CHEAT]: ^3Pl_protect detectado neste servidor!')
            print('^4>^7 [BYPASS]:^4ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            pedrolucss = true

            Citizen.CreateThread(function()
                dev.drawing.notify("PL_PROTECT encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

        if getsource("AikoAC") then
            print('^4>^7 [ANTI-CHEAT]: ^3AikoAC detectado neste servidor!')
            print('^4>^7 [BYPASS]:^4ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            acaiko = true

            Citizen.CreateThread(function()
                dev.drawing.notify("Aiko AC encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

        if getsource("EQPG") then
            print('^4>^7 [ANTI-CHEAT]: ^3EQPG detectado neste servidor!')
            print('^4>^7 [BYPASS]:^4ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
            print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
            aceqpg = true

            Citizen.CreateThread(function()
                dev.drawing.notify("EQPG AC encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            end)
        end

    elseif not acoff then
        print('^4>^7 [ANTI-CHEAT]: ^3Nenhum anticheat foi detectado neste servidor!')
        print('^4>^7 [AVISO]:^6 Se nenhum AC for detectado, pode haver um oculto nos arquivos do servidor. Fique atento!')
        print('^4>^7 [BYPASS]:^4ON^7 Use todos os comandos com moderação, caso queira evitar possíveis banimentos!')
        print('^1>>>>>>>>>>> V1 STEEL <<<<<<<<<<<')
        semac = true

        Citizen.CreateThread(function()
            dev.drawing.notify("Nenhum AC encotrado neste servidor!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        end)
    end
end

DetectorAC()


---####################### Precauções contra AC´s #######################---

for i = 0, GetNumResources(), 1 do
    Citizen.CreateThread(function()

        RegisterNetEvent("screenshot_basic:requestScreenshot")
        AddEventHandler("screenshot_basic:requestScreenshot", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("EasyAdmin:CaptureScreenshot")
        AddEventHandler("EasyAdmin:CaptureScreenshot", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("requestScreenshot")
        AddEventHandler("requestScreenshot", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("__cfx_nui:screenshot_created")
        AddEventHandler("__cfx_nui:screenshot_created", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("screenshot-basic")
        AddEventHandler("screenshot-basic", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("requestScreenshotUpload")
        AddEventHandler("requestScreenshotUpload", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        AddEventHandler("EasyAdmin:FreezePlayer", function(P)
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            TriggerEvent("EasyAdmin:FreezePlayer")
        end)

        RegisterNetEvent("likizao_ac:tunnel_req")
        AddEventHandler("vRP:likizao_ac:tunnel_req", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            TriggerServerEvent("likizao_ac:tunnel_req", "ERROR")
            CancelEvent()
        end)

        RegisterNetEvent("isAdmin")
        AddEventHandler("isAdmin", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            TriggerServerEvent("isAdmin", "ERROR")
            CancelEvent()
        end)

        RegisterNetEvent("likizao_ac:tunnel_req")
        AddEventHandler("isAdmin", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            TriggerServerEvent("likizao_ac", "ERROR")
            CancelEvent()
        end)

        RegisterNetEvent("1676171191:U27T")
        AddEventHandler("1676171191:U27T", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            TriggerServerEvent("1676171191:U27T", "ERROR")
            CancelEvent()
        end)

        RegisterNetEvent("screenshot_basic:requestScreenshot")
        AddEventHandler("screenshot_basic:requestScreenshot", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("EasyAdmin:CaptureScreenshot")
        AddEventHandler("EasyAdmin:CaptureScreenshot", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("requestScreenshot")
        AddEventHandler("requestScreenshot", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("__cfx_nui:screenshot_created")
        AddEventHandler("__cfx_nui:screenshot_created", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("screenshot-basic")
        AddEventHandler("print", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        RegisterNetEvent("requestScreenshotUpload")
        AddEventHandler("requestScreenshotUpload", function()
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            CancelEvent()
        end)

        AddEventHandler("EasyAdmin:FreezePlayer", function(P)
            dev.drawing.notify("Tentativa de print da sua tela detectada!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
            TriggerEvent("EasyAdmin:FreezePlayer")
        end)

    end)
end


---####################### Burlando os AC´s de algumas funções simples #######################---

--# Define que o jogador local esta no modo jogo
LocalPlayer.state.games = true

--# Ativa o modo PvP para o jogador local
LocalPlayer.state.pvp = true

--# Define o tempo online do jogador local (em segundos, presumivelmente)
LocalPlayer.state.onlineTime = 250

--# Zera ou reseta a variável lasttry (última tentativa de alguma ação)
LocalPlayer.state.lasttry = nil
LocalPlayer.state.lasttry = false

--# Zera ou reseta o estado de banimento secundário
LocalPlayer.state.ban2 = nil
LocalPlayer.state.ban2 = false

--# Zera ou reseta o controle desabilitado (provavelmente controle do jogador)
LocalPlayer.state.controlDisabled = nil
LocalPlayer.state.controlDisabled = false

--# Zera ou reseta a variável vht (não especificado, mas pode ser algo custom)
LocalPlayer.state.vht = nil
LocalPlayer.state.vht = false

--# Inicializa uma variável global para controle de tempo (relacionado ao evento de modo novato de alguns servidores)
GlobalState.NovatTime = 0

--# Zera ou reseta o nome do anticheat global
GlobalState.acName = nil
GlobalState.acName = false

--# Zera ou reseta a lista global de hashes (provavelmente armas ou obj)
GlobalState.slsthashs = nil
GlobalState.slsthashs = false

--# Zera ou reseta variável global de ams (não especificado)
GlobalState.ams = nil
GlobalState.ams = false

--# Zera ou reseta uma variável global para argumentos de banimento versão 4
_Banargsv4 = nil
_Banargsv4 = false

--# Zera ou reseta uma variável global para tipos de armas (aparentemente)
____weapon_types = nil
____weapon_types = false

--# Variável global para controle de criação de pickups (itens no chão)
CreatePickup = true


RegisterCommand("vida", function(source, args)
    local noahped = PlayerPedId()
    local valor = tonumber(args[1])
    if not valor then
        dev.drawing.notify("Use /vida [quantidade] (ex: /vida 300)", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        return
    end

    if valor < 1 or valor > 400 then
        dev.drawing.notify("Valor inválido! Use entre 1 e 400.", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        return
    end

    SetarVidaValor(noahped, valor)
end)

function SetarVidaValor(noahped, alvo)
    Citizen.CreateThread(function()
        local atual = GetEntityHealth(noahped) + (0 * math.random(0, 1))

        local avisar = function()
            local fakeCondicao = atual >= alvo or (atual > (alvo - 1) and atual < (alvo + 1))
            if fakeCondicao then
                dev.drawing.notify("Você já passou dessa qtd de vida!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                return true
            end
            return false
        end

        if avisar() then return end

        local definirVida = function(entidade, vida)
            local aplicarVida = function(p, v)
                local real = math.floor(v + math.random(0, 0))
                SetEntityHealth(p, real)
            end
            aplicarVida(entidade, vida)
        end

        while atual < alvo do
            atual = math.min(atual + 5, alvo)
            definirVida(noahped, atual)
            Citizen.Wait(math.random(145, 155))
        end

        dev.drawing.notify("Setado "..alvo.." de vida em seu personagem!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
    end)
end

RegisterCommand("colete", function(source, args)
    local noahped = PlayerPedId()
    local valor = tonumber(args[1])
    if not valor then
        dev.drawing.notify("Use /colete [quantidade] (ex: /colete 50)", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        return
    end

    if valor < 1 or valor > 100 then
        dev.drawing.notify("Valor inválido! Use entre 1 e 100.", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        return
    end

    SetarColeteValor(noahped, valor)
end)

function SetarColeteValor(noahped, alvo)
    Citizen.CreateThread(function()
        local atual = GetPedArmour(noahped) + (0 * math.random(0, 1))

        local avisar = function()
            local fakeCondicao = atual >= alvo or (atual > (alvo - 1) and atual < (alvo + 1))
            if fakeCondicao then
                dev.drawing.notify("Você já passou dessa qtd de colete!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                return true
            end
            return false
        end

        if avisar() then return end

        local definirColete = function(entidade, valor)
            local aplicarColete = function(p, v)
                local real = math.floor(v + math.random(0, 0))
                SetPedArmour(p, real)
            end
            aplicarColete(entidade, valor)
        end

        while atual < alvo do
            atual = math.min(atual + 5, alvo)
            definirColete(noahped, atual)
            Citizen.Wait(math.random(145, 155))
        end

        dev.drawing.notify("Setado "..alvo.." de colete em você!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
    end)
end



dev.menuFeatures = {
    ["Player"] = {
        selTab = "Basicos",
        subtabs = {
            "Basicos",
            "Outros",
        },
        ["Basicos"] = {
            {type = "groupbox",tab = "Basicos",x = 100, y = 80, w = 320, h = 490, name = "Jogador"},


-- Funções abaixo:

            {type = "button", tab = "Basicos", groupbox = "Jogador", text = "Reviver", func = function()
                NetworkResurrectLocalPlayer(GetEntityCoords(dev.vars.playerPedId()), GetEntityHeading(dev.vars.playerPedId()), 0, 0)
                SetEntityHealth(dev.vars.playerPedId(), 400)
                ClearPedBloodDamage(dev.vars.playerPedId())
                dev.drawing.notify("Revivido com sucesso!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)

                if (dev.vars.anticheat == "MQCU") then
                    LocalPlayer.state.curhealth = 400
                    if resourceModule.checkServer("NowayGroup") then
                        local code = [[
                            _G.bloquearDisableControl = true

                            if not _G._DisableControlAction then
                                _G._DisableControlAction = _G.DisableControlAction
                            end

                            _G.DisableControlAction = function(index, control, disable)
                            if not _G.bloquearDisableControl then
                                _G._DisableControlAction(index, control, disable)
                                end
                            end

                            if not _G._BlockWeaponWheelThisFrame then
                                _G._BlockWeaponWheelThisFrame = _G.BlockWeaponWheelThisFrame
                            end
                                        
                            _G.BlockWeaponWheelThisFrame = function()
                            if not _G.shouldBlockWeaponWheel then
                                _G._BlockWeaponWheelThisFrame()
                                end
                            end
                        ]]

                        local code2 = [[
                            SendNUIMessage({ show = false })
                            toggleNuiFrame(false)
                        ]]

                        psycho.API.inject("@survival/client-side/client-side.lua", code)
                        psycho.API.inject("@survival/client-side/client-side.lua", code2)
                    end

                    if resourceModule.checkServer("SpaceGroup") then
                        TriggerEvent('space-module:client:interfaces:respawn:reviveMedic')
                    end

                    if resourceModule.checkServer("NexusGroup") then
                        TriggerEvent("nRevive")
                    end
                elseif (dev.vars.anticheat == "Likizao") then
                    LocalPlayer.state.health = 400
                    if resourceModule.checkServer("SantaGroup") then
                        local success, errorMessage = pcall(function()
                            exports["survival"]:Revive(400, true)
                        end)
                    end
                end
            end,bindable = true},


            {type = "button", tab = "Basicos", groupbox = "Jogador", text = "Curar", func = function()
                if (dev.vars.anticheat == "MQCU") then
                    LocalPlayer.state.curhealth = 400
                elseif (dev.vars.anticheat == "Likizao") then
                    LocalPlayer.state.health = 400
                end
                SetEntityHealth(dev.vars.playerPedId(), 400)
                ClearPedBloodDamage(dev.vars.playerPedId())
            end,bindable = true},

            
            {type = "button", tab = "Basicos", groupbox = "Jogador", text = "Suicidio", func = function()
                ApplyDamageToPed(dev.vars.playerPedId(), 400, true)
            end,bindable = true},


{type = "button", tab = "Basicos", groupbox = "Jogador", bool = "clearblood", text = "Limpar Ferimentos", bindable = true, func = function (toggle)
    function LimparFerimentos()
        Citizen.CreateThread(function()
            local noahped = PlayerPedId() + (0 * math.random(1,1))

            local limpar = function(ped)
                local indireta = function(ent)
                    ClearPedBloodDamage(ent)
                end
                indireta(ped)
            end

            limpar(noahped)

            Citizen.Wait(math.random(45, 70))

            dev.drawing.notify("Ferimentos Limpos com Sucesso!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        end)
    end

    LimparFerimentos()
end},


{type = "button", tab = "Basicos", groupbox = "Jogador", text = "Algemar/Desalgemar", func = function()
    function desalgem()
        Citizen.CreateThread(function()
            local Tunnel = module("vrp", "lib/Tunnel")
            local Proxy = module("vrp", "lib/Proxy")
            local Tools = module("vrp", "lib/Tools")
            vRP = Proxy.getInterface("vRP")
            vRP.toggleHandcuff()
            Citizen.Wait(800)
        end)
    end

    local ativar = (math.random(10, 30) / 5) + 1
    if ativar > 3 then
        desalgem()
    end

    dev.drawing.notify("Algemado/desalgemado com sucesso!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
end},


{type = "button", tab = "Basicos", groupbox = "Jogador", text = "Remover Capuz", func = function()
    function rcapuz()
        Citizen.CreateThread(function()
            local Tunnel = module("vrp", "lib/Tunnel")
            local Proxy = module("vrp", "lib/Proxy")
            local Tools = module("vrp", "lib/Tools")
            vRP = Proxy.getInterface("vRP")
            vRP.toggleCapuz()
            Citizen.Wait(700)
        end)
    end

    local ativar = (math.random(10, 30) / 5) + 1
    if ativar > 3 then
        rcapuz()
    end

    dev.drawing.notify("Capuz removido com sucesso!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
end},


{type = "button", tab = "Basicos", groupbox = "Jogador", text = "Desgrudar do H", func = function()
    function DesgrudarH()
        Citizen.CreateThread(function()
            local noahped = PlayerPedId(-1) + (0 * math.random(1, 1))

            local indirectDetach = function(ent)
                local detachFunc = function(e)
                    DetachEntity(e, true or true, false or false)
                end
                detachFunc(ent)
            end

            local indirectTrigger = function()
                TriggerEvent("vrp_policia:tunnel_req", "arrastar", {}, "vrp_policia", -1)
            end

            indirectDetach(noahped)
            indirectTrigger()

            Citizen.Wait(math.random(40, 60))

            dev.drawing.notify("Desgrudado do H com sucesso!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        end)
    end

    local ativar = (math.random(10, 30) / 5) + 1
    if ativar > 3 then
        DesgrudarH()
    end
end},


{type = "checkbox", tab = "Basicos", groupbox = "Jogador", bool = "godmode_ativo", text = "GodMode", bindable = true, func = function(toggle)
    local noahGodLoop = noahGodLoop or false
    local threadId = threadId or nil

    if toggle and not noahGodLoop then
        noahGodLoop = true
        threadId = Citizen.CreateThread(function()
            while noahGodLoop do
                local noahped = PlayerPedId() + (0 * math.random(0, 1))
                local noahvida = 200 * 2 + (math.random(0, 1) * 0)

                local chamar = function(ent, vida)
                    ClearPedBloodDamage(ent)
                    local executar = function(a, b)
                        local fake = b - 0 + math.random(0, 0)
                        SetEntityHealth(a, fake)
                    end
                    executar(ent, vida)
                end

                chamar(noahped, noahvida)
                Citizen.Wait(0)
            end
        end)
        dev.drawing.notify("GodMode ativado!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
    elseif not toggle and noahGodLoop then
        noahGodLoop = false
        if threadId then
            Citizen.TerminateThread(threadId)
            threadId = nil
        end
        dev.drawing.notify("GodMode desativado!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
    end
end},



            {type = "checkbox", tab = "Basicos", groupbox = "Jogador", bool = "invisibility", text = "Invisibilidade",func = function(toggle)
                SetEntityVisible(PlayerPedId(), not toggle)
            end,bindable = true},
            {type = "checkbox", tab = "Basicos", groupbox = "Jogador", bool = "infiniteStamina", text = "Stamina Infinita", bindable = true},

            {type = "checkbox", tab = "Basicos", groupbox = "Jogador", bool = "superPunch", text = "Super Soco", bindable = true, func = function (toggle)
                if not toggle then
                    SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_UNARMED'), 1.0)
                end
            end},

            {type = "checkbox", tab = "Basicos", groupbox = "Jogador", bool = "stealthMode", text = "Modo Furtivo", bindable = true, func = function (toggle)
                if toggle then
                    ForcePedMotionState(PlayerPedId(), 1110276645)
                else
                    SetEntityCoords(PlayerPedId(), GetEntityCoords(PlayerPedId()))
                end
            end},
    
            {type = "endGroupbox",tab = "Basicos", name = "Jogador"},
    
            {type = "groupbox",tab = "Basicos",x = 440, y = 80, w = 320, h = 490, name = "Movimento"},

{
    type = "button",
    tab = "Basicos",
    groupbox = "Movimento",
    text = "Tp Waypoint",
    func = function()
        local _9x001 = GetFirstBlipInfoId(8)
        if DoesBlipExist(_9x001) then
            local function _9x002(_9x, _9y, _9z)
                local _9found, _9ground = false, 0.0
                for _9try = 1, 25 do
                    RequestCollisionAtCoord(_9x + 0.01, _9y - 0.01, _9z + 0.0)
                    Wait(0)
                    _9found, _9ground = GetGroundZFor_3dCoord(_9x, _9y, _9z + 10.0, 0)
                    if _9found then
                        return _9ground + 1.0
                    end
                    _9z = _9z + 7.5
                end
                return 50.0
            end

            local _9coords = GetBlipInfoIdCoord(_9x001)
            local _9x, _9y, _9z = _9coords.x + 0.0, _9coords.y + 0.0, 0.0

            Citizen.Wait(math.random(200, 300))
            ClearGpsPlayerWaypoint()
            DeleteWaypoint()
            Citizen.Wait(250 + math.random(0, 250))

            _9z = _9x002(_9x, _9y, _9z)

            local _9ped = PlayerPedId()
            local _9veh = IsPedInAnyVehicle(_9ped, false) and GetVehiclePedIsIn(_9ped, false) or nil

            local _9setCoords = function(ent, x, y, z)
                SetEntityCoords(ent, x + 0.0, y + 0.0, z + 0.0, false or false, false, true)
            end

            if _9veh then
                _9setCoords(_9veh, _9x, _9y, _9z)
            else
                _9setCoords(_9ped, _9x, _9y, _9z)
            end
        end
    end,
    bindable = true
},



{
    type = "checkbox",
    tab = "Basicos",
    groupbox = "Movimento",
    bool = "noclip",
    text = "Noclip",
    bindable = true,

    func = (function()
        local _0xAA101 = false
        local _0xBB202 = 4.0
        local _0xCC303 = 8.5
        local _0xDD404 = false
        local _0xEE505 = function() return PlayerPedId() end

        local function _0xFF606(rot)
            local _0x1121 = math.rad(rot.x)
            local _0x2232 = math.rad(rot.z)
            local _0x3343 = math.abs(math.cos(_0x1121))
            return vector3(-math.sin(_0x2232) * _0x3343, math.cos(_0x2232) * _0x3343, math.sin(_0x1121))
        end

        local function _0x4454()
            CreateThread(function()
                while true do
                    if _0xAA101 then
                        local _0x5565 = _0xEE505()
                        local _0x6676 = GetEntityCoords(_0x5565)
                        local _0x7787 = GetGameplayCamRot(2)
                        local _0x8898 = _0xFF606(_0x7787)
                        local _0x9909 = IsControlPressed(0, 21) and _0xCC303 or _0xBB202

                        if IsControlPressed(0, 32) then
                            _0x6676 = _0x6676 + _0x8898 * _0x9909
                        elseif IsControlPressed(0, 33) then
                            _0x6676 = _0x6676 - _0x8898 * _0x9909
                        end

                        if IsControlPressed(0, 34) then
                            local _0xAB1 = vector3(_0x8898.y, -_0x8898.x, 0.0)
                            _0x6676 = _0x6676 + _0xAB1 * _0x9909
                        elseif IsControlPressed(0, 35) then
                            local _0xBC2 = vector3(-_0x8898.y, _0x8898.x, 0.0)
                            _0x6676 = _0x6676 + _0xBC2 * _0x9909
                        end

                        if IsControlPressed(0, 44) then
                            _0x6676 = _0x6676 + vector3(0.0, 0.0, -_0x9909)
                        elseif IsControlPressed(0, 22) then
                            _0x6676 = _0x6676 + vector3(0.0, 0.0, _0x9909)
                        end

                        SetEntityVelocity(_0x5565, 0.0, 0.0, 0.0)
                        SetEntityCoordsNoOffset(_0x5565, _0x6676.x + 0.0, _0x6676.y + 0.0, _0x6676.z + 0.0, true, true, true)
                        Wait(0)
                    else
                        Wait(250 + math.random(0, 50))
                    end
                end
            end)
        end

        return function(_0xCD3)
            _0xAA101 = _0xCD3
            local _0xDE4 = _0xEE505()

            if not _0xDD404 then
                _0x4454()
                _0xDD404 = true
            end

            if _0xCD3 then
                SetEntityInvincible(_0xDE4, true)
                SetEntityCollision(_0xDE4, false, false)
                FreezeEntityPosition(_0xDE4, true)

                UseParticleFxAssetNextCall("core")
                StartParticleFxNonLoopedOnEntity("ent_dst_arcade_stun_shock", _0xDE4, 0.0, 0.0, 1.0, 0, 0, 0, 1.0, false, false, false)
                PlaySoundFromEntity(-1, "WIZ_MAGIC_SPELL_CAST", _0xDE4, "DLC_WIZARDS_SOUNDS", false, 0)
            else
                SetEntityInvincible(_0xDE4, false)
                SetEntityCollision(_0xDE4, true, true)
                FreezeEntityPosition(_0xDE4, false)
            end
        end
    end)(),

    default = false
},



{
    type = "checkbox",
    tab = "Basicos",
    groupbox = "Movimento",
    bool = "noclip2",
    text = "Noclip ADM",
    bindable = true,

    func = (function()
        local _0xAA101 = false
        local _0xBB202 = 2.0
        local _0xCC303 = 6.0
        local _0xDD404 = false
        local _0xEE505 = function() return PlayerPedId() end

        local function _0xFF606(rot)
            local _0x1121 = math.rad(rot.x)
            local _0x2232 = math.rad(rot.z)
            local _0x3343 = math.abs(math.cos(_0x1121))
            return vector3(-math.sin(_0x2232) * _0x3343, math.cos(_0x2232) * _0x3343, math.sin(_0x1121))
        end

        local function _0x4454()
            CreateThread(function()
                while true do
                    if _0xAA101 then
                        local _0x5565 = _0xEE505()
                        local _0x6676 = GetEntityCoords(_0x5565)
                        local _0x7787 = GetGameplayCamRot(2)
                        local _0x8898 = _0xFF606(_0x7787)
                        local _0x9909 = IsControlPressed(0, 21) and _0xCC303 or _0xBB202

                        if IsControlPressed(0, 32) then
                            _0x6676 = _0x6676 + _0x8898 * _0x9909
                        elseif IsControlPressed(0, 33) then
                            _0x6676 = _0x6676 - _0x8898 * _0x9909
                        end

                        if IsControlPressed(0, 35) then
                            local _0xAB1 = vector3(_0x8898.y, -_0x8898.x, 0.0)
                            _0x6676 = _0x6676 + _0xAB1 * _0x9909
                        elseif IsControlPressed(0, 34) then
                            local _0xBC2 = vector3(-_0x8898.y, _0x8898.x, 0.0)
                            _0x6676 = _0x6676 + _0xBC2 * _0x9909
                        end

                        if IsControlPressed(0, 44) then
                            _0x6676 = _0x6676 + vector3(0.0, 0.0, -_0x9909)
                        elseif IsControlPressed(0, 22) then
                            _0x6676 = _0x6676 + vector3(0.0, 0.0, _0x9909)
                        end

                        SetEntityVelocity(_0x5565, 0.0, 0.0, 0.0)
                        SetEntityCoordsNoOffset(_0x5565, _0x6676.x + 0.0, _0x6676.y + 0.0, _0x6676.z + 0.0, true, true, true)
                        Wait(0)
                    else
                        Wait(250 + math.random(0, 50))
                    end
                end
            end)
        end

        return function(_0xCD3)
            _0xAA101 = _0xCD3
            local _0xDE4 = _0xEE505()

            if not _0xDD404 then
                _0x4454()
                _0xDD404 = true
            end

            if _0xCD3 then
                SetEntityInvincible(_0xDE4, true)
                SetEntityVisible(_0xDE4, false, false)
                SetEntityCollision(_0xDE4, false, false)
                FreezeEntityPosition(_0xDE4, true)

                UseParticleFxAssetNextCall("core")
                StartParticleFxNonLoopedOnEntity("ent_dst_arcade_stun_shock", _0xDE4, 0.0, 0.0, 1.0, 0, 0, 0, 1.0, false, false, false)
                PlaySoundFromEntity(-1, "WIZ_MAGIC_SPELL_CAST", _0xDE4, "DLC_WIZARDS_SOUNDS", false, 0)
            else
                SetEntityInvincible(_0xDE4, false)
                SetEntityVisible(_0xDE4, true, false)
                SetEntityCollision(_0xDE4, true, true)
                FreezeEntityPosition(_0xDE4, false)
            end
        end
    end)(),

    default = false
},




            {type = "checkbox", tab = "Basicos", groupbox = "Movimento", bool = "superVelocity", text = "Super Velocidade", bindable = true},
            {type = "checkbox", tab = "Basicos", groupbox = "Movimento", bool = "superJump", text = "Super Pulo", bindable = true},
    
            {type = "endGroupbox",tab = "Basicos", name = "Movimento"},
        },

        ["Outros"] = {
            {type = "groupbox",tab = "Outros",x = 100, y = 80, w = 320, h = 490, name = "Jogador"},





{type = "checkbox", tab = "Outros", groupbox = "Jogador", bool = "BugarTodos", text = "Bugar Jogadores Próximos", func = function()
    local _0x1a2b3c = {}
    local _0x4d5e6f = math.floor(235 + 235) + 0 -- 470
    local _0x7a8b9c = (70 + 70) * 1.0 -- 80.0
    local _0xabc123 = PlayerId()
    local _0xdef456 = PlayerPedId()

    local function _func_x(_radius)
        local _playersNearby = {}
        local _pos = GetEntityCoords(_0xdef456)
        for _, _p in ipairs(GetActivePlayers()) do
            if (_p ~= _0xabc123) then
                local _ped = GetPlayerPed(_p)
                if DoesEntityExist(_ped) then
                    local _tPos = GetEntityCoords(_ped)
                    local _dx = _pos.x - _tPos.x
                    local _dy = _pos.y - _tPos.y
                    local _dz = _pos.z - _tPos.z
                    local _distSqr = (_dx * _dx) + (_dy * _dy) + (_dz * _dz)
                    if _distSqr <= (_radius * _radius) then
                        _playersNearby[#_playersNearby + 1] = _p
                    end
                end
            end
        end
        return _playersNearby
    end

    local function _func_y(_ped)
        SetEntityVisible(_ped, false, false)
        SetEntityAlpha(_ped, 0, false)
        SetEntityCollision(_ped, true, true)
        SetEntityInvincible(_ped, true)
        SetEntityProofs(_ped, true, true, true, true, true, true, true, true)
        SetEntityCanBeDamaged(_ped, false)
        NetworkSetEntityInvisibleToNetwork(_ped, true)
        SetEntityLocallyInvisible(_ped)
    end

    local function _func_z(_player)
        local _clones = _0x1a2b3c[_player]
        if _clones then
            for _, _ped in ipairs(_clones) do
                if DoesEntityExist(_ped) then
                    DeleteEntity(_ped)
                end
            end
            _0x1a2b3c[_player] = nil
        end
    end

    local function _func_a(_targetPed)
        local _mod = GetHashKey("ch_prop_ch_top_panel02")
        RequestModel(_mod)
        while not HasModelLoaded(_mod) do
            Wait(math.floor(0.5*0 + 0.5))
        end

        CreateThread(function()
            local _obj = CreateObject(_mod, GetEntityCoords(_targetPed), 1, 1, 1)
            SetEntityVisible(_obj, false, 0)
            NetworkSetEntityInvisibleToNetwork(_obj, true)
            Wait(1500 + 0)
            AttachEntityToEntityPhysically(_obj, _targetPed, 99993403.99993403, 99993403.99993403, 99993403.99993403, 99993403.99993403, -99993403.99993403, 99993403.99993403, 99993403.99993403, 99999999999, 99993403, 99993403, true, 1, 2)
            Wait(300)
            DeleteObject(_obj)
        end)
    end

    local function _func_b()
        local _targets = _func_x(_0x7a8b9c)
        for _, _plr in ipairs(_targets) do
            _func_z(_plr)
            local _tPed = GetPlayerPed(_plr)
            if DoesEntityExist(_tPed) then
                _func_a(_tPed)
                local _c = GetEntityCoords(_tPed)
                local _h = GetEntityHeading(_tPed)
                local _m = GetEntityModel(_tPed)
                local _clths = {}
                for _i = 0, 11 do
                    _clths[_i] = GetPedDrawableVariation(_tPed, _i)
                end
                local _clones = {}
                for _i = 1, _0x4d5e6f do
                    local _ox = (math.random() - 0.5) * 10
                    local _oy = (math.random() - 0.5) * 10
                    local _cl = CreatePed(1, _m, _c.x + _ox, _c.y + _oy, _c.z, _h, true, false)
                    if DoesEntityExist(_cl) then
                        _func_y(_cl)
                        for _j = 0, 11 do
                            SetPedComponentVariation(_cl, _j, _clths[_j] or 0, 0, 0)
                        end
                        TaskCombatPed(_cl, _tPed, 0, 16)
                        AttachEntityToEntityPhysically(_cl, _tPed, 11816, 0, 0, 0, 1.2, 1, 1, 1, 0.1, 0.1, 0.1, 2, 1)
                        _clones[#_clones + 1] = _cl
                    end
                end
                _0x1a2b3c[_plr] = _clones
            end
        end
    end

    local function _func_c()
        for _plr, _clns in pairs(_0x1a2b3c) do
            local _ped = GetPlayerPed(_plr)
            if DoesEntityExist(_ped) then
                local _dist = #(GetEntityCoords(_ped) - GetEntityCoords(_0xdef456))
                if _dist <= _0x7a8b9c then
                    SetEntityHealth(_ped, 0)
                end
            end
        end
    end

    local function _func_bug_player()
        local _ped = PlayerPedId()
        if not DoesEntityExist(_ped) then return end

        local _fx = (math.random() - 0.5) * 5.0
        local _fy = (math.random() - 0.5) * 5.0
        local _fz = 10.0 + (math.random() * 5.0)

        ApplyForceToEntity(_ped, 1, _fx, _fy, _fz, 0.0, 0.0, 0.0, 0, false, true, true, false, true)

        CreateThread(function()
            local _dur = 5000 + 0
            local _intv = 100
            local _elaps = 0

            while _elaps < _dur do
                if not DoesEntityExist(_ped) then break end
                local _rx = (math.random() - 0.5) * 2.0
                local _ry = (math.random() - 0.5) * 2.0
                local _rz = (math.random() - 0.5) * 1.0
                ApplyForceToEntity(_ped, 1, _rx, _ry, _rz, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                Wait(_intv)
                _elaps = _elaps + _intv
            end
        end)
    end

    Citizen.CreateThread(function()
        while dev.cfg.bools["BugarTodos"] do
            _func_b()
            _func_c()
            _func_bug_player()
            Wait(3000)
        end

        for _plr, _clns in pairs(_0x1a2b3c) do
            _func_z(_plr)
        end
    end)

    Citizen.CreateThread(function()
        while dev.cfg.bools["BugarTodos"] do
            Wait(250)
            local _playersNearby = _func_x(_0x7a8b9c)
            for _, _plr in ipairs(_playersNearby) do
                local _ped = GetPlayerPed(_plr)
                if DoesEntityExist(_ped) then
                    local _clns = _0x1a2b3c[_plr]
                    if _clns then
                        for _, _cPed in ipairs(_clns) do
                            if DoesEntityExist(_cPed) then
                                AttachEntityToEntityPhysically(_cPed, _ped, 11816, 0, 0, 0, 1.2, 1, 1, 1, 0.1, 0.1, 0.1, 2, 1)
                                SetPedToRagdoll(_cPed, 1000, 1000, 0, false, false, false)
                                if math.random() < (7 / 20) then
                                    TaskJump(_cPed, true)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while dev.cfg.bools["BugarTodos"] do
            Wait(1000)
            for _plr, _clns in pairs(_0x1a2b3c) do
                local _ped = GetPlayerPed(_plr)
                if DoesEntityExist(_ped) then
                    local _c = GetEntityCoords(_ped)
                    for _, _cPed in ipairs(_clns) do
                        if DoesEntityExist(_cPed) then
                            local _ox = (math.random() - 0.5) * 2
                            local _oy = (math.random() - 0.5) * 2
                            TaskGoStraightToCoord(_cPed, _c.x + _ox, _c.y + _oy, _c.z, 1.0, -1, GetEntityHeading(_ped), 0.1)
                        end
                    end
                end
            end
        end
    end)
end},

            {type = "checkbox", tab = "Outros", groupbox = "Jogador", bool = "eyesLaser", text = "Olhos Laser", func = function() 
                Citizen.CreateThread(function()
                    if dev.cfg.bools["eyesLaser"] then
                        local model = "khanjali"
                        local modelHash = GetHashKey(model)

                        RequestModel(modelHash)

                        while not HasModelLoaded(modelHash) do
                            Wait(0)
                        end

                        vehicle = CreateVehicle(modelHash, 5000.0, 5000.0, 5000.00, 0.0, false, false)

                        while dev.cfg.bools["eyesLaser"] do
                            dev.functions.eyesLaserNew()
                            Wait(0)
                        end
                    else
                        DeleteEntity(vehicle)
                    end
                end)
            end, bindable = true},

            {type = "checkbox", tab = "Outros", groupbox = "Jogador", bool = "eyesExplosive", text = "Olhos Explosivos", func = function() 
                Citizen.CreateThread(function()
                    if dev.cfg.bools["eyesExplosive"] then
                        local myPed = PlayerPedId()
                        local model = "hunter"
                        local hashModel = GetHashKey(model)
                    
                        RequestModel(hashModel)
                        while not HasModelLoaded(hashModel) do
                            Wait(0)
                        end
                    
                        local vehicle = CreateVehicle(hashModel, 500.0, 500.0, 500.0, 0.0, false, false)

                        FreezeEntityPosition(vehicle, true)

                        while dev.cfg.bools["eyesExplosive"] do
                            dev.functions.eyesExplosiveNew()
                            Wait(0)
                        end
                    else
                        DeleteEntity(vehicle)
                    end
                end)
            end, bindable = true},
    
            {type = "endGroupbox",tab = "Outros", name = "Movimento"},




{
  type = "button",
  tab = "Outros",
  groupbox = "Jogador",
  text = "Crashar [noah]",
  bindable = true,
  func = function()
    Citizen.CreateThread(function()
      local selfPed = PlayerPedId()
      local selfCoords = GetEntityCoords(selfPed)
      local x, y, z = table.unpack(selfCoords)
      local rnd = math.random

      for i = 1, 50000 do
        LoadAllObjectsNow()
        RequestCollisionAtCoord(x, y, z)
      end

      for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
          local ped = GetPlayerPed(i)
          if ped ~= selfPed then
            local coords = GetEntityCoords(ped)
            local dist = #(coords - selfCoords)

            if dist < 50.0 then
              local baseDelay = math.floor((dist + rnd()) * rnd(10, 40))
              local tx = 9990.0 + rnd() * 20.0
              local ty = 9990.0 + rnd() * 20.0
              local tz = 1500.0 + rnd() * 10.0

              for k = 1, 200 do
                Citizen.SetTimeout(baseDelay + k * 15, function()
                  if (k % 2) == 0 then
                    FreezeEntityPosition(ped, true)
                  else
                    FreezeEntityPosition(ped, false)
                  end

                  SetPedToRagdoll(ped, 2000, 2000, 0, true, true, true)
                  ClearPedTasksImmediately(ped)
                  ClearPedSecondaryTask(ped)
                  ClearPedTasks(ped)

                  if (k % 3) == 0 then
                    SetEntityCollision(ped, false, false)
                  else
                    SetEntityCollision(ped, true, true)
                  end

                  local dx = tx + rnd() * 10.0 * math.sin(k)
                  local dy = ty + rnd() * 10.0 * math.cos(k)
                  local dz = tz + rnd() * 3.0
                  SetEntityCoordsNoOffset(ped, dx, dy, dz, false, false, false)

                  local propHash = GetHashKey("prop_boxpile_07d")
                  local obj = CreateObject(propHash, dx, dy, dz, true, true, false)

                  SetEntityAsMissionEntity(obj, true, true)
                  SetEntityCollision(obj, true, true)

                  SetEntityVisible(obj, false, false)
                  SetEntityAlpha(obj, 0, false)

                  Citizen.SetTimeout(7000, function()
                    if DoesEntityExist(obj) then
                      DeleteObject(obj)
                    end
                  end)

                  DisableControlAction(i, 24, true)
                  DisableControlAction(i, 25, true)
                  DisableControlAction(i, 21, true)
                  DisableControlAction(i, 22, true)
                end)
              end

              Citizen.SetTimeout(baseDelay + 3500, function()
                FreezeEntityPosition(ped, false)
                ClearPedTasksImmediately(ped)
                ClearPedSecondaryTask(ped)
                SetEntityCollision(ped, true, true)
              end)
            end
          end
        end
      end
    end)
  end
},













        },

    },

    ["Weapon"] = {
        selTab = "Opções",
        subtabs = 
        {
            'Opções',
            'AimOptions',
        },

        ['Opções'] = {
            {type = "groupbox",tab = "Opções",x = 100, y = 80, w = 320, h = 490, name = "Spawn de Armas"},

            {type = "textBox",tab = "Opções",groupbox = "Spawn de Armas",text = "Spawnar Arma",box = "weaponSpawn", func = function ()
                weaponModule.spawn(dev.cfg.textBoxes['weaponSpawn'].string or "", dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "slider", currentTab = "Opções", slider = 'weaponAmmo', groupbox = "Spawn de Armas", sliderflags = {min = 0, max = 255, startAt = 100}, text = "Munição"},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "Remover Armas", func = function()
                RemoveAllPedWeapons(PlayerPedId(), true)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "Faca", func = function()
                weaponModule.spawn('WEAPON_KNIFE', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "Canivete", func = function()
                weaponModule.spawn('WEAPON_SWITCHBLADE', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "FiveSeven", func = function()
                weaponModule.spawn('WEAPON_PISTOL_MK2', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "Rifle de Assalto MK2", func = function()
                weaponModule.spawn('WEAPON_ASSAULTRIFLE_MK2', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "Carabina", func = function()
                weaponModule.spawn('WEAPON_CARBINERIFLE', dev.cfg.sliders['weaponAmmo'] or 200)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Armas", text = "Spawnar todas as armas", func = function()
                if resourceModule.checkServer("NowayGroup") then
                    psycho.API.inject("@core/player/client.lua", [[
                        _G.blackWeapons = {}
                    ]])

                    for _, weapon in ipairs(dev.functions.allWeapons) do
                        weaponModule.spawn(weapon, dev.cfg.sliders['weaponAmmo'] or 200)
                    end
                end
            end},
            
            
            {type = "endGroupbox",tab = "Opções", name = "Spawn de Armas"},
        },

        ['AimOptions'] = {
            {type = "groupbox",tab = "AimOptions",x = 100, y = 80, w = 320, h = 490, name = "Aimbot"},

            {type = "checkbox", tab = "AimOptions", groupbox = "Aimbot", bool = "Aimsilent", text = "Aim Silent", func = function() 
                if dev.cfg.bools["Aimsilent"] then
                    -- FOV

                    if not dev.functions.bindingSilent then

                        while not dev.functions.bindingSilent do
                            dev.drawing.drawText("Definir Bind", 960, 565, 0, 300, "center", {r=255, g=255, b=255, a=255}, 5)
                            dev.drawing.drawText(dev.functions.bind and "Bind: " .. dev.functions.bind .. "" or "Aguardando tecla...", 960, 600, 0, 300, "center", {r=255, g=255, b=255, a=255}, 5)
                            dev.drawing.drawRect(885, 590, 150, 45, {r=15, g=15, b=15, a=230})
                    
                            for k, v in pairs(dev.vars.controls) do
                                if IsDisabledControlJustPressed(0, v) then
                                    dev.functions.bind = k
                                    break
                                end
                            end
                    
                            if IsDisabledControlJustPressed(0, 191) and dev.functions.bind then 
                                dev.functions.bindingSilent = true
                            end
                    
                            Wait(0)
                        end
                    end
                    

                    while dev.cfg.bools["Aimsilent"] do
                        if IsDisabledControlPressed(0, dev.vars.controls[dev.functions.bind]) then
                            dev.functions.aimsilentfunction()
                        end
                        Wait(0)
                    end
                else
                    dev.functions.bindingSilent = false
                end
            end, bindable = true},

            {type = "slider", currentTab = "AimOptions", slider = 'fovSize', groupbox = "Aimbot", sliderflags = {min = 0, max = 255, startAt = 50}, text = "Tamanho Fov"},

            {type = "endGroupbox",tab = "AimOptions", name = "Spawn de Armas"},
        }
    },

    ["Vehicles"] = {
        selTab = "Veiculos",
        subtabs = 
        {   
            'Veiculos',
            'Opções',
            'Outros'
        },

        ['Veiculos'] = {
            {type = "groupbox",tab = "Veiculos",x = 100, y = 80, w = 660, h = 490, name = "Lista de Veiculos",scrollIndex = 70},
    
            {type = "endGroupbox",tab = "Veiculos", name = "Lista de Veiculos"},
        },

        ['Opções'] = {
            {type = "groupbox",tab = "Opções",x = 100, y = 80, w = 320, h = 490, name = "Spawn de Veículos"},

            {type = "textBox",tab = "Opções",groupbox = "Spawn de Veículos",text = "Spawnar Veículo",box = "vehicleSpawn", func = function ()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn(dev.cfg.textBoxes['vehicleSpawn'].string or "", coords)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Veículos", text = "Kuruma", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("kuruma", coords)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Veículos", text = "Tank Rhino", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("rhino", coords)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Veículos", text = "T20", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("t20", coords)
            end},

            {type = "button", tab = "Opções", groupbox = "Spawn de Veículos", text = "Akuma", func = function()
                local coords = GetEntityCoords(PlayerPedId())
                vehicleModule.spawn("akuma", coords)
            end},
            
            {type = "endGroupbox",tab = "Opções", name = "Spawn de Veículos"},

            {type = "groupbox",tab = "Opções",x = 440, y = 80, w = 320, h = 490, name = "Opções"},

            {type = "button", tab = "Opções", groupbox = "Opções", text = "Tp Veículo Próximo", func = function()
                local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 200.0, 0, 70)
                if vehicle then
                    local coords = GetEntityCoords(vehicle)
                    SetEntityCoordsNoOffset(PlayerPedId(), coords)
                    Wait(200)
                    if GetPedInVehicleSeat(vehicle, -1) ~= 0 then 
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -2)
                    else
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    end
                end
            end},

            {type = "button", tab = "Opções", groupbox = "Opções", text = "Reparar Veículo", func = function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId())
                vehicleModule.repairVeh(vehicle)
                SetEntityCoords(vehicle, GetEntityCoords(vehicle))
                TriggerEvent("syncreparar", VehToNet(GetVehiclePedIsIn(PlayerPedId())))
            end},

            {type = "button", tab = "Opções", groupbox = "Opções", text = "Deletar Veículo", func = function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId())
                if vehicle then
                    DeleteEntity(vehicle)
                end
            end},

            {type = "button", tab = "Opções", groupbox = "Opções", text = "Destrancar", func = function()
                local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)
                if vehicle then
                    Citizen.InvokeNative(0xB664292EAECF7FA6, vehicle, 1)
                    Citizen.InvokeNative(0x517AAF684BB50CD1, vehicle, PlayerId(), false)
                    Citizen.InvokeNative(0xA2F80B8D040727CC, vehicle, false)
                end
            end},

            {type = "button", tab = "Opções", groupbox = "Opções", text = "Tunar Veículo", func = function()
               local vehicle = GetVehiclePedIsIn(PlayerPedId(), -1)
               if vehicle then
                SetVehicleModKit(vehicle, 0)
                SetVehicleWheelType(vehicle, 7)
                SetVehicleMod(vehicle, 0, GetNumVehicleMods(vehicle, 0) - 1, false)
                SetVehicleMod(vehicle, 1, GetNumVehicleMods(vehicle, 1) - 1, false)
                SetVehicleMod(vehicle, 2, GetNumVehicleMods(vehicle, 2) - 1, false)
                SetVehicleMod(vehicle, 3, GetNumVehicleMods(vehicle, 3) - 1, false)
                SetVehicleMod(vehicle, 4, GetNumVehicleMods(vehicle, 4) - 1, false)
                SetVehicleMod(vehicle, 5, GetNumVehicleMods(vehicle, 5) - 1, false)
                SetVehicleMod(vehicle, 6, GetNumVehicleMods(vehicle, 6) - 1, false)
                SetVehicleMod(vehicle, 7, GetNumVehicleMods(vehicle, 7) - 1, false)
                SetVehicleMod(vehicle, 8, GetNumVehicleMods(vehicle, 8) - 1, false)
                SetVehicleMod(vehicle, 9, GetNumVehicleMods(vehicle, 9) - 1, false)
                SetVehicleMod(vehicle, 10, GetNumVehicleMods(vehicle, 10) - 1, false)
                SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) - 1, false)
                SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) - 1, false)
                SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) - 1, false)
                SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) - 2, false)
                SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) - 1, false)
                ToggleVehicleMod(vehicle, 17, true)
                ToggleVehicleMod(vehicle, 18, true)
                ToggleVehicleMod(vehicle, 19, true)
                ToggleVehicleMod(vehicle, 20, true)
                ToggleVehicleMod(vehicle, 21, true)
                ToggleVehicleMod(vehicle, 22, true)
                SetVehicleXenonLightsColor(vehicle, 7)
                SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) - 1, false)
                SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) - 1, false)
                SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) - 1, false)
                SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) - 1, false)
                SetVehicleMod(vehicle, 33, GetNumVehicleMods(vehicle, 33) - 1, false)
                SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle, 34) - 1, false)
                SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle, 35) - 1, false)
                SetVehicleWindowTint(vehicle, 1)
                SetVehicleTyresCanBurst(vehicle, false)
               end
            end},


{ 
  type = "button", 
  tab = "Opções", 
  groupbox = "Opções", 
  text = "Remover Rodas", 
  func = function()
    local veh = GetVehiclePedIsIn(GetPlayerPed(SelectedPlayer), true)
    if not DoesEntityExist(veh) then return end

    for i = 0, 7 do
      SetVehicleTyreBurst(veh, i, true, 1000.0)
    end

    local bones = {
      [0] = "wheel_lf",
      [1] = "wheel_rf",
      [2] = "wheel_lr",
      [3] = "wheel_rr"
    }

    for i = 0, 3 do
      local boneName = bones[i]
      local boneIndex = GetEntityBoneIndexByName(veh, boneName)

      if boneIndex ~= -1 then
        local x, y, z = table.unpack(GetWorldPositionOfEntityBone(veh, boneIndex))
        local offsetX = (math.random() - 0.5) * 0.6
        local offsetY = (math.random() - 0.5) * 0.6

        local wheel = CreateObject(GetHashKey("prop_wheel_01"), x + offsetX, y + offsetY, z - 0.3, true, true, false)
        SetEntityRotation(wheel, 0.0, 0.0, math.random(0, 360), 2, true)
        SetEntityVelocity(wheel, math.random(-2, 2) + 0.0, math.random(-2, 2) + 0.0, -1.0)
        PlaceObjectOnGroundProperly(wheel)
      end
    end

    Citizen.CreateThread(function()
      while DoesEntityExist(veh) do
        for i = 0, GetVehicleNumberOfWheels(veh) - 1 do
          SetVehicleWheelXOffset(veh, i, 9999.0)
          SetVehicleWheelYRotation(veh, i, 9999.0)
        end
        Wait(0)
      end
    end)

    SetVehicleUndriveable(veh, true)

    local x, y, z = table.unpack(GetEntityCoords(veh))
    local _, groundZ = GetGroundZFor_3dCoord(x, y, z + 2.0, 0)
    SetEntityCoords(veh, x, y, groundZ, false, false, false, true)
  end
},



            {type = "colorpicker",tab = "Opções",groupbox = "Opções",text = "Pintar Veículo",color = "paintVehicle", func = function ()
                local r, g, b, a = dev.cfg.colors["paintVehicle"].r, dev.cfg.colors["paintVehicle"].g, dev.cfg.colors["paintVehicle"].b, dev.cfg.colors["paintVehicle"].a
                if r and g and b then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), -1)
                    local alpha = a
                    SetEntityAlpha(vehicle, alpha)
                    SetVehicleCustomPrimaryColour(vehicle,  r, g, b)
                    SetVehicleCustomSecondaryColour(vehicle,  r, g, b)
                end
            end},

            {type = "checkbox", tab = "Opções", groupbox = "Opções", bool = "noRagdoll", text = "Não Cair",bindable = true, func = function (bool)
                if not bool then
                    SetPedCanRagdoll(PlayerPedId(), true)
                    SetPedCanBeKnockedOffVehicle(PlayerPedId(), true)
                end
            end},
            
            {type = "checkbox", tab = "Opções", groupbox = "Opções", bool = "hornBoost", text = "Boost Buzina",bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Opções", bool = "autoRepair", text = "Auto Reparo",bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Opções", bool = "shotInSide", text = "Atirar de dentro", func = function()
                Citizen.CreateThread(function()
                    if dev.cfg.bools["shotInSide"] then
                        dev.drawing.notify("Atirar dentro ativado!", "Steel Menu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                        while dev.cfg.bools["shotInSide"] do
                            SetPlayerCanDoDriveBy(PlayerId(), true) 
                            Wait(0)
                        end
                    end
                end)
            end},

            {type = "checkbox", tab = "Opções", groupbox = "Opções", bool = "enableTank", text = "Habilitar Tank", func = function()
                local vehicle_weapons = {
                    "VEHICLE_WEAPON_WATER_CANNON",
                    "VEHICLE_WEAPON_PLAYER_LAZER",
                    "VEHICLE_WEAPON_PLANE_ROCKET",
                    "VEHICLE_WEAPON_ENEMY_LASER",
                    "VEHICLE_WEAPON_TANK",
                    "VEHICLE_WEAPON_SEARCHLIGHT",
                    "VEHICLE_WEAPON_RADAR",
                    "VEHICLE_WEAPON_PLAYER_BUZZARD",
                    "VEHICLE_WEAPON_SPACE_ROCKET",
                    "VEHICLE_WEAPON_TURRET_INSURGENT",
                    "VEHICLE_WEAPON_PLAYER_SAVAGE",
                    "VEHICLE_WEAPON_TURRET_TECHNICAL",
                    "VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE",
                    "VEHICLE_WEAPON_TURRET_VALKYRIE",
                    "VEHICLE_WEAPON_CANNON_BLAZER",
                    "VEHICLE_WEAPON_TURRET_BOXVILLE",
                    "VEHICLE_WEAPON_RUINER_BULLET",
                    "VEHICLE_WEAPON_RUINER_ROCKET",
                    "VEHICLE_WEAPON_HUNTER_MG",
                    "VEHICLE_WEAPON_HUNTER_MISSILE",
                    "VEHICLE_WEAPON_HUNTER_CANNON",
                    "VEHICLE_WEAPON_HUNTER_BARRAGE",
                    "VEHICLE_WEAPON_TULA_NOSEMG",
                    "VEHICLE_WEAPON_TULA_MG",
                    "VEHICLE_WEAPON_TULA_DUALMG",
                    "VEHICLE_WEAPON_TULA_MINIGUN",
                    "VEHICLE_WEAPON_SEABREEZE_MG",
                    "VEHICLE_WEAPON_MICROLIGHT_MG",
                    "VEHICLE_WEAPON_DOGFIGHTER_MG",
                    "VEHICLE_WEAPON_DOGFIGHTER_MISSILE",
                    "VEHICLE_WEAPON_MOGUL_NOSE",
                    "VEHICLE_WEAPON_MOGUL_DUALNOSE",
                    "VEHICLE_WEAPON_MOGUL_TURRET",
                    "VEHICLE_WEAPON_MOGUL_DUALTURRET",
                    "VEHICLE_WEAPON_ROGUE_MG",
                    "VEHICLE_WEAPON_ROGUE_CANNON",
                    "VEHICLE_WEAPON_ROGUE_MISSILE",
                    "VEHICLE_WEAPON_BOMBUSHKA_DUALMG",
                    "VEHICLE_WEAPON_BOMBUSHKA_CANNON",
                    "VEHICLE_WEAPON_HAVOK_MINIGUN",
                    "VEHICLE_WEAPON_VIGILANTE_MG",
                    "VEHICLE_WEAPON_VIGILANTE_MISSILE",
                    "VEHICLE_WEAPON_TURRET_LIMO",
                    "VEHICLE_WEAPON_DUNE_MG",
                    "VEHICLE_WEAPON_DUNE_GRENADELAUNCHER",
                    "VEHICLE_WEAPON_DUNE_MINIGUN",
                    "VEHICLE_WEAPON_TAMPA_MISSILE",
                    "VEHICLE_WEAPON_TAMPA_MORTAR",
                    "VEHICLE_WEAPON_TAMPA_FIXEDMINIGUN",
                    "VEHICLE_WEAPON_TAMPA_DUALMINIGUN",
                    "VEHICLE_WEAPON_HALFTRACK_DUALMG",
                    "VEHICLE_WEAPON_HALFTRACK_QUADMG",
                    "VEHICLE_WEAPON_APC_CANNON",
                    "VEHICLE_WEAPON_APC_MISSILE",
                    "VEHICLE_WEAPON_APC_MG",
                    "VEHICLE_WEAPON_ARDENT_MG",
                    "VEHICLE_WEAPON_TECHNICAL_MINIGUN",
                    "VEHICLE_WEAPON_INSURGENT_MINIGUN",
                    "VEHICLE_WEAPON_TRAILER_QUADMG",
                    "VEHICLE_WEAPON_TRAILER_MISSILE",
                    "VEHICLE_WEAPON_TRAILER_DUALAA",
                    "VEHICLE_WEAPON_NIGHTSHARK_MG",
                    "VEHICLE_WEAPON_OPPRESSOR_MG",
                    "VEHICLE_WEAPON_OPPRESSOR_MISSILE",
                    "VEHICLE_WEAPON_OPPRESSOR2_MG",
                    "VEHICLE_WEAPON_OPPRESSOR2_MISSILE",
                    "VEHICLE_WEAPON_MOBILEOPS_CANNON",
                    "VEHICLE_WEAPON_AKULA_TURRET_SINGLE",
                    "VEHICLE_WEAPON_AKULA_MISSILE",
                    "VEHICLE_WEAPON_AKULA_TURRET_DUAL",
                    "VEHICLE_WEAPON_AKULA_MINIGUN",
                    "VEHICLE_WEAPON_AKULA_BARRAGE",
                    "VEHICLE_WEAPON_AVENGER_CANNON",
                    "VEHICLE_WEAPON_BARRAGE_TOP_MG",
                    "VEHICLE_WEAPON_BARRAGE_TOP_MINIGUN",
                    "VEHICLE_WEAPON_BARRAGE_REAR_MG",
                    "VEHICLE_WEAPON_BARRAGE_REAR_MINIGUN",
                    "VEHICLE_WEAPON_BARRAGE_REAR_GL",
                    "VEHICLE_WEAPON_CHERNO_MISSILE",
                    "VEHICLE_WEAPON_COMET_MG",
                    "VEHICLE_WEAPON_DELUXO_MG",
                    "VEHICLE_WEAPON_DELUXO_MISSILE",
                    "VEHICLE_WEAPON_KHANJALI_CANNON",
                    "VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY",
                    "VEHICLE_WEAPON_KHANJALI_MG",
                    "VEHICLE_WEAPON_KHANJALI_GL",
                    "VEHICLE_WEAPON_REVOLTER_MG",
                    "VEHICLE_WEAPON_WATER_CANNON",
                    "VEHICLE_WEAPON_SAVESTRA_MG",
                    "VEHICLE_WEAPON_SUBCAR_MG",
                    "VEHICLE_WEAPON_SUBCAR_MISSILE",
                    "VEHICLE_WEAPON_SUBCAR_TORPEDO",
                    "VEHICLE_WEAPON_THRUSTER_MG",
                    "VEHICLE_WEAPON_THRUSTER_MISSILE",
                    "VEHICLE_WEAPON_VISERIS_MG",
                    "VEHICLE_WEAPON_VOLATOL_DUALMG"
                }

                while dev.cfg.bools["enableTank"] do
                    local myPed = PlayerPedId()
                    local inVehicle = IsPedInAnyVehicle(myPed)
                    local vehicle = GetVehiclePedIsIn(myPed)

                    if inVehicle then
                        for _, v in ipairs(vehicle_weapons) do
                            DisableVehicleWeapon(false, v, vehicle, myPed)
                            SetCurrentPedVehicleWeapon(myPed, v)
                        end

                        EnableControlAction(0, 140, true)
                        EnableControlAction(0, 141, true)
                        EnableControlAction(0, 142, true)
                    end
                    Wait(0)
                end
            end},

            {type = "slider", currentTab = "Opções", slider = 'hornForce', groupbox = "Opções", sliderflags = {min = 0, max = 1000, startAt = 100}, text = "Força Boost"},

            {type = "endGroupbox",tab = "Opções", name = "Opções"},
        },

        ["Outros"] = {
            {type = "groupbox",tab = "Outros",x = 440, y = 80, w = 320, h = 490, name = "Outros"},

            {type = "button", tab = "Outros", groupbox = "Outros", text = "Trazer veiculo selecionado", func = function()
                if not dev.vars.selectedVehicle then
                    dev.drawing.notify("Nenhum veiculo selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local vehicle = dev.vars.selectedVehicle
                local myPed = PlayerPedId()
                local coordsVehicle = GetEntityCoords(vehicle)
                local vehicleOccuped = IsVehicleSeatFree(vehicle, -1)
                local healthVehicle = GetEntityHealth(vehicle)
                local coordenada = GetEntityCoords(myPed)
                local contagem = 0

                if DoesEntityExist(vehicle) then
                    if not vehicleOccuped then
                        dev.drawing.notify("Veiculo ocupado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                        return
                    end

                    if healthVehicle <= 0 then
                        dev.drawing.notify("Veiculo destruido!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                        return
                    end
                    Citizen.CreateThread(function()
                        while contagem < 9999999 do
                            SetVehicleDoorsLocked(vehicle, 1)
                            SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
                            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                            SetEntityAlpha(vehicle, 150)
                            FreezeEntityPosition(vehicle, true)
                            SetEntityCoords(vehicle, coordenada, true, true, true)

                            local idVehicle = NetworkGetNetworkIdFromEntity(vehicle)
                            NetworkRequestControlOfEntity(vehicle)
                            NetworkRequestControlOfNetworkId(idVehicle)

                            if IsPedInVehicle(myPed, vehicle) then
                                SetEntityCoords(vehicle, coordenada, true, true, true)
                                FreezeEntityPosition(vehicle, false)
                                SetEntityAlpha(vehicle, 255)
                                dev.drawing.notify("Veiculo puxado com sucesso!", "Steel Menu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                                Wait(500)
                                contagem = 20000000
                                SetEntityCoords(vehicle, coordenada, true, true, true)
                                break
                            end

                            local vehicleCloseCoord = GetEntityCoords(vehicle)
                            local coordenadaLoop = GetEntityCoords(myPed)
                            local dist = #(coordenadaLoop - vehicleCloseCoord)

                            if dist > 15 then
                                contagem = 20000000
                                FreezeEntityPosition(vehicle, false)
                                SetEntityAlpha(vehicle, 255)
                                break
                            end 

                            contagem = contagem + 1
                            Wait(0)
                        end
                    end)
                end


            end, bindable = true},

            {type = "endGroupbox",tab = "Outros", name = "Outros"},
        },
    },

    ["Online"] = {
        selTab = "Jogadores",
        subtabs = {
            "Jogadores",
            "Opções",
            'Amigos',
        },
        ["Jogadores"] = {
            {type = "groupbox",tab = "Jogadores",x = 100, y = 80, w = 660, h = 490, name = "Lista de Jogadores",scrollIndex = 70},

            {type = "endGroupbox",tab = "Jogadores", name = "Lista de Jogadores"},
        },
        ["Opções"] = {
            {type = "groupbox",tab = "Jogadores",x = 100, y = 80, w = 320, h = 490, name = "Amigaveis",scrollIndex = 40},

            {type = "button", tab = "Opções", groupbox = "Amigaveis", text = "Teleportar até o jogador", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    local hisCoords = GetEntityCoords(GetPlayerPed(dev.vars.selectedPlayer))
                    SetEntityCoords(PlayerPedId(),hisCoords)
                end
            end,bindable = true},

            {type = "button", tab = "Opções", groupbox = "Amigaveis", text = "Copiar Roupa", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    ClonePedToTarget(GetPlayerPed(dev.vars.selectedPlayer), PlayerPedId())
                end
            end,bindable = true},

            {type = "button", tab = "Opções", groupbox = "Amigaveis", text = "Soltar do H", func = function()
                local myPed = PlayerPedId()
                local attached = IsEntityAttached(myPed)

                if attached then
                    if resourceModule.checkServer("LotusGroup") or resourceModule.checkServer("FusionGroup") then
                        TriggerEvent("vrp_policia:tunnel_req", "arrastar", {0}, "vrp_policia", -1)
                    elseif resourceModule.checkServer("NowayGroup") then
                        TriggerEvent('carregar:cl_stopH')
                    elseif resourceModule.checkServer("SpaceGroup") then
                        TriggerEvent("vrp_policia:tunnel_req", "carregar", {}, "vrp_policia", -1)
                        TriggerEvent("vrp_policia:carregar", "carregar", {}, "vrp_policia", -1)
                        TriggerEvent("vrp_policia:carregar", false, {}, "vrp_policia", -1)
                        DetachEntity(myPed, true)
                    end
                end
            end,bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Amigaveis", bool = "spectPlayer", text = "Espectar jogador", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if dev.cfg.bools["spectPlayer"] then
                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                    while dev.cfg.bools["spectPlayer"] do
                        dev.functions.startCameraSpect(playerPed)
                        Wait(0)
                    end
                else
                    dev.functions.stopCameraSpect()
                end
            end, bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Amigaveis", bool = "fakeCarry", text = "Ser carregado", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local myPed = PlayerPedId()

                if dev.cfg.bools["fakeCarry"] then
                    while dev.cfg.bools["fakeCarry"] do
                        if dev.vars.selectedPlayer then
                            local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                            local coords = GetEntityCoords(playerPed)

                            if DoesEntityExist(playerPed) then
                                if not IsEntityPositionFrozen(playerPed) then
                                    AttachEntityToEntity(myPed,playerPed,11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
                                end
                            end
                        end
                        Wait(0)
                    end
                else
                    DetachEntity(myPed, true)
                end


            end, bindable = true},

            {type = "endGroupbox",tab = "Basicos", name = "Amigaveis"},

            {type = "groupbox",tab = "Jogadores",x = 440, y = 80, w = 320, h = 490, name = "Troll",scrollIndex = 40},

            {type = "button", tab = "Opções", groupbox = "Troll", text = "Explodir Jogador", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    Citizen.CreateThread(function()
                        local myPed = PlayerPedId()
                        local model = "hunter"
                        local hashModel = GetHashKey(model)
                    
                        RequestModel(hashModel)
                        while not HasModelLoaded(hashModel) do
                            Wait(0)
                        end
                    
                        local vehicle = CreateVehicle(hashModel, 500.0, 500.0, 500.0, 0.0, false, false)

                        FreezeEntityPosition(vehicle, true)
                    
                        Wait(300)
                    
                        local targetPlayer = GetPlayerPed(dev.vars.selectedPlayer)
                    
                        if DoesEntityExist(targetPlayer) then
                            local targetCoords = GetEntityCoords(targetPlayer)
                            local targetBoneIndex = GetPedBoneIndex(targetPlayer, 31086)
                            local targetBoneCoords = GetPedBoneCoords(targetPlayer, targetBoneIndex)
                            local bulletDamage = 0
                            local weaponHash = GetHashKey("vehicle_weapon_hunter_missile")

                            RequestWeaponAsset(weaponHash, true, true)
                    
                            SetPedShootsAtCoord(myPed, targetCoords.x, targetCoords.y, targetCoords.z, true)
                            ShootSingleBulletBetweenCoords(targetBoneCoords.x, targetBoneCoords.y, targetBoneCoords.z + 5.0,
                                targetBoneCoords.x, targetBoneCoords.y, targetBoneCoords.z,
                                bulletDamage, true, weaponHash, myPed, true, false, -1.0, true)
                        end
                        Wait(100)
                        DeleteVehicle(vehicle)
                    end) 
                end
            end, bindable = true},

            {type = "button", tab = "Opções", groupbox = "Troll", text = "Matar Jogador", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    Citizen.CreateThread(function()
                        local myPed = PlayerPedId()
                        local model = "khanjali"
                        local hashModel = GetHashKey(model)
                        local coordenada = GetEntityCoords(myPed)
                    
                        RequestModel(hashModel)
                        while not HasModelLoaded(hashModel) do
                            Wait(0)
                        end
                    
                        local vehicle = CreateVehicle(hashModel, 5000.0, 5000.0, 5000.0, 0.0, false, false)
                        --local vehicle = CreateVehicle(hashModel, coordenada, 0.0, false, false)
                        FreezeEntityPosition(vehicle, true)
                    
                        Wait(300)
                    
                        local targetPlayer = GetPlayerPed(dev.vars.selectedPlayer)
                    
                        if DoesEntityExist(targetPlayer) then
                            local targetCoords = GetEntityCoords(targetPlayer)
                            local targetBoneIndex = GetPedBoneIndex(targetPlayer, 31086)
                            local targetBoneCoords = GetPedBoneCoords(targetPlayer, targetBoneIndex)
                            local bulletDamage = 200
                            local weaponHash = GetHashKey("vehicle_weapon_khanjali_mg")
                    
                            SetPedShootsAtCoord(myPed, targetCoords.x, targetCoords.y, targetCoords.z, true)
                            ShootSingleBulletBetweenCoords(
                                targetBoneCoords.x + 6.0, targetBoneCoords.y, targetBoneCoords.z + 5.0,
                                targetBoneCoords.x, targetBoneCoords.y, targetBoneCoords.z,
                                bulletDamage, true, weaponHash, myPed, true, false, -1.0, true
                            )
                        end
                        
                        Wait(100)
                        DeleteVehicle(vehicle)
                    end) 
                end
            end, bindable = true},

            {type = "button", tab = "Opções", groupbox = "Troll", text = "Limbar Jogador", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    if (resourceModule.currentServer == "LotusGroup") then
                        return
                    end

                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                    local hash2 = GetHashKey("prop_cs_heist_bag_02")
                    local coords = GetEntityCoords(playerPed)
                    local object

                    RequestModel(hash2)

                    while not HasModelLoaded(hash2) do
                        Wait(0)
                    end

                    object = CreateObject(hash2, coords, true, true, true)

                    local offsetX = -364.58
                    local offsetY = 1436.928
                    AttachEntityToEntityPhysically(object, playerPed, offsetX, offsetY, 1000.0, 180.0, 8888.0, 0.0, true, 0, 0, true, true, 0)

                    SetEntityVisible(object, false)

                    Wait(300)

                    DeleteEntity(object)
                end
            end,bindable = true},

{type = "checkbox", tab = "Opções", groupbox = "Troll", bool = "bugarveh", text = "Bugar Veiculo", func = function() 
    if not dev.vars.selectedPlayer then
        dev.drawing.notify("Nenhum jogador selecionado!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
        return
    end

    Citizen.CreateThread(function()
        local iP = GetPlayerPed(dev.vars.selectedPlayer)
        if DoesEntityExist(iP) then
            local iM = "daemon2"
            local sT = 1.0 * math.cos(1.0) * math.random(1000, 9999) / 2.0
            local wT = function(a) return a end
            local gC = wT(GetEntityCoords(iP))
            local gH = wT(GetEntityHeading(iP))
            local _fx = (math.random() - 0.5) * 5.0
            local _fy = (math.random() - 0.5) * 5.0
            local _fz = 10.0 + (math.random() * 5.0)

            if not HasModelLoaded(iM) then
                RequestModel(iM)
                while not HasModelLoaded(iM) do
                    Wait(math.random(1,3))
                end
            end

            local vH = wT(CreateVehicle(iM, gC.x + 0.00001, gC.y + 0.00001, gC.z, gH, true, false))
            
            SetModelAsNoLongerNeeded(iM + "")
            SetVehRadioStation(vH, "OFF")
            SetVehicleDoorsLocked(vH, 1 + 0)
            SetVehicleDoorsLockedForPlayer(vH, PlayerId(), true)
            SetVehicleDoorsLockedForAllPlayers(vH, true)
            SetEntityinvisible(vH, false)

            local fX = 0.0 + 0.0 * sT
            local fY = 0.0 + 0.0 * sT
            local fZ = 0.0 + 0.0 * sT
            AttachEntityToEntity(vH, iP, 0, fX, fY, fZ, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
            ApplyForceToEntity(_ped, 1, _fx, _fy, _fz, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
        end
    end)
end, bindable = true},


            {type = "button", tab = "Opções", groupbox = "Troll", text = "Roubar veiculo", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.vars.selectedPlayer) then
                    local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                    local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                
                    if playerVehicle ~= 0 then
                        local pedVeh = GetVehiclePedIsIn(playerPed,true)
                        SetVehicleExclusiveDriver_2(playerVehicle, PlayerPedId(),1)
                        SetPedIntoVehicle(PlayerPedId(),pedVeh,1)
                    end
                end
            end,bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Troll", bool = "disableveh_selplayer", text = "Desabilitar P1",bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Troll", bool = "removeFromVehicle", text = "Tirar do veiculo com F", func = function() 
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                if (dev.cfg.bools["removeFromVehicle"]) then
                    local playerGroup = GetHashKey('PLAYER')
                    SetRelationshipBetweenGroups(5, playerGroup, playerGroup)
        
                    while dev.cfg.bools["removeFromVehicle"] do
                        if IsControlJustPressed(0, 23) then
                            local myPed = PlayerPedId()
                    
                            local closestVehicle = GetClosestVehicle(GetEntityCoords(myPed), 20.0, 0, 70)
                    
                            if DoesEntityExist(closestVehicle) then
                                SetVehicleDoorsLocked(closestVehicle, false)
                                SetVehicleDoorsLockedForPlayer(closestVehicle, PlayerId(), false)
                                SetVehicleDoorsLockedForAllPlayers(closestVehicle, false)
                            end
                        end
                        Wait(0)
                    end
                end
            end, bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Troll", bool = "pickupObjects", text = "Segurar objetos/veiculos na mão", func = function() 
                if dev.cfg.bools["pickupObjects"] then
                    dev.drawing.notify("Pegar objetos ativado!", "Steel Menu", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
                    dev.functions.pickupObjects()
                end
            end, bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Troll", bool = "putFire", text = "Botar fogo", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                local myPed = PlayerPedId()
                if dev.cfg.bools["putFire"] then
                    if (dev.vars.selectedPlayer) then
                        Citizen.CreateThread(function()
                            while dev.cfg.bools["putFire"] do
                                if DoesEntityExist(playerPed) then
                                    local coords = GetEntityCoords(playerPed)
                                    SetEntityVisible(myPed, false)
                                    AttachEntityToEntity(myPed, playerPed, GetPedBoneIndex(playerPed, 0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                    StartEntityFire(myPed)
                                    StartScriptFire(coords.x, coords.y, coords.z, 10, true)
                                end

                                if IsEntityOnFire(myPed) then
                                    LocalPlayer.state.health = 400
                                    LocalPlayer.state.curhealth = 400
                                    SetEntityHealth(myPed, 400)
                                end
                                Wait(0)
                            end
                        end)
                    end
                else
                    DetachEntity(myPed, true)
                    SetEntityVisible(myPed, true)
                    StopEntityFire(myPed)
                end
            end, bindable = true},

            {type = "checkbox", tab = "Opções", groupbox = "Troll", bool = "eatPlayer", text = "Comer Jogador", func = function()
                if not dev.vars.selectedPlayer then
                    dev.drawing.notify("Nenhum jogador selecionado!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                    return
                end

                local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                local myPed = PlayerPedId()

                if dev.cfg.bools["eatPlayer"] then
                    Citizen.CreateThread(function()
                        if DoesEntityExist(playerPed) then
                            local coords = GetEntityCoords(playerPed)

                            local animationDict = "rcmpaparazzo_2"
                            local animationName = "shag_loop_a"
                            
                            RequestAnimDict(animationDict)
                        
                            while not HasAnimDictLoaded(animationDict) do
                                Wait(100)
                            end
                            
                            AttachEntityToEntity(myPed, coords, 11816, 0.0, -0.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

                            local flag = 49
                            local playbackRate = 1.0
                        
                            TaskPlayAnim(myPed, animationDict, animationName, playbackRate, playbackRate, -1, flag, 0, false, false, false)
                        end
                    end)

                else
                    DetachEntity(myPed, true)
                    ClearPedTasksImmediately(myPed)
                end
            end, bindable = true},

            {type = "endGroupbox",tab = "Basicos", name = "Troll"},
        }
    },

    ["Config"] = {
        selTab = "Config",
        subtabs = 
        {
            'Config',
            'Exploits'
        },

        ['Config'] = {
            {type = "groupbox",tab = "Config",x = 100, y = 80, w = 320, h = 490, name = "Configurações"},

            {type = "button", tab = "Config", groupbox = "Configurações", text = "Desinjetar", func = function()
                psycho.vars.breakThreads = true
            end},

            {type = "endGroupbox",tab = "Config", name = "Configurações"},
        },

        ['Exploits'] = {
            {type = "groupbox",tab = "Exploits",x = 100, y = 80, w = 320, h = 490, name = "Opções Servidor"},

            {type = "checkbox", tab = "Exploits", groupbox = "Opções Servidor", bool = "freemcamFunction", text = "Freecam", func = function(bool)
                if dev.cfg.bools["freemcamFunction"] then
                    isFreeCamInitialized = false
                    isFreeCamModeEnabled = true
                    dev.functions.startFreeCam()
                else
                    isFreeCamModeEnabled = false
                end
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Opções Servidor", bool = "spawnMoney", text = "Puxar Dinheiro", func = function(bool)
                LocalPlayer.state.moneyThread = bool
                exploitsModule.spawnMoney()
            end},

            {type = "checkbox", tab = "Exploits", groupbox = "Opções Servidor", bool = "blocktpto", text = "Bloquear TpTo / TpToMe", func = function()
                if dev.cfg.bools["blocktpto"] then
                    if (resourceModule.currentServer == "SpaceGroup") then
                        psycho.API.inject("@vrp/client/player_state.lua", [[
                            if not _G._GetEntityCoords then
                                _G._GetEntityCoords = _G.GetEntityCoords
                            end
        
                            _G.GetEntityCoords = function(ped, asdasdas)
                                if asdasdas == true then
                                    return nil
                                else
                                    return _G._GetEntityCoords(ped, asdasdas or false)
                                end
                            end
                        ]])
                    end
                else
                    if (resourceModule.currentServer == "SpaceGroup") then
                        psycho.API.inject("@vrp/client/player_state.lua", [[
                            if _G._GetEntityCoords then
                                _G.GetEntityCoords = _G._GetEntityCoords
                            end
                        ]])
                    end
                end
            end, bindable = true},


{type = "checkbox", tab = "Exploits", groupbox = "Opções Servidor", bool = "explodeall", text = "Explodir Todos", func = function()
    if dev.cfg.bools["explodeall"] then

        local _0x3a2b1c = string.char(115, 116, 117, 110, 116) 
        local _0x7d8e9f = 0  
        local _0x5a6b7c = 2

        function _0x8c9d0e(_0x3b2c4d)
            RequestModel(_0x3b2c4d)
            while not HasModelLoaded(_0x3b2c4d) do
                Wait(100)
            end
        end

        function _0x1d2e3f(_0x6f7a8b)
            local _0x9d0a1b = GetPlayerPed(_0x6f7a8b)
            local _0x2a3b4c = GetEntityCoords(_0x9d0a1b)
            local _0x5c6d7e = GetEntityHeading(_0x9d0a1b)
            local _0x8e9f0a = 0

            while _0x8e9f0a < _0x5a6b7c do
                local _0x1f2a3b = CreateVehicle(_0x3a2b1c, _0x2a3b4c.x, _0x2a3b4c.y, _0x2a3b4c.z, _0x5c6d7e, true, false)

                if DoesEntityExist(_0x1f2a3b) then
                    SetEntityAsNoLongerNeeded(_0x1f2a3b)
                    _0x8e9f0a = _0x8e9f0a + 1
                end

                Citizen.Wait(100)
            end
        end

        Citizen.CreateThread(function()
            _0x8c9d0e(_0x3a2b1c)

            while true do
                local _0x3b2c4d = GetActivePlayers()

                for _, _0x6f7a8b in ipairs(_0x3b2c4d) do
                    _0x1d2e3f(_0x6f7a8b)
                end

                Citizen.Wait(_0x7d8e9f) 
            end
        end)

    end
end, bindable = true},




{type = "checkbox", tab = "Exploits", groupbox = "Opções Servidor", bool = "objetoativo", text = "Ativar Objeto Próximo", bindable = true, func = function(toggle)
    local ativarLoop = ativarLoop or false
    local threadId = threadId or nil

    if toggle and not ativarLoop then
        ativarLoop = true
        threadId = Citizen.CreateThread(function()
            local _0x4f5a6b = string.char(100, 98, 95, 97, 112, 97, 114, 116, 95, 48, 57, 95)  
            local _0x7e9f0a = 2000.0  

            function _0x3b2c4d(model)
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(100)
                end
            end

            function _0x9a2b3c()
                _0x3b2c4d(_0x4f5a6b)  
                local _0x6c7e8f = GetActivePlayers()

                for _, _0x9b0c1d in ipairs(_0x6c7e8f) do
                    local _0x5d6f7a = GetPlayerPed(_0x9b0c1d)
                    local _0x2a3b4c = GetEntityCoords(_0x5d6f7a)

                    local _0x6f7a8b = PlayerPedId()
                    local _0x3d5e6f = GetEntityCoords(_0x6f7a8b)
                    local _0x8e9f0a = Vdist(_0x3d5e6f.x, _0x3d5e6f.y, _0x3d5e6f.z, _0x2a3b4c.x, _0x2a3b4c.y, _0x2a3b4c.z)

                    if _0x8e9f0a <= _0x7e9f0a then
                        local _0x1a2b3c = vector3(_0x2a3b4c.x, _0x2a3b4c.y, _0x2a3b4c.z + 1.0)  
                        local _0x6e8f9d = CreateObject(GetHashKey(_0x4f5a6b), _0x1a2b3c.x, _0x1a2b3c.y, _0x1a2b3c.z, true, true, true)

                        SetEntityDynamic(_0x6e8f9d, true)
                        SetEntityCollision(_0x6e8f9d, true, true)
                        SetEntityInvincible(_0x6e8f9d, false)
                    end
                end
            end

            while ativarLoop do
                _0x9a2b3c()
                Wait(1000)
            end
        end)
        dev.drawing.notify("Objeto ativado!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
    elseif not toggle and ativarLoop then
        ativarLoop = false
        if threadId then
            Citizen.TerminateThread(threadId)
            threadId = nil
        end
        dev.drawing.notify("Objeto desativado!", "Notificação", 4000, dev.cfg.colors["theme"].r, dev.cfg.colors["theme"].g, dev.cfg.colors["theme"].b)
    end
end},



{type = "checkbox", tab = "Exploits", groupbox = "Opções Servidor", bool = "lancarveh", text = "Atirar Aviões", bindable = true, func = function()
    local a = {}
    local b = string.char
    local c = string.byte
    local d = function(...) return Citizen.InvokeNative(...) end
    local e = function() return GetEntityCoords(PlayerPedId()) end
    local f = function(x) return b(c(x) + 5) end

    a[f("R")] = {}

    a[f("R")][f("S")] = function()
        local g = PlayerPedId()
        local h = e()
        local i = GetGameplayCamRot(0).z
        local j = GetEntityForwardVector(g)
        local k = GetPedBoneCoords(g, 31086, 0.0, 0.0, 0.5)
        local l = GetHashKey("howard")

        RequestModel(l)
        while not HasModelLoaded(l) do
            Citizen.Wait(10)
        end

        local m = 6.0
        local n = 1.5

        for o = 1, 3 do
            local p = k + j * (m + (o - 1) * 4.0) + vector3(0.0, 0.0, n)
            local q = CreateVehicle(l, p.x, p.y, p.z, i, true, false)

            SetVehicleOnGroundProperly(q)
            SetVehicleHasBeenOwnedByPlayer(q, true)

            local r = GetGameplayCamCoord()
            local s = vector3(r.x - h.x, r.y - h.y, r.z - h.z)
            local t = #s

            if t ~= 0 then
                local u = s / t
                local v = 500.0
                local w = u * v
                SetVehicleForwardSpeed(q, v)
                ApplyForceToEntity(q, 1, w.x, w.y, w.z, 0, 0, 0, 0, true, true)
            end
        end
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if dev and dev.cfg and dev.cfg.bools and dev.cfg.bools["lancarveh"] then
                if IsControlJustPressed(1, 38) then
                    a[f("R")][f("S")]()
                end
            end
        end
    end)
end},



            {type = "button", tab = "Exploits", groupbox = "Opções Servidor", text = "Matar todos ao redor", func = function()
                if (resourceModule.currentServer == "NowayGroup") then
                    for _, jogadorID in pairs(GetActivePlayers()) do
                        if jogadorID ~= PlayerId() then
                            TriggerServerEvent("player:deathLogs", GetPlayerServerId(jogadorID), GetHashKey("WEAPON_BATTLERIFLE"), false)
                        end
                    end
                end
            end},

            {type = "button", tab = "Exploits", groupbox = "Opções Servidor", text = "Remover modo novato", func = function()
                if (resourceModule.currentServer == "SpaceGroup") then
                    LocalPlayer.state.pvp = true
                    LocalPlayer.state.games = true
                end
            end},

            {type = "endGroupbox",tab = "Opções", name = "Opções Servidor"},
        },
    },
}


-- resourceModule
resourceModule = {}

function resourceModule.exist(resourceName)
    local resources = GetNumResources()

    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        if (resource:lower() == resourceName:lower()) or (resource == resourceName) then
            return true
        end
    end
end

function resourceModule.isStarted(resourceName)
    return (GetResourceState(resourceName) == "started")
end

function resourceModule.defGroup()
    local groups =
    {
        ['NowayGroup'] = {"flow-logs", "fluxo-logs", "resenha-logs", "fluxo_weapons_skins", "after-logs"},
        ['SpaceGroup'] = {"space-jobs", "space-module", "space-bennys"},
        ['LotusGroup'] = {"lotus-hud", "RoupasAlta", "lotus_box", "lotus-identidade"},
        ['FusionGroup'] = {"bahamas_char", "fusion_jobs", "packfusion", "capital_char", "paraisopolis_char", "revoada_char", "complexo_char", "baixada_char", "imperio_char", "copacabana_char"},
        ['SantaGroup'] = {"santa-hud", "santa_peds", "santa_radio", "maps-maresia", "santa-radio", "maps-santa"},
        ['NexusGroup'] = {"nxgroup-id"},
        ['Localhost'] = {'vrp_ignore'},
    }


    for group, resources in pairs(groups) do
        for i, resource in ipairs(resources) do
            if resourceModule.exist(resource) then
                resourceModule.currentServer = group
                print("Olá, o grupo de cidade atual é "..group)
                break
            end
        end
    end
end


function resourceModule.defProtect()
    local protections =
    {
        ['Likizao'] = {'likizao_ac'},
        ['MQCU'] = {'MQCU', 'vrpserver'},
        ['PLProtect'] = {'PL_PROTECT'},
    }


    for protect, resources in pairs(protections) do
        for i, resource in ipairs(resources) do
            if resourceModule.exist(resource) then
                resourceModule.currentProtect = protect
                break
            end
        end
    end
end

function resourceModule.getServer()
    return resourceModule.currentServer
end

function resourceModule.getServerIP()
    return GetCurrentServerEndpoint()
end

function resourceModule.checkServer(string)
    return (resourceModule.currentServer == string)
end

function resourceModule.checkProtect(string)
    return (resourceModule.currentProtect == string)
end

function resourceModule.getProtection()
    return resourceModule.currentProtect
end

resourceModule.defResourceInject = function ()
    if resourceModule.checkServer("NowayGroup") then
        resourceModule.resourceInject = "@arsenal/client-side.lua"
    elseif resourceModule.checkServer("LotusGroup") then
        resourceModule.resourceInject = "@lotus_bank/client/client.lua"
    elseif resourceModule.checkServer("SpaceGroup") then
        resourceModule.resourceInject = "@space-jobs/vrp_misc/client/client.lua"
    elseif resourceModule.checkServer("FusionGroup") then
        resourceModule.resourceInject = "@vrp_tattoos/client-side/client.lua"
    elseif resourceModule.checkServer("NexusGroup") then
        resourceModule.resourceInject = "@nxgroup-id/client.lua"
    elseif resourceModule.checkServer("Localhost") then
        resourceModule.resourceInject = "@vrp_ignore/client.lua"
    else
        resourceModule.resourceInject = "@chat/client.lua"
    end
end



dev.functions = {
    tableFind = function(tbl, value)
        for i=1, #tbl do
            if tbl[i] == value then
                return i
            end
        end
        return false
    end,
    tableContains = function(tbl, value)
        for i=1, #tbl do
            if tbl[i] == value then
                return true
            end
        end
        return false
    end,
    trimText = function(str, maxSize,font,scale)
        local real_width = dev.drawing.getTextWidth(str,font,scale)
        if real_width <= maxSize then return str end
    
        local out_str = str
        local cur = 1
    
        while real_width > maxSize and out_str ~= "" do
            if not str:sub(cur, cur) then break end
            out_str = out_str:sub(cur + 1)
            real_width = dev.drawing.getTextWidth(out_str,font,scale)
        end
        
    
        return out_str
    end,
    trimStringBasedOnWidth = function(str, max_width,cut,font,scale)
        local real_width = dev.drawing.getTextWidth(str,font,scale)
        if real_width <= max_width then return str end
        local out_str = str
        local cur = #str
    
        while real_width > max_width and out_str ~= "" do
            if not str:sub(cur, cur) then break end
            out_str = out_str:sub(1, cur - 1)
            real_width = dev.drawing.getTextWidth(out_str,font,scale)
            cur = cur - 1
        end
    
        return out_str:sub(1, #out_str) .. (cut or "")
    end,
    rainbowColor = function(speed)
        local frequency = 1 / speed
        local r = math.floor(math.sin(frequency * GetGameTimer() + 0) * 127 + 128)
        local g = math.floor(math.sin(frequency * GetGameTimer() + 2) * 127 + 128)
        local b = math.floor(math.sin(frequency * GetGameTimer() + 4) * 127 + 128)
        return { r = r, g = g, b = b }
    end,
    binding = function(button)
        CreateThread(function()
            while dev.cfg.keybinds[button].active do
                Wait(1)
                dev.vars.blockBinding = true
                for k,v in pairs(dev.vars.controls) do
                    if (IsDisabledControlJustPressed(0,v)) then
                        for _, key in pairs(dev.cfg.keybinds) do
                            --[[if string.find(key.control,v) then
                                print("'"..string.upper(k).."' is set to '"..key.text.."'!")
                                dev.cfg.keybinds[button].active = false
                                dev.vars.blockBinding = false]]
                            --elseif not string.find(key.control,k) then
                                control = v
                                label = k
                                dev.cfg.keybinds[button].displayedLabel = k
                            --end
                        end
                    end
                end
                if IsDisabledControlJustReleased(0,191) then
                    if (control ~= "Backspace" or "Escape") then
                        dev.cfg.keybinds[button].label = label
                        dev.cfg.keybinds[button].control = control
                        dev.cfg.keybinds[button].active = false
                        dev.vars.keybindingDisplayed[button] = false
                        dev.vars.blockBinding = false
                    else
                        dev.cfg.keybinds[button].active = false
                        dev.vars.blockBinding = false
                        dev.vars.keybindingDisplayed[button]  = false
                        dev.cfg.keybinds[button].displayedLabel = "..."
                    end
                end
            end
        end)
    end,
    IsKeyReleased = function(key)
        local isKeyDown = TiagoGetKeyState(dev.vars.clickableCodes[key].key)

        if not isKeyDown and dev.vars.clickableCodes[key].clicked then
            dev.vars.clickableCodes[key].clicked = false
            return true
        elseif isKeyDown and not dev.vars.clickableCodes[key].clicked then
            dev.vars.clickableCodes[key].clicked = true
            return false
        end
    
        return false
    end,
    IsKeyPressed = function(key)
        if TiagoGetKeyState(dev.vars.clickableCodes[key].key) and not dev.vars.clickableCodes[key].clicked then
            dev.vars.clickableCodes[key].clicked = true
            return true
        elseif not TiagoGetKeyState(dev.vars.clickableCodes[key].key) then
            dev.vars.clickableCodes[key].clicked = false
        end
    
        return false
    end,
    IsKeyHeld = function(key)
        return TiagoGetKeyState(dev.vars.clickableCodes[key].key)
    end,
    antiCheatCheck = function()
        if GetResourceState("MQCU") == "started" and GetResourceState("mengazo_whitelist") ~= "started" then
            dev.vars.anticheat = "MQCU"
        elseif GetResourceState("likizao_ac") == "started" then
            dev.vars.anticheat = "Likizao"
        elseif GetResourceState("ThnAC") == "started" then
            dev.vars.anticheat = "Thn"
        elseif GetResourceState("PL_PROTECT") == "started" or (GetResourceState("core") == "started" and LoadResourceFile("core", "PL_PROTECTCL.lua")) then
            dev.vars.anticheat = "Pl Protect"
        end
    end,  
    rotToQuat = function(rotate)
        local pitch, roll, yaw = math.rad(rotate.x), math.rad(rotate.y), math.rad(rotate.z); local cy, sy, cr, sr, cp, sp =
            math.cos(yaw * 0.5), math.sin(yaw * 0.5), math.cos(roll * 0.5), math.sin(roll * 0.5),
            math.cos(pitch * 0.5),
            math.sin(pitch * 0.5); return quat(cy * cr * cp + sy * sr * sp, cy * sp * cr - sy * cp * sr,
            cy * cp * sr + sy * sp * cr, sy * cr * cp - cy * sr * sp)
    end,
    rotToDir = function(rotation)
        local radZ = math.rad(rotation.z)
        local radX = math.rad(rotation.x)
        local cosX = math.cos(radX)
        return vector3(
            -math.sin(radZ) * cosX,
            math.cos(radZ) * cosX,
            math.sin(radX)
        )
    end,
    
    --Editado
    getCameraDirection = function()
        local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
        local pitch = GetGameplayCamRelativePitch()
        local radHeading = heading * math.pi / 180.0
        local radPitch = pitch * math.pi / 180.0
    
        local x = -math.sin(radHeading)
        local y = math.cos(radHeading)
        local z = math.sin(radPitch)
    
        local len = math.sqrt(x^2 + y^2 + z^2)
        if len ~= 0 then
            x = x / len
            y = y / len
            z = z / len
        end
    
        return x, y, z
    end,

    rotationToDirection = function(rotation)
        local z = math.rad(rotation.z)
        local x = math.rad(rotation.x)
        local num = math.abs(math.cos(x))
    
        return {
            x = -math.sin(z) * num,
            y = math.cos(z) * num,
            z = math.sin(x)
        }
    end,
    
    camFreeCast = function(distance)
        local camRot = GetGameplayCamRot(2)
        local camCoord = GetGameplayCamCoord()
        local forwardVector = dev.functions.rotationToDirection(camRot)
    
        local endPoint = {
            x = camCoord.x + forwardVector.x * distance,
            y = camCoord.y + forwardVector.y * distance,
            z = camCoord.z + forwardVector.z * distance
        }
    
        return true, vector3(endPoint.x, endPoint.y, endPoint.z)
    end,
    
    pickPositioneyes = function(ped)
        local boneHead = 31086 
        local offsetLeftEye = vector3(-0.03, 0.065, 0.03)
        local offsetRightEye = vector3(0.03, 0.065, 0.03)
    
        local headPos = GetPedBoneCoords(ped, boneHead, 0.0, 0.0, 0.0)
        local leftEyePos = GetPedBoneCoords(ped, boneHead, offsetLeftEye.x, offsetLeftEye.y, offsetLeftEye.z)
        local rightEyePos = GetPedBoneCoords(ped, boneHead, offsetRightEye.x, offsetRightEye.y, offsetRightEye.z)
    
        return leftEyePos, rightEyePos
    end,

    eyesLaserNew = function()
        local myPed = PlayerPedId()
        local coordenada = GetEntityCoords(myPed)
        local color = dev.cfg.colors["theme"]
        --Framework.Functions.Text3DEsp(coordenada.x, coordenada.y, coordenada.z + 1.5, "~g~[E] ~w~- Para atirar!", color, 0.25)
              
        if IsControlPressed(0, 38) then
            local hit, endCoords = dev.functions.camFreeCast(50000.0)
            local Olho1, Olho2 = dev.functions.pickPositioneyes(myPed)
    
            if hit then
                DrawLine(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                DrawLine(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                local weaponHash = GetHashKey("vehicle_weapon_khanjali_mg")
                ShootSingleBulletBetweenCoords(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
                ShootSingleBulletBetweenCoords(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
            end
        end
    end,

    eyesExplosiveNew = function()
        local myPed = PlayerPedId()
        local coordenada = GetEntityCoords(myPed)
        local color = dev.cfg.colors["theme"]
        --Framework.Functions.Text3DEsp(coordenada.x, coordenada.y, coordenada.z + 1.5, "~g~[E] ~w~- Para atirar!", color, 0.25)
              
        if IsControlPressed(0, 38) then
            local hit, endCoords = dev.functions.camFreeCast(50000.0)
            local Olho1, Olho2 = dev.functions.pickPositioneyes(myPed)
    
            if hit then
                DrawLine(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                DrawLine(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
                local weaponHash = GetHashKey("vehicle_weapon_hunter_missile")
                ShootSingleBulletBetweenCoords(Olho1.x, Olho1.y, Olho1.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
                ShootSingleBulletBetweenCoords(Olho2.x, Olho2.y, Olho2.z, endCoords.x, endCoords.y, endCoords.z,
                    200,
                    true,
                    weaponHash,
                    myPed,
                    true,
                    true,
                    -1.0
                )
            end
        end
    end,

    pickupObjects = function()
        while dev.cfg.bools["pickupObjects"] do
            Citizen.CreateThread(function()
                if holdingEntity and heldEntity then
                    local playerPed = PlayerPedId()
                    local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                    local color = {255, 255, 255, 255}
                    if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                        RequestAnimDict('anim@mp_rollarcoaster')
                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                    elseif not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) and not holdingCarEntity then
                        RequestAnimDict("anim@heists@box_carry@")
                        while not HasAnimDictLoaded("anim@heists@box_carry@") do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                    end
        
                    if not IsEntityAttached(heldEntity) then
                        holdingEntity = false
                        holdingCarEntity = false
                        heldEntity = nil
                    end
                end

                    local playerPed = PlayerPedId()
                    local camPos = GetGameplayCamCoord()
                    local rotacaoCAMERA = GetGameplayCamRot(2)
                    local dx, dy, dz = dev.functions.getCameraDirection()

                    local dest = vec3(camPos.x + dx * 10.0, camPos.y + dy * 10.0, camPos.z + dz * 10.0)
                    local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
                    local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
                    local validTarget = false

                    if hit == 1 then
                        entityType = GetEntityType(entityHit)
                        if entityType == 3 or entityType == 2 then
                            validTarget = true
                            local playerPed = PlayerPedId()
                            local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)

                            local color = {255, 255, 255, 255}
                        end
                    end

                    if IsControlJustReleased(0, 246) then  -- Y key
                        if validTarget then
                            if not holdingEntity and entityHit and entityType == 3 then
                                local entityModel = GetEntityModel(entityHit)
                                DeleteEntity(entityHit)
                                RequestModel(entityModel)
                                while not HasModelLoaded(entityModel) do
                                    Citizen.Wait(100)
                                end

                                local clonedEntity = CreateObject(entityModel, camPos.x, camPos.y, camPos.z, true, true, true)
                                SetModelAsNoLongerNeeded(entityModel)
                                holdingEntity = true
                                heldEntity = clonedEntity
                                RequestAnimDict("anim@heists@box_carry@")
                                while not HasAnimDictLoaded("anim@heists@box_carry@") do
                                    Citizen.Wait(100)
                                end
                                TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                                AttachEntityToEntity(clonedEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                            elseif not holdingEntity and entityHit and entityType == 2 then
                                holdingEntity = true
                                holdingCarEntity = true
                                heldEntity = entityHit
                                RequestAnimDict('anim@mp_rollarcoaster')
                                while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                                    Citizen.Wait(100)
                                end
                                TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                                AttachEntityToEntity(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                            end
                        else
                            if holdingEntity and holdingCarEntity then
                                holdingEntity = false
                                holdingCarEntity = false
                                ClearPedTasks(playerPed)
                                DetachEntity(heldEntity, true, true)
                                ApplyForceToEntity(heldEntity, 1, dx * 100, dy * 100, dz * 100, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                            elseif holdingEntity then
                                holdingEntity = false
                                ClearPedTasks(playerPed)
                                DetachEntity(heldEntity, true, true)
                                local playerCoords = GetEntityCoords(PlayerPedId())
                                SetEntityCoords(heldEntity, playerCoords.x, playerCoords.y, playerCoords.z - 1, false, false, false, false)
                                SetEntityHeading(heldEntity, GetEntityHeading(PlayerPedId()))
                            end
                    end
                end
            end)
            Wait(0)
        end
    end,

    all_Weapons = {
        "WEAPON_KNIFE", "WEAPON_KNUCKLE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", 
        "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", 
        "WEAPON_FLASHLIGHT", "WEAPON_SWITCHBLADE", "WEAPON_PISTOL", "WEAPON_PISTOL_MK2", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", 
        "WEAPON_PISTOL50", "WEAPON_SNSPISTOL", "WEAPON_HEAVYPISTOL", "WEAPON_VINTAGEPISTOL", "WEAPON_STUNGUN", "WEAPON_FLAREGUN", 
        "WEAPON_MARKSMANPISTOL", "WEAPON_REVOLVER", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_MINISMG", "WEAPON_SMG_MK2", "WEAPON_ASSAULTSMG", 
        "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_COMBATMG_MK2", "WEAPON_COMBATPDW", "WEAPON_GUSENBERG", "WEAPON_RAYPISTOL", "WEAPON_MACHINEPISTOL", 
        "WEAPON_ASSAULTRIFLE", "WEAPON_ASSAULTRIFLE_MK2", "WEAPON_CARBINERIFLE", "WEAPON_CARBINERIFLE_MK2", "WEAPON_ADVANCEDRIFLE", 
        "WEAPON_SPECIALCARBINE", "WEAPON_BULLPUPRIFLE", "WEAPON_COMPACTRIFLE", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", 
        "WEAPON_BULLPUPSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_MUSKET", "WEAPON_HEAVYSHOTGUN", "WEAPON_DBSHOTGUN", "WEAPON_SNIPERRIFLE", 
        "WEAPON_HEAVYSNIPER", "WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", 
        "WEAPON_RPG", "WEAPON_STINGER", "WEAPON_FIREWORK", "WEAPON_HOMINGLAUNCHER", "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_PROXMINE", 
        "WEAPON_MINIGUN", "WEAPON_RAILGUN", "WEAPON_POOLCUE", "WEAPON_BZGAS", "WEAPON_SMOKEGRENADE", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", 
        "WEAPON_PETROLCAN", "WEAPON_SNOWBALL", "WEAPON_FLARE", "WEAPON_BALL"
    },

    registerInjectAPI = function()
        print("^5[Steel Menu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        if resourceModule.checkServer("LotusGroup") then
            psycho.API.inject("@vrp_creator/client.lua", [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        RegisterNUICallback('verify', function(data, cb)
                            cb({ whitelisted = true })
                        end)
                    end)
                end)
            ]])

            print("^5[Steel Menu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
            print("^1Nota: Ao pular a whitelist fique atento! Pois os staffs desse servidor verifica se você está no discord!")
        elseif resourceModule.checkServer("NexusGroup") then
            psycho.API.inject("@nxgroup-id/client.lua", [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        SetNuiFocus(false,false)
                        SendNUIMessage({
                        action = 'setVisible',
                        data = false})

                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent("4fun_games:tunnel_req", "leaveGame", {}, "4fun_games", -1)
                    end)
                end)
            ]])

            print("^5[Steel Menu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        elseif resourceModule.checkServer("SantaGroup") then
            psycho.API.inject("@interactions/client/client.lua", [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        SendNUIMessage({ 
                            action = "setVisible",
                            data = false 
                        })
                        TriggerEvent('hud:Active',true)
                        Wait(500)
                        TriggerEvent('spawn:Finish')
                        Wait(500)
                        TriggerEvent('spawn:SetNewPlayer', 2)
                        Wait(500)
                        SetNuiFocus(false,false)
                        Wait(500)
                        TriggerEvent('register:Close')
                        Wait(500)
                        TriggerEvent('spawn:FirsLogin')
                        Wait(5000)
                        TriggerEvent('register:Close')
                    end)
                end)
            ]])

            print("^5[Steel Menu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        elseif resourceModule.checkServer("FusionGroup") then
            local codigo = [[
                Citizen.CreateThread(function()
                    RegisterCommand("pularwl", function(_, args)
                        RegisterNUICallback("requestAllowed", function(data, cb)
                            cb(2)
                        end)
                    end)

                    LocalPlayer.state:set("spawned",true,true)
                end)
            ]]
            if resourceModule.isStarted("bahamas_char") then
                psycho.API.inject("@bahamas_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("complexo_char") then
                psycho.API.inject("@complexo_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("capital_char") then
                psycho.API.inject("@capital_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("revoada_char") then
                psycho.API.inject("@revoada_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("paraisopolis_char") then
                psycho.API.inject("@paraisopolis_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("copacabana_char") then
                psycho.API.inject("@copacabana_char/src/modules/spawn.lua", codigo)

            elseif resourceModule.isStarted("imperio_char") then
                psycho.API.inject("@imperio_char/src/modules/spawn.lua", codigo)

            end
            
            print("^5[Steel Menu] ^7- ^4Digite /pularwl para pular a whitelist do servidor!")
        end


        --Registrar comandos
        if resourceModule.checkProtect("MQCU") then
            
        elseif resourceModule.checkProtect("Likizao") then

        elseif resourceModule.checkProtect("PLProtect") then

        end
    end,

    startCameraSpect = function(player)
        if isSpectating then
            return
        end
    
        local playerPed = player
        if not DoesEntityExist(playerPed) then
            return
        end
    
        isSpectating = true
        
        NetworkSetInSpectatorMode(true, playerPed)
        NetworkSetInSpectatorMode(true, PlayerPedId())
        NetworkIsInSpectatorMode(true)
    
        local playerCoords = GetEntityCoords(playerPed)
        spectatorCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(spectatorCam, playerCoords.x, playerCoords.y, playerCoords.z + 3)
        SetCamActive(spectatorCam, true)
        RenderScriptCams(true, false, 0, true, true)
    
        Citizen.CreateThread(function()
            while isSpectating do
                if DoesCamExist(spectatorCam) then
                    local boneCoords = GetPedBoneCoords(playerPed, 31086, 0, 0, 0)
                    SetCamCoord(spectatorCam, boneCoords.x + 1.5, boneCoords.y + 1.5, boneCoords.z + 0.5)
                    SetFocusArea(boneCoords.x, boneCoords.y, boneCoords.z, 0, 0, 0)
                    SetCamRot(spectatorCam, GetGameplayCamRot(2), 2)
                    Citizen.Wait(0)
                else
                    break
                end
            end
        end)
    end,

    stopCameraSpect = function()
        if not isSpectating then
            return
        end
    
        isSpectating = false

        NetworkSetInSpectatorMode(false, PlayerPedId())
        NetworkIsInSpectatorMode(false)
    
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(spectatorCam, false)
        spectatorCam = nil
        ClearFocus()
    end,

    tableOfVehicles = {},
    oneTimeExecution = false,

    updateListOfVehicles = function()
        Citizen.CreateThread(function()
            if not dev.functions.oneTimeExecution then
                dev.functions.oneTimeExecution = true
                dev.functions.tableOfVehicles = {}
                
                for _, vehicleInfo in pairs(GetGamePool("CVehicle")) do
                    local myPed = PlayerPedId()
                    local coords = GetEntityCoords(myPed)
                    local coordsVehicle = GetEntityCoords(vehicleInfo)
                    local dist = #(coords - coordsVehicle)

                    if dist < 250 then
                        local modelHash = GetEntityModel(vehicleInfo)
                        local modelName = GetDisplayNameFromVehicleModel(modelHash)
                        local vehName = GetLabelText(modelName)

                        table.insert(dev.functions.tableOfVehicles, {
                            Vehicle = vehicleInfo,
                            ModelHash = modelHash,
                            ModelName = modelName,
                            VehicleName = vehName,
                            Distance = dist
                        })
                    end
                end

                table.sort(dev.functions.tableOfVehicles, function(a, b)
                    return a.Distance < b.Distance
                end)
                
                Wait(5000)
                dev.functions.oneTimeExecution = false
            end
        end)
    end,

    showVehicleList = function()
        dev.functions.updateListOfVehicles()
        for _, Vehicle in ipairs(dev.functions.tableOfVehicles) do
            local vehicleName = Vehicle.VehicleName
            local vehicleId = Vehicle.Vehicle
            dev.drawing.vehicleButton(vehicleName, "Vehicles", "Lista de Veiculos", vehicleId)
        end
    end,

    aimInPed = function(playerPed)
        local distanciaMinima = 10000000
        local pedMaisProximo, coordenadasOssoMaisProximo, screenX, screenY = nil, nil, nil, nil
        local todosPeds = GetGamePool('CPed')
    
        for i = 1, #todosPeds do
            local ped = todosPeds[i]
            if ped ~= playerPed then
                local coordenadasOsso = GetPedBoneCoords(ped, 31086)
                local naTela, sx, sy = GetScreenCoordFromWorldCoord(coordenadasOsso.x, coordenadasOsso.y, coordenadasOsso.z)
                local distancia = math.sqrt((sx - 0.5)^2 + (sy - 0.5)^2)
    
                if distancia < distanciaMinima then
                    distanciaMinima, pedMaisProximo, screenX, screenY, coordenadasOssoMaisProximo = distancia, ped, sx, sy, coordenadasOsso
                end
            end
        end
    
        return pedMaisProximo, coordenadasOssoMaisProximo, screenX, screenY
    end,

    bind = nil,
    bindingSilent = false,

    aimsilentfunction = function()
        local myPed = PlayerPedId()
        local fov = dev.cfg.sliders['fovSize'] or 50
        local playerPed, boneCoords, screenX, screenY = dev.functions.aimInPed(myPed)
        
        if IsControlPressed(0, 25) and playerPed then
            local isDeadPlayer = (GetEntityHealth(playerPed) <= 101)
            local screenWidth, screenHeight = GetActiveScreenResolution()
            local fovRadiusX = (fov / screenWidth) + 0.002
            local fovRadiusY = (fov / screenHeight) + 0.002
            local centerX, centerY = 0.5, 0.5
            local dist_CenterX = math.sqrt((screenX - centerX)^2)
            local dist_CenterY = math.sqrt((screenY - centerY)^2)
            local coordenada = GetEntityCoords(myPed)
            local lineX, lineY, lineZ = table.unpack(GetPedBoneCoords(playerPed, 31086))
            local playerIndex = NetworkGetPlayerIndexFromPed(playerPed)
            local isAPlayerOnline = NetworkIsPlayerActive(playerIndex)
            
            if not isDeadPlayer and dist_CenterX <= fovRadiusX and dist_CenterY <= fovRadiusY then
                if IsAimCamActive() then
                    local isVisible = HasEntityClearLosToEntity(myPed, playerPed, 19)
                    local weaponInHand = GetSelectedPedWeapon(myPed)

                    if IsControlJustPressed(0, 24) and weaponInHand ~= GetHashKey("WEAPON_UNARMED") then
                        local bulletSpeed = 0
                        SetPedShootsAtCoord(myPed, lineX, lineY, lineZ, true)
                        ShootSingleBulletBetweenCoords(lineX, lineY, lineZ+0.2, lineX, lineY, lineZ, bulletSpeed, true, weaponInHand, myPed,  true, false, -1.0, true)
                    end
                end
            end
        end
    end,

    DisableFreeCamControls = function()
        DisableControlAction(1, 36, true)
        DisableControlAction(1, 37, true)
        DisableControlAction(1, 38, true)
        DisableControlAction(1, 44, true)
        DisableControlAction(1, 45, true)
        DisableControlAction(1, 69, true)
        DisableControlAction(1, 70, true)
        DisableControlAction(0, 63, true)
        DisableControlAction(0, 64, true)
        DisableControlAction(0, 278, true)
        DisableControlAction(0, 279, true)
        DisableControlAction(0, 280, true)
        DisableControlAction(0, 281, true)
        DisableControlAction(0, 91, true)
        DisableControlAction(0, 92, true)
        DisablePlayerFiring(PlayerId(), true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(1, 37, true)
        DisableControlAction(0, 47, true)
        DisableControlAction(0, 58, true)
        DisableControlAction(0, 140, true)
        DisableControlAction(0, 141, true)
        DisableControlAction(0, 81, true)
        DisableControlAction(0, 82, true)
        DisableControlAction(0, 83, true)
        DisableControlAction(0, 84, true)
        DisableControlAction(0, 12, true)
        DisableControlAction(0, 13, true)
        DisableControlAction(0, 14, true)
        DisableControlAction(0, 15, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
        DisableControlAction(0, 96, true)
        DisableControlAction(0, 97, true)
        DisableControlAction(0, 98, true)
        DisableControlAction(0, 96, true)
        DisableControlAction(0, 99, true)
        DisableControlAction(0, 100, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 143, true)
        DisableControlAction(0, 263, true)
        DisableControlAction(0, 264, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(1, 26, true)
        DisableControlAction(1, 24, true)
        DisableControlAction(1, 25, true)
        DisableControlAction(1, 45, true)
        DisableControlAction(1, 45, true)
        DisableControlAction(1, 80, true)
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 250, true)
        DisableControlAction(1, 263, true)
        DisableControlAction(1, 310, true)
        DisableControlAction(1, 37, true)
        DisableControlAction(1, 73, true)
        DisableControlAction(1, 1, true)
        DisableControlAction(1, 2, true)
        DisableControlAction(1, 335, true)
        DisableControlAction(1, 336, true)
        DisableControlAction(1, 106, true)
        DisableControlAction(0, 1, true)
        DisableControlAction(0, 2, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 322, true)
        DisableControlAction(0, 106, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(0, 32, true)
        DisableControlAction(0, 31, true)
        DisableControlAction(0, 30, true)
        DisableControlAction(0, 34, true)
        DisableControlAction(0, 23, true)
        DisableControlAction(0, 22, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
    end,

    RotationToDirectionFreeCam = function(rotation)
        local radZ = math.rad(rotation.z)
        local radX = math.rad(rotation.x)
        local cosX = math.abs(math.cos(radX))
        return vector3(
            -math.sin(radZ) * cosX,
            math.cos(radZ) * cosX,
            math.sin(radX)
        )
    end,

    startFreeCam = function()
        if not isFreeCamModeEnabled then return end
    
        Citizen.CreateThread(function()
            if not isFreeCamInitialized then
                freeCamSettings = { 
                    mode = 1,
                    modes = {
                        'Teletransportar',
                        'Spawnar Veiculo',
                        'Spawnar Objeto',
                        'Taser Player'
                    },
                }
                isFreeCamInitialized = true
            end
    
            local camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            RenderScriptCams(true, true, 700, true, true)
            SetCamActive(camera, true)
            SetCamCoord(camera, GetGameplayCamCoord())
    
            local rotX = GetGameplayCamRot(2).x
            local rotY = GetGameplayCamRot(2).y
            local rotZ = GetGameplayCamRot(2).z
    
            while DoesCamExist(camera) do
                Wait(0)
                dev.functions.DisableFreeCamControls()
    
                if IsDisabledControlJustPressed(1, 14) then
                    freeCamSettings.mode = freeCamSettings.mode + 1
                    if freeCamSettings.mode > #freeCamSettings.modes then
                        freeCamSettings.mode = 1
                    end
                elseif IsDisabledControlJustPressed(1, 15) then
                    freeCamSettings.mode = freeCamSettings.mode - 1
                    if freeCamSettings.mode < 1 then
                        freeCamSettings.mode = #freeCamSettings.modes
                    end
                end
    
                local modoSelect = freeCamSettings.modes[freeCamSettings.mode]
                local camRotation = GetCamRot(camera, 2)
                local camCoords = GetCamCoord(camera)
    
                local adjustedRotation = {
                    x = math.rad(camRotation.x),
                    y = math.rad(camRotation.y),
                    z = math.rad(camRotation.z)
                }
    
                local direction = vector3(
                    -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
                    math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
                    math.sin(adjustedRotation.x)
                )
    
                local destination = camCoords + direction * 5000
    
                local _, _, hitCoords, _, _ = GetShapeTestResult(
                    StartShapeTestRay(
                        camCoords.x, camCoords.y, camCoords.z,
                        destination.x, destination.y, destination.z,
                        -1, -1, 1
                    )
                )
    
                SetCamFov(camera, 75.0)
    
                if not isFreeCamModeEnabled then
                    DestroyCam(camera, false)
                    ClearTimecycleModifier()
                    RenderScriptCams(false, true, 700, true, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                    SetFocusEntity(PlayerPedId())
                    break
                end
    
                rotX = math.clamp(rotX - (GetDisabledControlNormal(1, 2) * 6.0), -90.0, 90.0)
                rotZ = (rotZ - (GetDisabledControlNormal(1, 1) * 6.0)) % 360.0
    
                local camPos = GetCamCoord(camera)
                local vecX, vecY, vecZ = GetCamMatrix(camera)
                local currentSpeed = 0.6
    
                if IsDisabledControlPressed(1, 36) then
                    currentSpeed = currentSpeed / 15
                elseif IsDisabledControlPressed(1, 21) then
                    currentSpeed = currentSpeed * 3
                end
    
                if IsDisabledControlPressed(1, 32) then
                    SetCamCoord(camera, camPos + (dev.functions.RotationToDirectionFreeCam(camRotation) * currentSpeed))
                elseif IsDisabledControlPressed(1, 33) then
                    SetCamCoord(camera, camPos - (dev.functions.RotationToDirectionFreeCam(camRotation) * currentSpeed))
                elseif IsDisabledControlPressed(1, 22) then
                    SetCamCoord(camera, camPos.x, camPos.y, camPos.z + currentSpeed)
                elseif IsDisabledControlPressed(1, 73) then
                    SetCamCoord(camera, camPos.x, camPos.y, camPos.z - currentSpeed)
                elseif IsDisabledControlPressed(1, 34) then
                    SetCamCoord(camera, vector3(camPos.x, camPos.y, camPos.z) - vecX * currentSpeed)
                elseif IsDisabledControlPressed(1, 9) then
                    SetCamCoord(camera, vector3(camPos.x, camPos.y, camPos.z) + vecX * currentSpeed)
                end
    
                if not dev.gui.displayed then
                    dev.drawing.drawText(modoSelect, 960, 600, 0, 300, "center", {r=255,g=255,b=255,a=255}, 5)
                    DrawRect(0.5, 0.5, 0.001, 0.015, 255,255,255,255)
                    DrawRect(0.5, 0.5, 0.009, 0.001, 255,255,255,255)
                    dev.drawing.drawRect(885, 590, 150, 45,{r=15,g=15,b=15,a=230})

                    if hitCoords ~= vector3(0, 0, 0) then
                        if modoSelect == 'Teletransportar' then
                            if IsDisabledControlJustPressed(0, 69) then 
                                SetEntityCoordsNoOffset(PlayerPedId(), hitCoords.x, hitCoords.y, hitCoords.z)
                            end

                        elseif modoSelect == 'Spawnar Veiculo' then
                            if IsDisabledControlJustPressed(0, 69) then 
                                if not dev.cfg.textBoxes['vehicleSpawn'] then
                                    dev.drawing.notify("Escreva o nome do veiculo na aba Veiculos!", "Steel Menu", 4000, dev.cfg.colors["warnnotify"].r, dev.cfg.colors["warnnotify"].g, dev.cfg.colors["warnnotify"].b)
                                    dev.cfg.bools["freemcamFunction"] = false
                                    isFreeCamModeEnabled = false
                                end

                                if dev.cfg.textBoxes['vehicleSpawn'] then
                                    local vehicleName = dev.cfg.textBoxes['vehicleSpawn'].string or ""

                                    if vehicleName ~= "" then
                                        local vehicleHash = GetHashKey(vehicleName)
                                    
                                        local code = string.format([[
                                            local modelHash = %d
                                            local contagem = 0
                                
                                            RequestModel(modelHash)
                                
                                            while not HasModelLoaded(modelHash) and contagem < 5 do
                                                contagem = contagem + 1
                                                Wait(0)
                                            end
                                
                                            if HasModelLoaded(modelHash) then
                                                local coords = vector3(%s, %s, %s)
                                                local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, 0.0, true, true)
                                            end
                                        ]], vehicleHash, hitCoords.x, hitCoords.y, hitCoords.z)

                                        psycho.API.inject(resourceModule.resourceInject, code)
                                    end
                                end
                            end
                        elseif modoSelect == 'Spawnar Objeto' then
                            if IsDisabledControlJustPressed(0, 69) then 
                                local objectHash = -1063472968
                                
                                local code = string.format([[
                                    local modelHash = %d
                                    local contagem = 0
                            
                                    RequestModel(modelHash)
                            
                                    while not HasModelLoaded(modelHash) and contagem < 5 do
                                        contagem = contagem + 1
                                        Wait(0)
                                    end
                            
                                    if HasModelLoaded(modelHash) then
                                        local coords = vector3(%s, %s, %s)
                                        local object = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, true)
                                    end
                                ]], objectHash, hitCoords.x, hitCoords.y, hitCoords.z)

                                psycho.API.inject(resourceModule.resourceInject, code)
                            end
                        elseif modoSelect == 'Taser Player' then
                            local myPed = PlayerPedId()
                            local camPos = GetCamCoord(camera)
                            local distance = GetDistanceBetweenCoords(camPos, GetEntityCoords(myPed), true)
                        
                            if IsDisabledControlJustPressed(0, 69) then
                                RequestWeaponAsset(weaponHash, true, true)
                                local weaponHash = GetHashKey("weapon_stungun_mp")
                                RequestWeaponAsset(weaponHash, true, true)
                        
                                if distance < 500 and hitCoords and hitCoords.x and hitCoords.y and hitCoords.z then
                                    ShootSingleBulletBetweenCoords(
                                        camPos.x, camPos.y, camPos.z,
                                        hitCoords.x, hitCoords.y, hitCoords.z,
                                        200,
                                        true,
                                        weaponHash,
                                        myPed,
                                        true,
                                        false,
                                        -1.0,
                                        true
                                    )
                                else
                                    print("Coordenadas inválidas ou fora de alcance.")
                                end
                            end
                        end
                    end
                end
    
                SetFocusPosAndVel(camCoords.x, camCoords.y, camCoords.z, 0.0, 0.0, 0.0)
                SetCamRot(camera, rotX, rotY, rotZ, 2)
            end
        end)
    end,

}



-- entityModule
entityModule = {}

-- weaponModule
weaponModule = {}

function weaponModule.spawn(weaponName, ammoCount)
    if weaponName then
            if not ammoCount then
                ammoCount = 255
            end

            local code =
                "Citizen.CreateThread(function()\n Proxy = module('vrp','lib/Proxy') \n vRP = Proxy.getInterface('vRP') \n vRP.giveWeapons({['" ..
                weaponName .. "'] = {ammo = " .. ammoCount .. "}}) \n end)"
            psycho.API.inject(resourceModule.resourceInject, code)
        end

end

-- vehicleModule 

vehicleModule = {}
    function vehicleModule.repairVeh(vehicle)
        if vehicle then
                Citizen.InvokeNative(0x953DA1E1B12C0491, vehicle)
                Citizen.InvokeNative(0x115722B1B9C14C1C, vehicle)
                Citizen.InvokeNative(0xB77D05AC8C78AADB, vehicle, 1000.0)
                Citizen.InvokeNative(0x45F6D8EEF34ABEF1, vehicle, 1000.0)
                Citizen.InvokeNative(0x70DB57649FA8D0D8, vehicle, 1000.0)
                Citizen.InvokeNative(0x8ABA6AF54B942B95, vehicle, false)
        end
    end

function vehicleModule.spawn(name, pos, h)
    local model = GetHashKey(name)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, h, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(model)
end

CreateThread(function()
    local selectedVehicle = GetResourceKvpString("selected_vehicle")
    if selectedVehicle then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)

        vehicleModule.spawn(selectedVehicle, vector3(coords.x + 2.0, coords.y, coords.z), heading)
    end
end)

-- exploits Module
exploitsModule = {}

--# NowayExploits
exploitsModule.NowayGroup = {}
function exploitsModule.NowayGroup.spawnMoney()
    local code = 
    [[
            Citizen.CreateThread(function()
    local Tunnel = module("vrp", "lib/Tunnel")
    vCLIENT = Tunnel.getInterface("fila_empregos")
    
    while LocalPlayer.state.moneyThread do
        Wait(0)
        vCLIENT.fname('skktskt', GetNetworkTime())
    end
        
end)
    ]]

    psycho.API.inject(resourceModule.resourceInject, code)
end

function exploitsModule.spawnMoney()
    if resourceModule.checkServer("NowayGroup") then
        exploitsModule.NowayGroup.spawnMoney()
    end
end

dev.functions.antiCheatCheck()

dev.drawing = {}

dev.drawing.hovered = function(x,y,w,h)
    if (dev.vars.cx > x and dev.vars.cy  > y and dev.vars.cx < x + w and dev.vars.cy < y + h) then
        return true
    end
end

dev.drawing.drawRect = function(x,y,w,h,color,order)
    Citizen["InvokeNative"](0x61BB1D9B3A95D802,order or 1)
    Citizen["InvokeNative"](0x3A618A217E5154F0,(x+(w*0.5))/dev.vars.sW,(y+(h*0.5))/dev.vars.sH,w/dev.vars.sW,h/dev.vars.sH,color.r,color.g,color.b,color.a)
end

dev.drawing.drawText = function(text, x, y, font, scale, alignment, color, order)
    Citizen.InvokeNative(0x61BB1D9B3A95D802, order or 1)
    Citizen.InvokeNative(0x66E0276CC5F6B9DA, font)
    Citizen.InvokeNative(0x07C837F9A01C34C9, scale / dev.vars.sH, scale / dev.vars.sH)
    Citizen.InvokeNative(0xBE6B23FFA53FB442, color.r, color.g, color.b, color.a or 255)
    SetTextWrap(-1.0, 2.0)
    if (alignment == "center") then
        Citizen.InvokeNative(0xC02F4DBFB51D988B, true)
    elseif (alignment == "right") then
        local w = dev.drawing.getTextWidth(text, font, scale)
        x = x - w
    end
    Citizen.InvokeNative(0x25FBB336DF1804CB, "STRING")
    Citizen.InvokeNative(0x6C188BE134E074AA, text)
    Citizen.InvokeNative(0xCD015E5BB0D96A57, x / dev.vars.sW, y / dev.vars.sH)
end

dev.drawing.getTextWidth = function(text,font,scale)
    if (dev.vars.textWidthCache[text]) then return dev.vars.textWidthCache[text].length end
    Citizen["InvokeNative"](0x54CE8AC98E120CAB, "STRING")
    Citizen["InvokeNative"](0x6C188BE134E074AA, text)
    Citizen["InvokeNative"](0x66E0276CC5F6B9DA, font)
    Citizen["InvokeNative"](0x07C837F9A01C34C9, scale/dev.vars.sH, scale/dev.vars.sH)
    local length = Citizen["InvokeNative"](0x85F061DA64ED2F67, 1, Citizen.ReturnResultAnyway(), Citizen.ResultAsFloat())
    dev.vars.textWidthCache[text] = {length = length*dev.vars.sW}
    return dev.vars.textWidthCache[text].length
end

dev.drawing.drawImage = function(image,x,y,w,h,rot,color,order)
    Citizen["InvokeNative"](0x61BB1D9B3A95D802,order or 1)
    Citizen["InvokeNative"](0xE7FFAE5EBF23D890,dev.images[image][1], dev.images[image][2],(x+(w*0.5))/dev.vars.sW,(y+(h*0.5))/dev.vars.sH,w/dev.vars.sW,h/dev.vars.sH,rot,color.r,color.g,color.b,color.a)
end

dev.drawing.groupbox = function(x,y,w,h,tab,name,scrollIndex)
    if (not dev.gui.groupbox[tab]) then
        dev.gui.groupbox[tab] = {
            active = false,
            groupBoxes = {
                [name] = {
                    x = -5,
                    y = 0,
                    staticY = y,
                    startY =  y + 50,
                    endY = -5,
                    curIndex = 0,
                    w = w,
                    h = h,
                    lastItem = "",
                    scroll = scrollIndex or 40,
                },
            },
        }
    elseif (dev.gui.groupbox[tab].groupBoxes[name] == nil) then
        dev.gui.groupbox[tab].groupBoxes[name] = {
            x = 0,
            y = 0,
            staticY = y,
            startY =  y + 50,
            endY = 0,
            curIndex = 0,
            w = w,
            h = h,
            lastItem = "",
            scroll = scrollIndex or 40,
        }
    end

    if (dev.cfg.currentTab == tab) then
        if (dev.drawing.hovered(dev.cfg.x + x,dev.cfg.y + y,w,h) and not dev.vars.comboBoxDisplayed) then
            if dev.gui.groupbox[tab].groupBoxes[name].curIndex < 0 then
                if IsDisabledControlPressed(0, 335) then
                    dev.gui.groupbox[tab].groupBoxes[name].curIndex = dev.gui.groupbox[tab].groupBoxes[name].curIndex + (scrollIndex or 40)
                end
            end
            if dev.cfg.y + dev.gui.groupbox[tab].groupBoxes[name].y > dev.cfg.y+dev.gui.groupbox[tab].groupBoxes[name].staticY + h then
                if IsDisabledControlPressed(0, 336) then
                    dev.gui.groupbox[tab].groupBoxes[name].curIndex = dev.gui.groupbox[tab].groupBoxes[name].curIndex - (scrollIndex or 40)
                end
            end
        end

        if dev.gui.groupbox[tab].groupBoxes[name].y > y + (h) or dev.gui.groupbox[tab].groupBoxes[name].curIndex < 0 then


            if (dev.gui.groupbox[tab].groupBoxes[name].curIndex > y + (h)) then
            dev.gui.groupbox[tab].groupBoxes[name].curIndex = 0
            end
        end

        dev.drawing.drawRect(dev.cfg.x+x,dev.cfg.y+y,w,h,{r=18,g=18,b=18,a=255})
        dev.drawing.drawRect(dev.cfg.x+x,dev.cfg.y+y,w,30,{r=21,g=21,b=21,a=255})
        dev.drawing.drawRect(dev.cfg.x+x,dev.cfg.y+y,2,30,dev.cfg.colors["theme"])
        dev.drawing.drawText(name,dev.cfg.x+x+10,dev.cfg.y+y+2,0,300,"left",{r=250,g=250,b=250,a=255})

    end


    dev.gui.groupbox[tab].groupBoxes[name].y = y + dev.gui.groupbox[tab].groupBoxes[name].curIndex + 50
    dev.gui.groupbox[tab].groupBoxes[name].x = x
end

dev.drawing.endGroupbox = function(tab,name)
    dev.gui.groupbox[tab].groupBoxes[name].endY = dev.gui.groupbox[tab].groupBoxes[name].y
end

dev.drawing.button = function(text,tab,groupbox,func,bindable)
    if not dev.vars.anim["binding_button_"..text] then
        dev.vars.anim["binding_button_"..text] = {
            keyboardAlpha = 0,
            rectW = 0,
            rectA = 0,
        }
    end
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            dev.vars.anim["binding_button_"..text].keyboardAlpha = dev.math.lerp(dev.vars.anim["binding_button_"..text].keyboardAlpha, dev.cfg.keybinds["button_"..text] and 255 or 0,0.01)
            dev.vars.anim["binding_button_"..text].rectA = dev.math.lerp(dev.vars.anim["binding_button_"..text].rectA, dev.vars.keybindingDisplayed["button_"..text] and 255 or 0,0.025)

            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=35,g=35,b=35,a=255})
            end

            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",hovered and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235})
            if (hovered) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24) and (not dev.cfg.keybinds["button_"..text] or not dev.cfg.keybinds["button_"..text].active) and not IsDisabledControlPressed(0,19)) then
                    if (func) then
                        func()
                    end
                end
                if (bindable) then
                    if (IsDisabledControlPressed(0,19) and IsDisabledControlJustPressed(0,24)) then
                        if not dev.cfg.keybinds["button_"..text] then
                            dev.cfg.keybinds["button_"..text] = {label = "...",control = "None",active = false,func = function() if (func) then func() end  end,text = text,displayedLabel = "..."}
                        end
                    end
                end
            end

            if (dev.cfg.keybinds["button_"..text]) then
                if (dev.drawing.hovered(dev.cfg.x+x+w-34,dev.cfg.y+y+2,24,16)) then
                    dev.vars.blockDragging = true
                    if (IsDisabledControlJustReleased(0,24)) then
                        if (not dev.vars.blockBinding) then
                            dev.vars.keybindingDisplayed["button_"..text] = true
                            dev.cfg.keybinds["button_"..text].active = true
                            dev.functions.binding("button_"..text)
                        end
                    end
                end
                if (dev.vars.anim["binding_button_"..text].rectA > 1) then
                    dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24,{r=31,g=32,b=41,a=math.floor(dev.vars.anim["binding_button_"..text].rectA)},4)
                    dev.drawing.drawText(dev.cfg.keybinds["button_"..text].displayedLabel,dev.cfg.x+x+w-145,dev.cfg.y+y-2,0,275,"left",{r=235,g=235,b=235,a=math.floor(dev.vars.anim["binding_button_"..text].rectA)},4)
                end
                dev.drawing.drawImage("keyboard",dev.cfg.x+x+w-38,dev.cfg.y+y+2,24,16,0,{r=85,g=92,b=115,a=math.floor(dev.vars.anim["binding_button_"..text].keyboardAlpha)},4)
            end

        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end
end

dev.drawing.checkbox = function(bool,text,tab,groupbox,func,bindable)

    if dev.cfg.bools[bool] == nil then
        dev.cfg.bools[bool] = false
    end

    if not dev.vars.anim["binding_checkbox_"..bool] then
        dev.vars.anim["binding_checkbox_"..bool] = {
            keyboardAlpha = 0,
            rectW = 0,
            rectA = 0,
        }
    end

    if not dev.vars.anim["toggle_"..bool] then
        dev.vars.anim["toggle_"..bool] = {
            a = 0,
        }
    end
    
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) or dev.drawing.hovered(dev.cfg.x+x+w-30,dev.cfg.y+y,20,20) and not dev.vars.comboBoxDisplayed
            dev.vars.anim["toggle_"..bool].a = dev.math.lerp(dev.vars.anim["toggle_"..bool].a, dev.cfg.bools[bool] and 255 or 0,0.08)
            
            dev.vars.anim["binding_checkbox_"..bool].keyboardAlpha = dev.math.lerp(dev.vars.anim["binding_checkbox_"..bool].keyboardAlpha, dev.cfg.keybinds["checkbox_"..bool] and 255 or 0,0.01)
            dev.vars.anim["binding_checkbox_"..bool].rectA = dev.math.lerp(dev.vars.anim["binding_checkbox_"..bool].rectA, dev.vars.keybindingDisplayed["checkbox_"..bool] and 255 or 0,0.05)

            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=35,g=35,b=35,a=255})
            end

            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.cfg.bools[bool]) and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235})
            dev.drawing.drawImage("checkboxBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,{r=38,g=39,b=48,a=255})
            dev.drawing.drawImage("checkboxBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,{r=dev.cfg.colors["theme"].r,g=dev.cfg.colors["theme"].g,b=dev.cfg.colors["theme"].b,a=math.floor(dev.vars.anim["toggle_"..bool].a)})
            dev.drawing.drawImage("check",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,{r=255,g=255,b=255,a=math.floor(dev.vars.anim["toggle_"..bool].a)})

            if (hovered) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24) and (not dev.cfg.keybinds["checkbox_"..bool] or not dev.cfg.keybinds["checkbox_"..bool].active) and not IsDisabledControlPressed(0,19)) then
                    dev.cfg.bools[bool] = not dev.cfg.bools[bool]
                    if (func) then
                        CreateThread(function()
                            func(dev.cfg.bools[bool])
                        end)
                    end
                end
                if (bindable) then
                    if (IsDisabledControlPressed(0,19) and IsDisabledControlJustPressed(0,24)) then
                        if not dev.cfg.keybinds["checkbox_"..bool] then
                            dev.cfg.keybinds["checkbox_"..bool] = {label = "...",control = "None",active = false,func = function() dev.cfg.bools[bool] = not dev.cfg.bools[bool] if (func) then func(dev.cfg.bools[bool]) end  end,text = text,displayedLabel = "..."}
                        end
                    end
                end
            end

            if (dev.cfg.keybinds["checkbox_"..bool]) then
                if (dev.drawing.hovered(dev.cfg.x+x+w-63,dev.cfg.y+y+2,24,16)) then
                    dev.vars.blockDragging = true
                    if (IsDisabledControlJustReleased(0,24)) then
                        if (not dev.vars.blockBinding) then
                            dev.vars.keybindingDisplayed["checkbox_"..bool] = true
                            dev.cfg.keybinds["checkbox_"..bool].active = true
                            dev.functions.binding("checkbox_"..bool)
                        end
                    end
                end
                if (dev.vars.anim["binding_checkbox_"..bool].rectA > 1) then
                    dev.drawing.drawRect(dev.cfg.x+x+w-175,dev.cfg.y+y-2,140,24,{r=235,g=235,b=235,a=math.floor(dev.vars.anim["binding_checkbox_"..bool].rectA)},4)
                    dev.drawing.drawText(dev.cfg.keybinds["checkbox_"..bool].displayedLabel,dev.cfg.x+x+w-170,dev.cfg.y+y-2,0,275,"left",{r=251,g=251,b=251,a=math.floor(dev.vars.anim["binding_checkbox_"..bool].rectA)},4)
                end
                dev.drawing.drawImage("keyboard",dev.cfg.x+x+w-63,dev.cfg.y+y+2,24,16,0,{r=85,g=92,b=115,a=math.floor(dev.vars.anim["binding_checkbox_"..bool].keyboardAlpha)},4)
            end

        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end
end

dev.drawing.slider = function (text,slider, tab, groupbox,sliderflags,func)
    if dev.cfg.sliders[slider] == nil then
        dev.cfg.sliders[slider] = sliderflags.startAt
    end
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local across = dev.math.getPercent(dev.cfg.sliders[slider], sliderflags.max)
            local filledWidth = dev.math.firstPercentOfSecond(across, 140)
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=35,g=35,b=35,a=255})
            end
            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered) and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=255})
            dev.drawing.drawText(tostring(dev.cfg.sliders[slider]),dev.cfg.x+x+w-170,dev.cfg.y+y-2,0,275,"right",{r=255,g=255,b=255,a=255})

            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y+8,140,3,{r=35,g=35,b=35,a=255})
            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y+8,filledWidth,3,dev.cfg.colors["theme"])
            dev.drawing.drawImage("smallCircleSlider",dev.cfg.x+x+w-150+filledWidth-5,dev.cfg.y+y+5,10,10,0,dev.cfg.colors["theme"])

            if (dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    if (func) then
                        func()
                    end
                end
            end

            if (dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y+6,140,7) and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if IsDisabledControlJustPressed(0,24) then
                    dev.cfg.sliders[slider..' is dragging'] = true
                end
            end

            if not IsDisabledControlPressed(0,24) then
                dev.cfg.sliders[slider..' is dragging'] = false
            end
            if dev.cfg.sliders[slider..' is dragging'] then
                dev.vars.blockDragging = true
                local right_side = dev.cfg.x+x+w-150 + 140
                local amountmouseisAcross = math.ceil(right_side - dev.vars.cx)
                if amountmouseisAcross < 0 then
                    amountmouseisAcross = 0
                end
                if amountmouseisAcross > 140 then
                    amountmouseisAcross = 140
                end

                percent = dev.math.getPercent(amountmouseisAcross, 140)
                
                
                if sliderflags.floatvalue == nil then
                    dev.cfg.sliders[slider] = math.ceil(sliderflags.max - dev.math.firstPercentOfSecond(percent, sliderflags.max))
                else
                    dev.cfg.sliders[slider] = tonumber(string.format("%."..sliderflags.floatvalue.."f", sliderflags.max - dev.math.firstPercentOfSecond(percent, sliderflags.max)))
                end
            end
            
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end
    if dev.cfg.sliders[slider] > sliderflags.max then
        dev.cfg.sliders[slider] = sliderflags.max
    end
    if dev.cfg.sliders[slider] < sliderflags.min then
        dev.cfg.sliders[slider] = sliderflags.min
    end
end

dev.drawing.comboBox = function (box,text,items,tab,groupbox,func)

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h

    if not dev.cfg.comboBoxes[box] then
        dev.cfg.comboBoxes[box] = {
            active = false,
            curOption = items[1],
            options = items,
            scroll = 0,
        }
    end



    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            local selectedItem = dev.cfg.comboBoxes[box].curOption
            local optionCount = #dev.cfg.comboBoxes[box].options
            if dev.cfg.comboBoxes[box].curOption == nil then
                renderName = "None"
            else
                renderName = dev.cfg.comboBoxes[box].curOption
            end
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=235,g=235,b=235,a=255})
            end
            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.cfg.comboBoxes[box].active) and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235})

            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24,{r = 15, g = 15, b = 15,a=255},dev.cfg.comboBoxes[box].active and 5 or 1)


            if (hovered) then
                if (IsDisabledControlJustPressed(0,24)) then
                    if (func) then
                        func()
                    end
                end
            end


            if (dev.drawing.hovered(dev.cfg.x+x+w-130,dev.cfg.y+y,120,20)) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.cfg.comboBoxes[box].active = not dev.cfg.comboBoxes[box].active
                end
            end

            if (dev.cfg.comboBoxes[box].active) then
                dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,30+(optionCount >= 7 and 150 or 22*optionCount),{r = 235, g = 235, b = 235, a= 255},5)
                dev.vars.blockDragging = true
                dev.vars.comboBoxDisplayed = true
                local selectedItem = dev.cfg.comboBoxes[box].curOption
                local optionCount = #dev.cfg.comboBoxes[box].options
                local _showing = 0
                local scrollbarHeight = math.max(12 / math.max(optionCount - 7, 1), 12 / 12)
                if (dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,30+(optionCount >= 7 and 150 or 22*optionCount))) then
                    if IsDisabledControlJustPressed(0, 15) and dev.cfg.comboBoxes[box].scroll > 0 then
                        dev.cfg.comboBoxes[box].scroll = dev.cfg.comboBoxes[box].scroll - 1
                    end
                    if IsDisabledControlJustPressed(0, 14) and dev.cfg.comboBoxes[box].scroll < optionCount-7 then
                        dev.cfg.comboBoxes[box].scroll = dev.cfg.comboBoxes[box].scroll + 1
                    end
                end
               
                for i = 1, optionCount do
                    local cleanName = dev.cfg.comboBoxes[box].options[i]:gsub('weapon_','')
                    local trimmed = dev.functions.trimStringBasedOnWidth(cleanName,100,"...",0,275)
                    textHeight = dev.cfg.y+y+2 + (i*20)
                    if i > dev.cfg.comboBoxes[box].scroll and _showing < 7 then
                        _showing = _showing + 1
    
    
                        if (dev.drawing.hovered(dev.cfg.x+x+w-145,dev.cfg.y+y-2+(_showing*22)+6,140,12)) then
                            if (IsDisabledControlJustPressed(0,24)) then
                                dev.cfg.comboBoxes[box].curOption = dev.cfg.comboBoxes[box].options[i]
                            end
                        end

                        if (IsDisabledControlJustPressed(0,24) and not dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,(optionCount >= 7 and 150 or 25*optionCount)+20)) then
                            dev.vars.comboBoxDisplayed = false
                            dev.cfg.comboBoxes[box].active = false
                        end
        
                        if optionCount > 7 then
                            dev.drawing.drawRect(dev.cfg.x+x+w-150+133,dev.cfg.y+y+25,2,150,{r=15,g=15,b=15,a=255},5)
                            dev.drawing.drawRect(dev.cfg.x+x+w-150+133, dev.cfg.y+y+25 + ((150 - scrollbarHeight * optionCount) * (dev.cfg.comboBoxes[box].scroll / (optionCount - 7))),2,scrollbarHeight * optionCount,dev.cfg.colors["theme"],5)
                        end
                        dev.drawing.drawText(trimmed,dev.cfg.x+x+w-145,dev.cfg.y+y+(_showing*22),0,250,"left",(dev.cfg.comboBoxes[box].curOption ==  dev.cfg.comboBoxes[box].options[i] or dev.drawing.hovered(dev.cfg.x+x+w-145,dev.cfg.y+y-2+(_showing*22)+6,140,12)) and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235},dev.cfg.comboBoxes[box].active and 5 or 1)
                    end
        
                end
            end

            dev.drawing.drawText(renderName:gsub('weapon_',''),dev.cfg.x+x+w-148,dev.cfg.y+y-2,0,275,"left",{r=255,g=255,b=255,a=255},dev.cfg.comboBoxes[box].active and 5 or 1)
            dev.drawing.drawText("↓",dev.cfg.x+x+w-20,dev.cfg.y+y-3,0,275,"center",dev.cfg.comboBoxes[box].active and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235},dev.cfg.comboBoxes[box].active and 5 or 1)
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end

end

dev.drawing.textBox = function(box,text,tab,groupbox,func)

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h

    if (dev.cfg.textBoxes[box]) == nil then
        dev.cfg.textBoxes[box] = {active = false, string = ""}
    end



    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local trimmedText = dev.functions.trimText(dev.cfg.textBoxes[box].string, 118,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=15,g=15,b=15,a=255})
            end
            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.cfg.textBoxes[box].active) and {r=251,g=251,b=251,a=255} or {r=235,g=235,b=235,a=235})

            dev.drawing.drawRect(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24,{r = 15, g = 15, b = 15,a=255})


            if (hovered) then
                if (IsDisabledControlJustPressed(0,24) and not dev.vars.comboBoxDisplayed) then
                    if (func) then
                        func()
                    end
                end
            end


            if (dev.drawing.hovered(dev.cfg.x+x+w-150,dev.cfg.y+y-2,140,24) and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.cfg.textBoxes[box].active = not dev.cfg.textBoxes[box].active
                end
            else 
                if IsDisabledControlJustPressed(0,24) then
                    dev.cfg.textBoxes[box].active = false
                end
            end

            if (dev.cfg.textBoxes[box].active) then

                if IsDisabledControlJustPressed(0, 177) and #dev.cfg.textBoxes[box].string > 0 and (dev.vars.textDeleteDelay or 0) < GetGameTimer() then
                    dev.vars.textDeleteDelay = GetGameTimer() + 120
                    dev.cfg.textBoxes[box].string = dev.cfg.textBoxes[box].string:sub(1, #dev.cfg.textBoxes[box].string - 1)
                end
        

                for st, control in pairs(dev.vars.keysInput) do
                    if IsDisabledControlJustPressed(0, control) then
                        if IsDisabledControlPressed(0, 21) then
                            dev.cfg.textBoxes[box].string = dev.cfg.textBoxes[box].string..st:upper()
                        else
                            dev.cfg.textBoxes[box].string = dev.cfg.textBoxes[box].string..st:lower()
                        end
                    end
                end

                if IsDisabledControlJustPressed(0, 191) then
                    dev.cfg.textBoxes[box].active = false
                end
            end
            if (dev.cfg.textBoxes[box].string == "") then
                dev.drawing.drawText("Digite algo",dev.cfg.x+x+w-148,dev.cfg.y+y-2,0,275,"left",dev.cfg.textBoxes[box].active and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235},1)
            end
            dev.drawing.drawText(trimmedText,dev.cfg.x+x+w-148,dev.cfg.y+y-2,0,275,"left",dev.cfg.textBoxes[box].active and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235},1)
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end

end

dev.drawing.colorpicker = function (text,color,tab,groupbox,func)

    local convertedR,convertedG,convertedB

    if not dev.cfg.colors[color] then
        dev.cfg.colors[color] = {
            r=255,
            g=255,
            b=255,
            a=255,
            otherstuff = {
                h = 0, 
                s = 0,
                v = 100,
                timer = 0,
                colorpickerA = 0,
            }
        }
    end

    if (not dev.cfg.colors[color].otherstuff) then
        local convertedR,convertedG,convertedB = dev.math.RGBtoHSV(dev.cfg.colors[color])
        dev.cfg.colors[color].otherstuff = {
            h = convertedR,
            s = convertedG,
            v = convertedB,
            timer = 0,
            colorpickerA = 0,
        }
    end

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed
            dev.cfg.colors[color].otherstuff.colorpickerA = dev.math.lerp(dev.cfg.colors[color].otherstuff.colorpickerA, dev.vars.selectedColorpicker == color and 255 or 0,0.05)
            if (dev.gui.groupbox[tab].groupBoxes[groupbox].y ~= dev.gui.groupbox[tab].groupBoxes[groupbox].startY) then
                dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y-10,w-20,1,{r=35,g=35,b=35,a=255})
            end

            dev.drawing.drawText(text,dev.cfg.x+x+10,dev.cfg.y+y-2,0,275,"left",(hovered or dev.vars.selectedColorpicker == color) and {r=255,g=255,b=255,a=255} or {r=235,g=235,b=235,a=235})
            dev.drawing.drawImage("colorpickerBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0.0,{r=255,g=255,b=255,a=255})
            dev.drawing.drawImage("checkboxBackground",dev.cfg.x+x+w-30,dev.cfg.y+y,20,20,0,dev.cfg.colors[color])
            
            if (dev.drawing.hovered(dev.cfg.x+x+w-30,dev.cfg.y+y,20,20) and dev.vars.selectedColorpicker == nil and not dev.vars.comboBoxDisplayed) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.vars.selectedColorpicker = color
                end
            end

            if (dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y+2,textW,14) and not dev.vars.comboBoxDisplayed) then
                if (IsDisabledControlJustPressed(0,24)) then
                    if (func) then
                        func()
                    end
                end
            end

            if (math.floor(dev.cfg.colors[color].otherstuff.colorpickerA) > 1) then
                dev.vars.blockDragging = true
                dev.cfg.colors[color].otherstuff.timer = dev.cfg.colors[color].otherstuff.timer + 1
                local sR, sG, sB = dev.math.HSVtoRGB(dev.cfg.colors[color].otherstuff.h, 100,100)
                local sR1, sG1, sB1 = dev.math.HSVtoRGB(dev.cfg.colors[color].otherstuff.h, dev.cfg.colors[color].otherstuff.s, dev.cfg.colors[color].otherstuff.v)
                dev.drawing.drawRect(dev.cfg.x+x+w-20,dev.cfg.y+y+10,254,220,{r=31,g=34,b=43,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)
                dev.drawing.drawText(text,dev.cfg.x+x+w-10,dev.cfg.y+y+15,0,250,"left",{r=251,g=251,b=251,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)

                dev.drawing.drawRect(dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180,{r=255,g=255,b=255,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawImage("gradient",dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180,0.0,{r=sR,g=sG,b=sB,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawImage("gradient",dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180,90.0,{r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w-10+dev.cfg.colors[color].otherstuff.s / 100 * 174,(dev.cfg.y+y+40+174) - dev.cfg.colors[color].otherstuff.v / 100 * (174), 6, 6, {r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w-9+dev.cfg.colors[color].otherstuff.s / 100 * 174,(dev.cfg.y+y+41+174) - dev.cfg.colors[color].otherstuff.v / 100 * (174), 4, 4, {r=sR1,g=sG1,b=sB1,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)

                dev.drawing.drawImage("rainbowBar",dev.cfg.x+x+w+180,dev.cfg.y+y+40,16,180,0.0,{r=255,g=255,b=255,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)
                dev.drawing.drawRect(dev.cfg.x+x+w+180,dev.cfg.y+y+40+dev.cfg.colors[color].otherstuff.h / 360 * 176, 15,4, {r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w+181,dev.cfg.y+y+41+dev.cfg.colors[color].otherstuff.h / 360 * 176, 13,2, {r=sR1, g=sG1, b=sB1,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)

                dev.drawing.drawImage("fadeBackground",dev.cfg.x+x+w+206,dev.cfg.y+y+40,16,180,0.0,{r=sR1,g=sG1,b=sB1,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)
                dev.drawing.drawRect(dev.cfg.x+x+w+206,dev.cfg.y+y+216-dev.cfg.colors[color].a / 255 * 176, 16,4, {r=0,g=0,b=0,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)
                dev.drawing.drawRect(dev.cfg.x+x+w+207,dev.cfg.y+y+217-dev.cfg.colors[color].a / 255 * 176, 14,2, {r=sR1, g=sG1, b=sB1,a=dev.vars.selectedColorpicker ~= nil and dev.cfg.colors[color].a or math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},6)

                dev.drawing.drawText(dev.math.RGBtoHEX({sR1,sG1,sB1}),dev.cfg.x+x+w+226,dev.cfg.y+y+15,0,250,"right",{r=251,g=251,b=251,a=math.floor(dev.cfg.colors[color].otherstuff.colorpickerA)},5)


                if dev.drawing.hovered(dev.cfg.x+x+w+180,dev.cfg.y+y+40,16,180) and IsDisabledControlJustPressed(0, 24) then 
                    dev.vars.pickerVariable = "FLAG"
                elseif dev.drawing.hovered(dev.cfg.x+x+w-10,dev.cfg.y+y+40,180,180) and IsDisabledControlJustPressed(0, 24) then 
                    dev.vars.pickerVariable = "RGB"
                elseif dev.drawing.hovered(dev.cfg.x+x+w+206,dev.cfg.y+y+40,16,180) and IsDisabledControlJustPressed(0, 24) then 
                    dev.vars.pickerVariable = "ALPHA"
                end

                if dev.vars.pickerVariable == "FLAG" then 
                    dev.cfg.colors[color].otherstuff.h = dev.math.screenValue(dev.vars.cy, dev.cfg.y+y+40, 180, 0, 360)
                    dev.cfg.colors[color].otherstuff.h = math.floor(math.clamp(dev.cfg.colors[color].otherstuff.h, 0, 360))
                elseif dev.vars.pickerVariable == "RGB" then 
                    dev.cfg.colors[color].otherstuff.s = dev.math.screenValue(dev.vars.cx, dev.cfg.x+x+w-10, 176, 0, 100)
                    dev.cfg.colors[color].otherstuff.s = math.floor(math.clamp(dev.cfg.colors[color].otherstuff.s, 0, 100))
                    dev.cfg.colors[color].otherstuff.v = dev.math.screenValue(dev.vars.cy, dev.cfg.y+y+40, 176, 100, 0)
                    dev.cfg.colors[color].otherstuff.v = math.floor(math.clamp(dev.cfg.colors[color].otherstuff.v, 0, 100))
                elseif dev.vars.pickerVariable == "ALPHA" then 
                    dev.cfg.colors[color].a = dev.math.screenValue(dev.vars.cy, dev.cfg.y+y+40,176, 255, 0)
                    dev.cfg.colors[color].a = math.floor(math.clamp(dev.cfg.colors[color].a, 0, 255))
                end

                if (IsDisabledControlJustReleased(0,24)) then
                    dev.vars.pickerVariable = nil
                end

                dev.cfg.colors[color].r,dev.cfg.colors[color].g,dev.cfg.colors[color].b,dev.cfg.colors[color].a = sR1,sG1,sB1,dev.cfg.colors[color].a
            
                if (not dev.drawing.hovered(dev.cfg.x+x+w-30,dev.cfg.y+y,254,260) and IsDisabledControlJustPressed(0,24) and dev.cfg.colors[color].otherstuff.timer > 10) then
                    dev.cfg.colors[color].otherstuff.timer = 0
                    dev.vars.selectedColorpicker = nil
                elseif IsDisabledControlJustPressed(0, 191) then 
                    dev.vars.selectedColorpicker = nil
                end
            end
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + 40
    end

end

dev.drawing.playerButton = function(text,tab,groupbox,pedId,func)
    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    local groupboxScrollIndex = dev.gui.groupbox[tab].groupBoxes[groupbox].scroll
    if (dev.cfg.currentTab == tab) then
        if dev.cfg.y+y-20 > dev.cfg.y+stay and y < stay+h-20 then
            local textW = dev.drawing.getTextWidth(text,0,275)
            local hovered = dev.drawing.hovered(dev.cfg.x+x+10,dev.cfg.y+y,w-20,60) and not dev.vars.comboBoxDisplayed

            dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y,w-20,60,hovered and {r = 35, g = 35, b = 35,a=255} or {r = 22, g = 22, b = 22,a=255})
            dev.drawing.drawRect(dev.cfg.x+x+10,dev.cfg.y+y+60,w-20,1,dev.cfg.colors["theme"])

            dev.drawing.drawText(text,dev.cfg.x+x+20,dev.cfg.y+y+5,0,275,"left",{r=255,g=255,b=255,a=255})
            dev.drawing.drawText("Está a "..math.floor(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(GetPlayerPed(pedId)))).."m de distância de você.",dev.cfg.x+x+20,dev.cfg.y+y+32,0,275,"left",{r=135,g=135,b=135,a=255})
            if (dev.vars.selectedPlayer == pedId) then
                dev.drawing.drawImage("check",dev.cfg.x+x+w-40,dev.cfg.y+y+20,20,20,0.0,{r=255,g=255,b=255,a=255})
            end
            if (hovered) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    if (dev.vars.selectedPlayer == pedId) then
                        dev.vars.selectedPlayer = nil
                    else
                        dev.vars.selectedPlayer = pedId
                    end
                end

            end

        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + groupboxScrollIndex
    end
end

dev.drawing.vehicleButton = function(text, tab, groupbox, vehicleId, func)
    if not dev.gui.groupbox[tab] then
        --print("Erro: O tab '" .. tostring(tab) .. "' não existe.")
        return
    end
    
    if not dev.gui.groupbox[tab].groupBoxes[groupbox] then
        --print("Erro: O groupbox '" .. tostring(groupbox) .. "' não existe no tab '" .. tostring(tab) .. "'.")
        return
    end

    local x = dev.gui.groupbox[tab].groupBoxes[groupbox].x
    local y = dev.gui.groupbox[tab].groupBoxes[groupbox].y
    local stay = dev.gui.groupbox[tab].groupBoxes[groupbox].staticY
    local w = dev.gui.groupbox[tab].groupBoxes[groupbox].w
    local h = dev.gui.groupbox[tab].groupBoxes[groupbox].h
    local groupboxScrollIndex = dev.gui.groupbox[tab].groupBoxes[groupbox].scroll

    if dev.cfg.currentTab == tab then
        if dev.cfg.y + y - 20 > dev.cfg.y + stay and y < stay + h - 20 then
            local textW = dev.drawing.getTextWidth(text, 0, 275)
            local hovered = dev.drawing.hovered(dev.cfg.x + x + 10, dev.cfg.y + y, w - 20, 60) and not dev.vars.comboBoxDisplayed

            dev.drawing.drawRect(dev.cfg.x + x + 10, dev.cfg.y + y, w - 20, 60, hovered and {r = 35, g = 35, b = 35,a=255} or {r = 22, g = 22, b = 22,a=255})
            dev.drawing.drawRect(dev.cfg.x + x + 10, dev.cfg.y + y + 60, w - 20, 1, dev.cfg.colors["theme"])

            dev.drawing.drawText(text, dev.cfg.x + x + 20, dev.cfg.y + y + 5, 0, 275, "left", {r = 255, g = 255, b = 255, a = 255})
            
            if DoesEntityExist(vehicleId) then
                local vehicleCoords = GetEntityCoords(vehicleId)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = math.floor(GetDistanceBetweenCoords(playerCoords, vehicleCoords))
                dev.drawing.drawText("Está " .. distance .. "m de distância de você.", dev.cfg.x + x + 20, dev.cfg.y + y + 32, 0, 275, "left", {r = 135, g = 135, b = 135, a = 255})
            else
                dev.drawing.drawText("Veículo não encontrado!", dev.cfg.x + x + 20, dev.cfg.y + y + 32, 0, 275, "left", {r = 135, g = 135, b = 135, a = 255})
            end

            if dev.vars.selectedVehicle == vehicleId then
                dev.drawing.drawImage("check", dev.cfg.x + x + w - 40, dev.cfg.y + y + 20, 20, 20, 0.0, {r = 255, g = 255, b = 255, a = 255})
            end

            if hovered then
                dev.vars.blockDragging = true
                if IsDisabledControlJustPressed(0, 24) then
                    if dev.vars.selectedVehicle == vehicleId then
                        dev.vars.selectedVehicle = nil
                    else
                        dev.vars.selectedVehicle = vehicleId
                    end
                    if func then
                        func(vehicleId)
                    end
                end
            end
        end
        dev.gui.groupbox[tab].groupBoxes[groupbox].y = y + groupboxScrollIndex
    end
end



dev.drawing.notify = function(text, ntype, duration, r, g, b)
    local notification = {
        x = dev.vars.sW,
        text = tostring(text),
        duration = duration or 5000,
        startTime = GetGameTimer(),
        color = { r = r, g = g, b = b, a = 255 },
        type = tostring(ntype) 
    }
    dev.notifications[#dev.notifications + 1] = notification
end

dev.drawing.renderTabs = function()
    for k, v in ipairs(dev.tabs) do

        if (not dev.vars.tabsVars[v[2]]) then
            dev.vars.tabsVars[v[2]] = {
                w = 0,
                a = 0,
                iconColors = {r=30,g=30,b=30,a=255},
            }
        end

        dev.vars.tabsVars[v[2]].w = dev.math.lerp(dev.vars.tabsVars[v[2]].w, dev.cfg.currentTab == v[2] and 40 or 0,0.06)
        dev.vars.tabsVars[v[2]].a = dev.math.lerp(dev.vars.tabsVars[v[2]].a, dev.cfg.currentTab == v[2] and 255 or 0,0.055)

        dev.vars.tabsVars[v[2]].iconColors.r = dev.math.lerp(dev.vars.tabsVars[v[2]].iconColors.r, dev.cfg.currentTab == v[2] and dev.cfg.colors["theme"].r or 230,0.055)
        dev.vars.tabsVars[v[2]].iconColors.g = dev.math.lerp(dev.vars.tabsVars[v[2]].iconColors.g, dev.cfg.currentTab == v[2] and dev.cfg.colors["theme"].g or 230,0.055)
        dev.vars.tabsVars[v[2]].iconColors.b = dev.math.lerp(dev.vars.tabsVars[v[2]].iconColors.b, dev.cfg.currentTab == v[2] and dev.cfg.colors["theme"].b or 230,0.055)


        if (dev.drawing.hovered(dev.cfg.x + 10, dev.cfg.y + 80 + dev.vars.tabsY, 40, 40)) then
            dev.vars.blockDragging = true
            if (IsDisabledControlJustPressed(0,24)) then
                dev.cfg.currentTab = v[2]
            end
        end
        if dev.vars.tabsVars[v[2]].a > 1 then
            dev.drawing.drawRect(dev.cfg.x + 20 + 20 -  dev.vars.tabsVars[v[2]].w/2, dev.cfg.y + 80 + dev.vars.tabsY, dev.vars.tabsVars[v[2]].w, 40, { r = 40, g = 40, b = 40, a = math.floor(dev.vars.tabsVars[v[2]].a) })
        end
        if (dev.images[v[2].."_icon"]) then
            dev.drawing.drawImage(v[2].."_icon",dev.cfg.x + 31,dev.cfg.y + 91 + dev.vars.tabsY,25,25,0.0,{r = math.floor(dev.vars.tabsVars[v[2]].iconColors.r),g = math.floor(dev.vars.tabsVars[v[2]].iconColors.g),b = math.floor(dev.vars.tabsVars[v[2]].iconColors.b),a = dev.vars.tabsVars[v[2]].iconColors.a})
        end
        dev.vars.tabsY = dev.vars.tabsY + 60
    end
end

dev.drawing.renderSubtabs = function()
    if (dev.menuFeatures[dev.cfg.currentTab] and dev.menuFeatures[dev.cfg.currentTab].subtabs) then
        if not dev.vars.subtabsPos[dev.cfg.currentTab] then
            dev.vars.subtabsPos[dev.cfg.currentTab] = 0
        end
        if not dev.vars.subTabsVars[dev.cfg.currentTab] then
            dev.vars.subTabsVars[dev.cfg.currentTab] = {}
        end

        for k,v in pairs(dev.menuFeatures[dev.cfg.currentTab].subtabs) do
            if not dev.vars.subTabsVars[dev.cfg.currentTab][v] then
                dev.vars.subTabsVars[dev.cfg.currentTab][v] = {
                    y = 0,
                    rectW = 0,
                    color = {r=38,g=39,b=48,a=255},
                }
            end

            local w = dev.drawing.getTextWidth(v,0,275)-2

            dev.vars.subTabsVars[dev.cfg.currentTab][v].y = dev.math.lerp(dev.vars.subTabsVars[dev.cfg.currentTab][v].y, dev.menuFeatures[dev.cfg.currentTab].selTab == v and -6 or 0,0.05)
            dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW = dev.math.lerp(dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW, dev.menuFeatures[dev.cfg.currentTab].selTab == v and w+10 or 0,0.1)
            dev.vars.subTabsVars[dev.cfg.currentTab][v].color.a = dev.math.lerp(dev.vars.subTabsVars[dev.cfg.currentTab][v].color.a, dev.menuFeatures[dev.cfg.currentTab].selTab == v and 255 or 0,0.055)

            dev.drawing.drawText(v,dev.cfg.x+101+dev.vars.subtabsPos[dev.cfg.currentTab],dev.cfg.y+18,0,275,"left",dev.menuFeatures[dev.cfg.currentTab].selTab == v and dev.cfg.colors["theme"] or {r=235,g=235,b=235,a=255})
            dev.drawing.drawRect(dev.cfg.x+100+dev.vars.subtabsPos[dev.cfg.currentTab]+w/2 - dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW/2,dev.cfg.y+15,dev.vars.subTabsVars[dev.cfg.currentTab][v].rectW,30,{r = dev.vars.subTabsVars[dev.cfg.currentTab][v].color.r,g = dev.vars.subTabsVars[dev.cfg.currentTab][v].color.g, b = dev.vars.subTabsVars[dev.cfg.currentTab][v].color.b, a = math.floor(dev.vars.subTabsVars[dev.cfg.currentTab][v].color.a)})
            
            if (dev.drawing.hovered(dev.cfg.x+100+dev.vars.subtabsPos[dev.cfg.currentTab],dev.cfg.y+15,w+10,30)) then
                dev.vars.blockDragging = true
                if (IsDisabledControlJustPressed(0,24)) then
                    dev.menuFeatures[dev.cfg.currentTab].selTab = v
                end
            end

            dev.vars.subtabsPos[dev.cfg.currentTab] = dev.vars.subtabsPos[dev.cfg.currentTab] + w + 25
        end
    end
end

dev.drawing.dragging = function ()
    if (not dev.vars.blockDragging) then
        if (dev.drawing.hovered(dev.cfg.x,dev.cfg.y,dev.cfg.w,dev.cfg.h)) then
            if (IsDisabledControlJustPressed(0,24)) then
                dev.vars.dragging = true
            end
        end
        if (dev.vars.dragging) then
            if xdist == nil then
                xdist = dev.vars.cx - dev.cfg.x
            end
            if ydist == nil then
                ydist = dev.vars.cy - dev.cfg.y
            end

            dev.cfg.x = dev.vars.cx - xdist
            dev.cfg.y = dev.vars.cy - ydist
        else
            xdist = nil
            ydist = nil
        end

        if (not IsDisabledControlPressed(0,24)) then
            dev.vars.dragging = false
        end
    end
    dev.vars.blockDragging = false
end

dev.drawing.searchBar = function()
    local currentSearchText = (dev.cfg.currentTab == "Online" and dev.menuFeatures["Online"].selTab == "Jogadores") and dev.vars.onlineSearchText or dev.vars.searchText 
    local searchText = (dev.cfg.currentTab == "Online" and dev.menuFeatures["Online"].selTab == "Jogadores") and "Procurar jogadores" or "Procurar funções"
    local trimmedString = dev.functions.trimText(searchText, dev.vars.anim.searchBarWidth, 0, 275)
    dev.vars.anim.searchBarWidth = dev.math.lerp(dev.vars.anim.searchBarWidth, (dev.vars.searching or currentSearchText ~= "") and 250 or 30, dev.vars.searching and 0.03 or 0.05)
    dev.vars.anim.searchBarTextAlpha = dev.math.lerp(dev.vars.anim.searchBarTextAlpha, dev.vars.anim.searchBarWidth >= 200 and 255 or 0, 0.05)
    local hovered = dev.drawing.hovered(dev.cfg.x + dev.cfg.w - (dev.vars.anim.searchBarWidth + 15), dev.cfg.y + 15, math.floor(dev.vars.anim.searchBarWidth), 30)
    
    dev.drawing.drawRect(dev.cfg.x + dev.cfg.w - (dev.vars.anim.searchBarWidth + 15), dev.cfg.y + 15, dev.vars.anim.searchBarWidth, 30, {r = 30, g = 30, b = 30, a = 255})
    dev.drawing.drawImage("Search_icon", dev.cfg.x + dev.cfg.w - 37, dev.cfg.y + 21, 20, 20, 0, {r = 255, g = 255, b = 255, a = 255}, 1)
    
    if math.floor(dev.vars.anim.searchBarWidth) > 30 and currentSearchText == "" then
        dev.drawing.drawText(trimmedString, dev.cfg.x + dev.cfg.w - (dev.vars.anim.searchBarWidth + 15) + 5, dev.cfg.y + 18, 0, 275, "left", {r = 79, g = 85, b = 106, a = math.ceil(dev.vars.anim.searchBarTextAlpha)}, 5)
    end
    
    if IsDisabledControlJustPressed(0, 24) then
        if hovered then
            dev.vars.searching = true
        else
            dev.vars.searching = false
        end
    end
    
    if dev.vars.searching then
        for k, v in pairs(dev.vars.writtableKeys) do
            if IsDisabledControlJustPressed(0, v) and not IsDisabledControlPressed(0, 21) then 
                currentSearchText = currentSearchText .. k
            end
            if IsDisabledControlPressed(0, 21) and IsDisabledControlJustPressed(0, v) then 
                currentSearchText = currentSearchText .. string.upper(k)
            end
        end
    
        if IsDisabledControlPressed(0, 177) and (dev.vars.backDelay or 0) < GetGameTimer() then
            dev.vars.backDelay = GetGameTimer() + 100
            currentSearchText = currentSearchText:sub(1, -2)
        end
    
        if IsDisabledControlJustPressed(0, 191) then
            dev.vars.searching = false
        end
    
        if IsDisabledControlJustPressed(0, 22) then
            currentSearchText = currentSearchText .. " "
        end
    
        if IsDisabledControlPressed(0, 21) and IsDisabledControlJustPressed(0, 157) then
            currentSearchText = currentSearchText:sub(1, -2)
            currentSearchText = currentSearchText .. '!'
        end 
    
        if IsDisabledControlPressed(0, 21) and IsDisabledControlJustPressed(0, 84) then
            currentSearchText = currentSearchText:sub(1, -2)
            currentSearchText = currentSearchText .. '_'
        end
    
        -- Update the actual variable
        if dev.cfg.currentTab == "Online" then
            dev.vars.onlineSearchText = currentSearchText
        else
            dev.vars.searchText = currentSearchText
        end
    end
    

    dev.drawing.drawText(currentSearchText,dev.cfg.x+dev.cfg.w-(dev.vars.anim.searchBarWidth+15)+5,dev.cfg.y+18,0,275,"left",dev.vars.searching and {r=251,g=251,b=251,a=math.ceil(dev.vars.anim.searchBarTextAlpha)} or {r=79,g=85,b=106,a=math.ceil(dev.vars.anim.searchBarTextAlpha)},5)

end

dev.functions.playerList = function()
    local activePlayers = GetActivePlayers()

    table.sort(activePlayers, function(a, b) return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(a), false), true) < GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(b), false), true) end)

    -- Update the "All Players" list
    for k, player in pairs(activePlayers) do
        local playerName = GetPlayerName(player)
        local playerCoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), playerCoords)

        if string.find(string.lower(playerName), string.lower(tostring(dev.vars.onlineSearchText))) or dev.vars.onlineSearchText == "" then
            dev.drawing.playerButton(playerName,"Online","Lista de Jogadores",player)
        end

    end
end



dev.rendering = {}

local drawingFunctions = {
    groupbox = dev.drawing.groupbox,
    checkbox = dev.drawing.checkbox,
    bindCheckbox = dev.drawing.keybindCheckbox,
    button = dev.drawing.button,
    slider = dev.drawing.slider,
    comboBox = dev.drawing.comboBox,
    colorpicker = dev.drawing.colorpicker,
    textBox = dev.drawing.textBox,
    endGroupbox = dev.drawing.endGroupbox,
    playerButton = dev.drawing.playerButton,
    vehicleButton = dev.drawing.vehicleButton,
}

dev.rendering.menuRender = function()
    if (dev.vars.searchText == "") then
        if (dev.menuFeatures[dev.cfg.currentTab] and dev.menuFeatures[dev.cfg.currentTab][dev.menuFeatures[dev.cfg.currentTab].selTab]) then
            for _, feature in ipairs(dev.menuFeatures[dev.cfg.currentTab][dev.menuFeatures[dev.cfg.currentTab].selTab]) do
                local drawFunc = drawingFunctions[feature.type]
                if drawFunc then
                    if feature.type == "groupbox" then
                        drawFunc(feature.x, feature.y, feature.w, feature.h, dev.cfg.currentTab, feature.name,feature.scrollIndex)
                    elseif feature.type == "checkbox" or feature.type == "bindCheckbox" then
                        drawFunc(feature.bind or feature.bool, feature.text, dev.cfg.currentTab, feature.groupbox, feature.func, feature.bindable)
                    elseif feature.type == "button" then
                        drawFunc(feature.text, dev.cfg.currentTab, feature.groupbox, feature.func, feature.bindable)
                    elseif feature.type == "slider" then
                        drawFunc(feature.text, feature.slider, dev.cfg.currentTab, feature.groupbox, feature.sliderflags, feature.func)
                    elseif feature.type == "comboBox" then
                        drawFunc(feature.box, feature.text, feature.items, dev.cfg.currentTab, feature.groupbox, feature.func)
                    elseif feature.type == "colorpicker" then
                        drawFunc(feature.text, feature.color, dev.cfg.currentTab, feature.groupbox, feature.func)
                    elseif feature.type == "textBox" then
                        drawFunc(feature.box, feature.text, dev.cfg.currentTab, feature.groupbox, feature.func)
                    elseif feature.type == "playerButton" and (dev.cfg.currentTab == "Online" and dev.menuFeatures["Online"].selTab == "Jogadores") and (string.find(feature.text,dev.vars.onlineSearchText) or dev.vars.onlineSearchText == "") then
                        drawFunc(feature.text, dev.cfg.currentTab, feature.groupbox,feature.pedId, feature.func)
                    elseif feature.type == "vehicleButton" and (dev.cfg.currentTab == "Vehicles" and dev.menuFeatures["Vehicles"].selTab == "Veiculos") then
                        drawFunc(feature.text, dev.cfg.currentTab, feature.groupbox,feature.pedId, feature.func)
                    elseif feature.type == "endGroupbox" then
                        drawFunc(dev.cfg.currentTab, feature.name)
                    end
                end
            end
        end
    else
        if (dev.cfg.currentTab ~= "Online") then
            dev.drawing.groupbox(100,80,660,490,dev.cfg.currentTab,"Pesquisa")
            for k, tab in pairs(dev.menuFeatures) do
                for tabName, tabContent in pairs(tab) do
                    if type(tabContent) == "table" then
                        for _, feature in ipairs(tabContent) do
                            if feature.text and string.find(string.lower(feature.text), string.lower(dev.vars.searchText)) then
                                local drawFunc = drawingFunctions[feature.type]
                                if drawFunc then
                                    if feature.type == "button" then
                                        drawFunc(feature.text, dev.cfg.currentTab, "Pesquisa", feature.func, feature.bindable)
                                    elseif feature.type == "checkbox" or feature.type == "bindCheckbox" then
                                        drawFunc(feature.bind or feature.bool, feature.text, dev.cfg.currentTab, "Pesquisa", feature.func)
                                    elseif feature.type == "slider" then
                                        drawFunc(feature.text, feature.slider, dev.cfg.currentTab, "Pesquisa", feature.sliderflags, feature.func)
                                    elseif feature.type == "comboBox" then
                                        drawFunc(feature.box, feature.text, feature.items, dev.cfg.currentTab, "Pesquisa", feature.func)
                                    elseif feature.type == "colorpicker" then
                                        drawFunc(feature.text, feature.color, dev.cfg.currentTab, "Pesquisa", feature.func)
                                    elseif feature.type == "textBox" then
                                        drawFunc(feature.box, feature.text, dev.cfg.currentTab, "Pesquisa", feature.func)
                                    else
                                        drawFunc(feature.text, dev.cfg.currentTab, "Pesquisa", feature.func)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            dev.drawing.endGroupbox(dev.cfg.currentTab,"Pesquisa")
        end
    end
end

dev.rendering.menuEmbed = function()
    dev.rendering.menuInit()
    dev.rendering.renderMenu()
end

dev.rendering.menuInit = function()
    if (IsDisabledControlJustPressed(0,dev.cfg.binds["menu"].control)) then
        dev.gui.displayed = not dev.gui.displayed
    end
end

dev.rendering.cursor = function()
    DisableControlAction(0, 0, true)
    DisableControlAction(0, 1, true)
    DisableControlAction(0, 2, true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 322, true)
    DisableControlAction(0, 106, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 23, true)
    DisableControlAction(0, 16, true)
    DisableControlAction(0, 17, true)
    dev.drawing.drawImage("cursor",dev.vars.cx,dev.vars.cy-1,17,23,0.0,{r=255,g=255,b=255,a=255},7)
end

dev.rendering.renderMenu = function()
    dev.vars.cx,dev.vars.cy = Citizen.InvokeNative(0xBDBA226F, Citizen["PointerValueInt"](), Citizen["PointerValueInt"]())
    dev.vars.categoriesY = {}
    dev.vars.subtabsPos = {}
    dev.vars.comboBoxDisplayed = false
    dev.vars.colorPickerDisplayed = false
    dev.vars.tabsY = 0
    if (dev.gui.displayed) then
        dev.rendering.menuGraphicUI()
        dev.drawing.dragging()
    end
end

dev.rendering.menuGraphicUI = function()
    dev.drawing.drawRect(dev.cfg.x,dev.cfg.y,dev.cfg.w,dev.cfg.h,{r=15,g=15,b=15,a=255})
    dev.drawing.drawRect(dev.cfg.x+80,dev.cfg.y,dev.cfg.w-80,60,{r=18,g=18,b=18,a=255})
    dev.drawing.drawRect(dev.cfg.x,dev.cfg.y,80,dev.cfg.h,{r=20,g=20,b=20,a=255})
    dev.drawing.drawImage("logo",dev.cfg.x+9,dev.cfg.y+16,60,60,0.0,{r=255,g=255,b=255,a=255},7)
    dev.drawing.searchBar()
    dev.drawing.renderTabs()
    dev.rendering.menuRender()
    dev.drawing.renderSubtabs()
    dev.functions.playerList()
    dev.rendering.cursor()

    --Editado
    dev.functions.showVehicleList()
end

-- eventos
events = {}

events.onReady = function ()
    -- # Def Resources
    resourceModule.defGroup()
    resourceModule.defProtect()
    resourceModule.defResourceInject()
    dev.functions.registerInjectAPI()

end

events.onReady()
CreateThread(function()
    pcall(function()
        for k, v in pairs(dev.images) do
            local random = math.random(100000,999999)
            local runtimeTxd = CreateRuntimeTxd(random.."1")
            local dui = CreateDui(v[1], v[2], v[3])
            
            CreateRuntimeTextureFromDuiHandle(runtimeTxd, random.."2", GetDuiHandle(dui))
        
            dev.images[k] = {random.."1", random.."2", v[2], v[3]}
        end
    end)
end)


CreateThread(function()
    while dev.enabled do
        Wait(0)
        if psycho.vars.breakThreads then
            break
        end

        dev.rendering.menuEmbed()
    end
end)

CreateThread(function()
    while dev.enabled do
        Wait(1)
        if psycho.vars.breakThreads then
            break
        end

        for k,v in pairs(dev.cfg.keybinds) do
            if (v.control ~= "None" and IsDisabledControlJustPressed(0,v.control) and v.func) and not dev.vars.blockBinding then
                v.func()
            end
        end
    end
end)

CreateThread(function()
    while dev.enabled do
        Wait(0)
        if psycho.vars.breakThreads then
            break
        end

        if (dev.cfg.bools["disableveh_selplayer"]) then
            if (dev.vars.selectedPlayer) then
                local playerPed = GetPlayerPed(dev.vars.selectedPlayer)
                local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            
                if playerVehicle ~= 0 then
                    SetVehicleExclusiveDriver_2(playerVehicle, PlayerPedId(),1)
                end
            end
        end
    

        if (dev.cfg.bools["godmode"]) then
            SetEntityOnlyDamagedByRelationshipGroup(PlayerPedId(), dev.cfg.bools["godmode"],
            "L91U83C01A61S" .. GetHashKey(math.random(100000, 999999)))
        end

        if (dev.cfg.bools["infiniteStamina"]) then
            ResetPlayerStamina(PlayerId())
        end

        if (dev.cfg.bools["superPunch"]) then
            SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_UNARMED'), 50.0)
        end



        if (dev.cfg.bools["superVelocity"]) then
            if IsDisabledControlPressed(0, 34) or IsDisabledControlPressed(0, 33) or IsDisabledControlPressed(0, 32) or IsDisabledControlPressed(0, 35) then
                if IsPedRagdoll(PlayerPedId()) then

                else
                    SetEntityVelocity(
                        PlayerPedId(),
                        GetOffsetFromEntityInWorldCoords(
                            PlayerPedId(),
                            0.0,
                            20.0,
                            GetEntityVelocity(PlayerPedId())[3]
                        ) - GetEntityCoords(
                            PlayerPedId()
                        )
                    )
                end
            end
        end

        if (dev.cfg.bools["superJump"]) then
            SetPedCanRagdoll(PlayerPedId(), false)
            if IsDisabledControlJustPressed(0, 22) then
                ApplyForceToEntity(PlayerPedId(), 3, 0.0, 0.0, 30.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 1, 1)
            end
        end

        if (dev.cfg.bools["noRagdoll"]) then
            SetPedCanBeKnockedOffVehicle(PlayerPedId(), false)
            SetPedCanRagdoll(PlayerPedId(), false)
        end

        if (dev.cfg.bools["autoRepair"]) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                Citizen.InvokeNative(0x953DA1E1B12C0491, vehicle)
                Citizen.InvokeNative(0x115722B1B9C14C1C, vehicle)
                Citizen.InvokeNative(0xB77D05AC8C78AADB, vehicle, 1000.0)
                Citizen.InvokeNative(0x45F6D8EEF34ABEF1, vehicle, 1000.0)
                Citizen.InvokeNative(0x70DB57649FA8D0D8, vehicle, 1000.0)
        end

        if (dev.cfg.bools["hornBoost"]) then
            if IsDisabledControlPressed(0, 38) then
                SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), dev.cfg.sliders['hornForce']+0.001 or 80)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local y = 65
        for i, notification in pairs(dev.notifications) do
            local nW = dev.drawing.getTextWidth(notification.text,0,300)
            local space = 20
            local width = nW+45
            local height = 65
            local remainingTime = notification.duration - (GetGameTimer() - notification.startTime)
            notification.x = dev.math.lerp(notification.x,remainingTime > 0 and dev.vars.sW - (nW+55) or dev.vars.sW+25,0.08)
            
            local text = notification.text

            
            height = height

            local barWidth = remainingTime > 0 and width * (remainingTime / notification.duration) or 0
            dev.drawing.drawRect(notification.x,y,width,height,{r=25,g=25,b=25,a=255},5)
            dev.drawing.drawText(notification.type,notification.x + 5,y+5,0,325,"left",{r=255,g=255,b=255,a=255},5)
            dev.drawing.drawText(notification.text,notification.x + 5,y+35,0,300,"left",{r=215,g=215,b=215,a=255},5)
            dev.drawing.drawRect(notification.x,y+height-2,barWidth,2,notification.color,5)

            if (notification.x >= dev.vars.sW+20) then
                table.remove(dev.notifications,i)
            end
            y = y + height + space
        end
    end
end)

else
    print("Infelizmente o menu não pode ser utilizado aqui!")


end