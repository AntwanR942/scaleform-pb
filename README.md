# scaleform-pb

**Progress bars made in Flash with Adobe Flash 8.0 and ActionScript 2.0**

## Installation
- Clone this repository.
- Import ``scaleform_pb.fla`` with Adobe Flash (CS6 Recommended)
- Export to Small Web Format (``.swf``).
- For use in FiveM, provide the exported ``scaleform_pb.swf`` to [GFXExport](https://sourceforge.net/projects/btek-kingfish/files/CryENGINE%20Modded/Tools/GFxExport/) via your preferred CLI.

## Example
Example code that produce the previews below can be found under their respective drop-down.

<details open>
<summary>Actionscript</summary>

```as
var TIMELINE = new com.rockstargames.gtav.levelDesign.SCALEFORM_PB(); // Construct a progress bar handler
TIMELINE.INITIALISE(this);


function randColour():Number
{
	return Math.floor((Math.random() * 255));
}

function randAnim():String
{
	var anims:Object = ["LINEAR", "QUADRATIC_IN", "QUADRATIC_OUT", "QUADRATIC_INOUT", "CUBIC_IN", "CUBIC_OUT", "CUBIC_INOUT", "QUARTIC_IN", "QUARTIC_OUT", "QUARTIC_INOUT", "SINE_IN", "SINE_OUT", "SINE_INOUT", "BACK_IN", "BACK_OUT", "BACK_INOUT", "CIRCULAR_IN", "CIRCULAR_OUT", "CIRCULAR_INOUT"];
	return (anims[Math.floor(Math.random() * (anims.length - 1))]);
}

for (i = 0; i < 5; i++)
{
	for (j = 0; j < 3; j++)
	{
		var pb = TIMELINE.CREATE_PB();
		var x = (i * 150);
		var y = (j * 50) + 32;
	
        // set progress bar properties through the handler using the UID provided above
		TIMELINE.CALL(pb,"SET_POSITION",x,y);
		TIMELINE.CALL(pb,"SET_BACKGROUND_DIMENSIONS",128,10,2,2);
		TIMELINE.CALL(pb,"SET_BACKGROUND_RGBA",0,0,0,168);
		TIMELINE.CALL(pb,"SET_BAR_RGBA",randColour(),randColour(),randColour(),255);
		TIMELINE.CALL(pb,"SET_GLOW_RGBA",randColour(),randColour(),randColour(),(j === 0 ? 255 : 0));
		TIMELINE.CALL(pb,"SET_LABEL_RGBA",0,0,0,255);
		TIMELINE.CALL(pb,"SET_LABEL_TEXT","Cool, a progress bar!");
		TIMELINE.CALL(pb,"SET_COMPONENT_ANIMS",randAnim(),randAnim());

		TIMELINE.CALL(pb,"START",0.5,3.5);
	}
}
```
</details>

<details open>
<summary>Lua (Fivem)</summary>

```lua
local BAR_WIDTH = 256
local BAR_HEIGHT = 8
local BAR_X = math.floor(640 - (BAR_WIDTH / 2))
local BAR_Y = 450

local SCALEFORM_TYPE_MAP = {
    ["integer"] = ScaleformMovieMethodAddParamInt,
    ["float"] = ScaleformMovieMethodAddParamFloat,
    ["string"] = ScaleformMovieMethodAddParamTextureNameString
}


local function getDataType(value)
    local valueType = type(value)
    if valueType == "number" then
        return (tostring(value):find("%.") == nil and "integer" or "float")
    else
        return valueType
    end
end


CreateThread(function()
    local sf_pb

    AddEventHandler("onResourceStop", function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SetScaleformMovieAsNoLongerNeeded(sf_pb)

            sf_pb = nil
        end
    end)

    local function CallPBMethod(id, method, ...)
        local args = {...}

        BeginScaleformMovieMethod(sf_pb, "CALL")
        ScaleformMovieMethodAddParamInt(id)
        ScaleformMovieMethodAddParamTextureNameString(method)
        for i, arg in ipairs(args) do
            SCALEFORM_TYPE_MAP[getDataType(arg)](arg)
        end
        EndScaleformMovieMethod()
    end

    sf_pb = RequestScaleformMovie("scaleform_pb")
    if not HasScaleformMovieLoaded(sf_pb) then
        while not HasScaleformMovieLoaded(sf_pb) do
            Wait(1)
        end
    end

    for i = 1, 2 do
        BeginScaleformMovieMethod(sf_pb, "CREATE_PB")
        local ret = EndScaleformMovieMethodReturn()

        while not IsScaleformMovieMethodReturnValueReady(ret) do
            Wait(1)
        end

        local pbID = GetScaleformMovieMethodReturnValueInt(ret)

        CallPBMethod(pbID, "SET_POSITION", BAR_X, BAR_Y + ((i - 1) * 100)) -- x position, y position

        CallPBMethod(pbID, "SET_BACKGROUND_DIMENSIONS", BAR_WIDTH, BAR_HEIGHT, 1, 1) -- bar width, bar height, padding top/bottom, paddng left/right

        CallPBMethod(pbID, "SET_BACKGROUND_RGBA", 0, 0, 0, 168) -- RGBA components for background

        CallPBMethod(pbID, "SET_BAR_RGBA", math.random(1, 255), math.random(1, 255), math.random(1, 255), 255) -- RGBA components for progress bar

        CallPBMethod(pbID, "SET_LABEL_RGBA", 255, 255, 255, 255) -- RGBA components for label

        CallPBMethod(pbID, "SET_LABEL_TEXT", "Wow, progress bar!") -- label text displayed above bar

        CallPBMethod(pbID, "SET_COMPONENT_ANIMS", "LINEAR", "SINE_INOUT") -- fade animation, bar animation

        CallPBMethod(pbID, "START", 0.5, 1.5) -- fade duration, bar duration
    end

    while true do
        DrawScaleformMovieFullscreen(sf_pb, 255, 255, 255, 255)

        Wait(0)
    end
end)
```

</details>


## Preview

![preview-1](https://user-images.githubusercontent.com/46630572/191607871-df5fddb0-ec23-46b0-b63b-21bd997e09f6.gif)

![preview-2](https://user-images.githubusercontent.com/46630572/191607887-368982f6-6d8a-4db5-bf67-ec20e0d6eca4.gif)