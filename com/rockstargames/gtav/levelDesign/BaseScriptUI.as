class com.rockstargames.gtav.levelDesign.BaseScriptUI extends MovieClip
{
	var BOUNDING_BOX:MovieClip;
	var CONTENT:MovieClip;
	var TIMELINE:MovieClip;

	function BaseScriptUI()
	{
		super();
	}
	function INITIALISE(mc):Void
	{
		this.TIMELINE = mc;
		this.CONTENT = this.TIMELINE.attachMovie("CONTENT", "CONTENT", this.TIMELINE.getNextHighestDepth());
		this.BOUNDING_BOX = this.TIMELINE.attachMovie("BOUNDING_BOX", "BOUNDING_BOX", this.TIMELINE.getNextHighestDepth());
		this.BOUNDING_BOX._visible = false;
	}
}