Tabs.Aimbot:AddToggle('AimbotEnabled', {  -- ID'yi değiştirdim
    Text = 'Aimbot Aç/Kapat',
    Default = false,
    Callback = function(Value)
        aimlockEnabled = Value
    end
})

Tabs.Aimbot:AddToggle('FOVDrawing', {  -- ID'yi değiştirdim
    Text = "FOV Çizimi Aktif Mi?",
    Default = false,
    Callback = function(Value)
        fovEnabled = Value
        if fovEnabled then
            DrawFOVCircle()
        else
            if fovCircle then
                fovCircle:Destroy()
                fovCircle = nil
            end
        end
    end
})

Tabs.Aimbot:AddSlider('FOVSize', { -- ID'yi değiştirdim
    Text = "FOV Çapı",
    Min = 10,
    Max = 100,
    Default = lockFOVCircleRadius,
    Callback = function(Value)
        lockFOVCircleRadius = Value
        if fovCircle then
            fovCircle.Size = Vector3.new(Value, Value, Value)
        end
    end
})

Tabs.Aimbot:AddButton({
    Text = "Aimbot Başlat",
    Func = function()
        print("Aimbot Başlatıldı!")
    end
})

Tabs.Aimbot:AddButton({
    Text = "Kilitlenme (Lock)",
    Func = function()
        print("Aimbot Kilitlenmesi Başlatıldı!")
    end
})
