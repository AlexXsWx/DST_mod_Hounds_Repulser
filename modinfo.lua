name = "Hounds repulser (buildable)"
description = "Stop hound waves for good by using Warg's tail and 360 hounds teeth on a hound mound"
author = "AlexXsWx"
version = "0.0.3"

api_version = 6
api_version_dst = 10

-- Compatible with the RoG and DST
dont_starve_compatible = false
reign_of_giants_compatible = true
shipwrecked_compatible = false
dst_compatible = true

icon_atlas = "images/inventoryimages/warg_tail.xml"
icon = "warg_tail.tex"

--These let clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = false

--This lets people search for servers with this mod by these tags
server_filter_tags = {}

configuration_options = {
    {
        name = "RepulserConstructionTarget",
        label = "Structure to modify",
        options = {
            { description = "Hound Mound (default)", data = "houndmound" },
            { description = "Houndius Shootius", data = "eyeturret" }
        },
        default = "houndmound"
    },
    {
        name = "HoundsTeethToBuildRepulser",
        label = "Teeth required",
        options = {
            { description = "10", data = 10 },
            { description = "20", data = 20 },
            { description = "40", data = 40 },
            { description = "2 * 40", data = 80 },
            { description = "3 * 40", data = 120 },
            { description = "4 * 40", data = 160 },
            { description = "5 * 40", data = 200 },
            { description = "6 * 40", data = 240 },
            { description = "255", data = 255 }, -- values above this have display issues
            { description = "7 * 40", data = 280 },
            { description = "8 * 40", data = 320 },
            { description = "9 * 40 (default)", data = 360 }, -- 1 full chest
            { description = "10 * 40", data = 400 },
            { description = "11 * 40", data = 440 },
            { description = "12 * 40", data = 480 },
            { description = "13 * 40", data = 520 },
            { description = "14 * 40", data = 560 },
            { description = "15 * 40", data = 600 },
            { description = "16 * 40", data = 640 },
            { description = "17 * 40", data = 680 },
            { description = "18 * 40", data = 720 }, -- 2 full chests
            { description = "19 * 40", data = 760 },
            { description = "20 * 40", data = 800 }
        },
        default = 360
    },
    {
        name = "WargTailRequired",
        label = "Require warg tail",
        options = {
            { description = "no", data = 0 },
            { description = "yes (default)", data = 1 }
        },
        default = 1
    },
    {
        name = "WargTailDropChance",
        label = "Warg tail drop chance",
        options = {
            { description = "never", data = 0 },
            { description = "1%", data = 1 },
            { description = "2%", data = 2 },
            { description = "3%", data = 3 },
            { description = "4%", data = 4 },
            { description = "5%", data = 5 },
            { description = "6%", data = 6 },
            { description = "7%", data = 7 },
            { description = "8%", data = 8 },
            { description = "9%", data = 9 },
            { description = "10%", data = 10 },
            { description = "15%", data = 15 },
            { description = "20%", data = 20 },
            { description = "25%", data = 25 },
            { description = "30%", data = 30 },
            { description = "33%", data = 33 },
            { description = "40%", data = 40 },
            { description = "50%", data = 50 },
            { description = "60%", data = 60 },
            { description = "66%", data = 66 },
            { description = "70%", data = 70 },
            { description = "75%", data = 75 },
            { description = "80%", data = 80 },
            { description = "90%", data = 90 },
            { description = "95%", data = 95 },
            { description = "99%", data = 99 },
            { description = "100% (default)", data = 100 }
        },
        default = 100
    }
}
