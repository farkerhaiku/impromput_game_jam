local animation_data = {
    options = { 
        frames = {
            {
                x = 23,
                y = 10,
                width = 22,
                height = 24
            }, {
                x = 46,
                y = 10,
                width = 22,
                height = 24
            }, { 
                x = 69,
                y = 10,
                width = 22,
                height = 24
            }, { 
                x = 91,
                y = 10,
                width = 22,
                height = 24
            }, { 
                x = 112,
                y = 10,
                width = 22,
                height = 24
            }, { 
                x = 137,
                y = 10,
                width = 22,
                height = 24
            }, { 
                x = 160,
                y = 10,
                width = 22,
                height = 24
            }, 
    
        },
        sheetContentWidth=320, 
        sheetContentHeight=200
    },
    sequenceData = {
        { name = "walk", start=1, count=4, time=600 },
        { name = "fly", start=6, count=2, time=800 },
        { name = "run", start=1, count=4, time=275 },
        { name = "stop", start=5, count=1, time=275 },
    }
}


return animation_data