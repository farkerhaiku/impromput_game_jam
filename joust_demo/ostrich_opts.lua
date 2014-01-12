local animation_data = {
    options = { 
        frames = {
            {
                x = 25,
                y = 12,
                width = 20,
                height = 20
            }, {
                x = 48,
                y = 12,
                width = 20,
                height = 20
            }, { 
                x = 71,
                y = 12,
                width = 20,
                height = 20
            }, { 
                x = 95,
                y = 12,
                width = 20,
                height = 20
            }, { 
                x = 112,
                y = 12,
                width = 20,
                height = 20
            }, { 
                x = 140,
                y = 11,
                width = 18,
                height = 15
            }, { 
                x = 164,
                y = 11,
                width = 18,
                height = 15
            }, { -- left ledge no spawn
                x = 35,
                y = 162,
                width = 33  ,
                height = 7
            }, { -- right ledge no spawn
                x = 78,
                y = 162,
                width =46,
                height = 8
            }, { -- middle ledge
                x = 131,
                y = 162,
                width =88,
                height = 9
            }, { -- bottom middle ledge
                x = 226,
                y = 162,
                width = 64,
                height = 8
            }, { -- bottom left ledge with spawn point
                x = 34,
                y = 182,
                width = 63,
                height = 7
            }, { -- bottom right left with spawn
                x = 109,
                y = 180,
                width = 57,
                height = 10
            }, { -- bottom right left without spawn
                x = 175,
                y = 180,
                width = 42,
                height = 8
            }, {}
        },
        sheetContentWidth=320, 
        sheetContentHeight=200
    },
    sequenceData = {
        { name = "walk", start=1, count=3, time=600 },
        { name = "fly", start=6, count=2, time=800 },
        { name = "run", start=1, count=4, time=275 },
        { name = "stop", start=5, count=1, time=275 },
    }
}


return animation_data