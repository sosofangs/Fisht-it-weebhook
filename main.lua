local webhookURL = "MASUKKAN_WEBHOOK_DISCORD_KAMU"

local rareFish = {
    ["Screet"] = {
        color = 65280,
        image = "https://i.imgur.com/YourScreetImage.png"
    },
    ["Phantom Megalodon"] = {
        color = 16711680,
        image = "https://i.imgur.com/YourPhantomMegalodon.png"
    },
    ["Robot Kraken"] = {
        color = 255,
        image = "https://i.imgur.com/YourKrakenImage.png"
    }
}

local pingMessage = "@here"  -- bisa diganti @everyone atau role spesifik

local function sendDiscordEmbed(title, description, color, imageUrl)
    local HttpService = game:GetService("HttpService")
    local data = {
        content = pingMessage,
        embeds = {{
            title = title,
            description = description,
            color = color,
            footer = { text = "Fish It Auto Webhook 🎣" },
            timestamp = DateTime.now():ToIsoDate(),
            image = { url = imageUrl }
        }}
    }
    (http_request or request or syn.request)({
        Url = webhookURL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(data)
    })
end

local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

backpack.ChildAdded:Connect(function(item)
    local fishData = rareFish[item.Name]
    if fishData then
        sendDiscordEmbed(
            "🐟 Ikan Langka Tertangkap!",
            "**"..player.Name.."** baru saja mendapatkan **"..item.Name.."**!",
            fishData.color,
            fishData.image
        )
    end
end)
