local animation_data = {
    options = { 
        frames = {
            {
                x = 346,
                y = 62,
                width = 40,
                height = 38
            }, {
                x = 386,
                y = 62,
                width = 40,
                height = 38
            }, { 
                x = 426,
                y = 62,
                width = 40,
                height = 38
            }, { 
                x = 466,
                y = 62,
                width = 40,
                height = 38
            }, { 
                x = 506,
                y = 62,
                width = 40,
                height = 38
            }, { 
                x = 1,
                y = 103,
                width = 40,
                height = 38
            }, { 
                x = 41,
                y = 103,
                width = 40,
                height = 38
            }, { -- left ledge no spawn
                x = 0,
                y = 1,
                width = 63,
                height = 14
            }, { -- right ledge no spawn
                x = 72,
                y = 1,
                width = 88,
                height = 14
            }, { -- middle ledge
                x = 170,
                y = 1,
                width = 164,
                height = 14
            }, { -- bottom middle ledge
                x = 214,
                y = 27,
                width = 118,
                height = 14
            }, { -- bottom left ledge with spawn point
                x = 344,
                y = 1,
                width = 116,
                height = 14
            }, { -- bottom right ledge with spawn
                x = 0,
                y = 27,
                width = 110,
                height = 15
            }, { -- bottom right ledge without spawn
                x = 120,
                y = 27,
                width = 70,
                height = 15
            }, { -- base platform right 
                x = 378,
                y = 27,
                width = 32,
                height = 20
            }, { -- base platform left
                x = 342,
                y = 27,
                width = 32,
                height = 20
            }, { -- base platform mid
                x = 1,
                y = 62,
                width = 346,
                height = 5
            }, {}
        },
        sheetContentWidth=560, 
        sheetContentHeight=472
    },
    sequenceData = {
        { name = "stand", start=4, count=1 },
        { name = "walk", start=1, count=4, time=600 },
        { name = "fly", start=6, count=2, time=400 },
        { name = "run", start=1, count=4, time=275 },
        { name = "stop", start=5, count=1, time=275 },
    }
}


return animation_data