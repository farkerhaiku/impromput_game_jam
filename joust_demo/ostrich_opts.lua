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
            }, 
    
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