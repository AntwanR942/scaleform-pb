class com.rockstargames.gtav.levelDesign.SCALEFORM_PB extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var pbPool:Object = [];
	function SCALEFORM_PB()
	{
		super();
	}
	function INITIALISE(mc:MovieClip):Void
	{
		this.TIMELINE = mc;
		this.CONTENT = this.TIMELINE.attachMovie("CONTENT", "CONTENT", this.TIMELINE.getNextHighestDepth());
	}

	function CREATE_PB():Number
	{
		var pb = new com.rockstargames.gtav.pb.PROGRESS_BAR(this.CONTENT, this.TIMELINE, pbPool.length);
		this.pbPool.push(pb);

		return (this.pbPool.length - 1);
	}
	function CALL(pbID:Number, method:String):Void
	{
		var pbmc = this.pbPool[pbID];

		if (pbmc != "undefined" && typeof pbmc[method] === "function")
		{
			arguments.shift();
			arguments.shift();

			pbmc[method].apply(pbmc,arguments);
		}
	}
}