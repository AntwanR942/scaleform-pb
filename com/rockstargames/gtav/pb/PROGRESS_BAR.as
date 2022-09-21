import flash.filters.GlowFilter;

class com.rockstargames.gtav.pb.PROGRESS_BAR
{
	var mc:MovieClip;

	var left:Number = 0;
	var top:Number = 0;

	var tween;

	var barStartWidth:Number = 0;
	var barEndWidth:Number;

	var backgroundAlpha:Number = 0;
	var foregroundAlpha:Number = 0;
	var labelAlpha:Number = 0;

	var labelFormat:TextFormat;
	var labelField:TextField;

	var fadeAnim:Number = com.rockstargames.ui.tweenStar.Ease.LINEAR;
	var barAnim:Number = com.rockstargames.ui.tweenStar.Ease.LINEAR;

	function PROGRESS_BAR(baseMC:MovieClip, TIMELINE:MovieClip, pbID:Number)
	{
		super();

		this.mc = baseMC.attachMovie("pb", ("pb_" + pbID), pbID);

		this.mc.pb_progress._width = 0;
		this.barEndWidth = this.mc.pb_trough._width;

		MovieClip(mc).createEmptyMovieClip("pb_label",3);
		this.labelFormat = new TextFormat();
		this.labelFormat.font = "Chalet-LondonNineteenSixty";
		this.labelFormat.size = 15;

		this.labelField = this.mc.pb_label.createTextField("pb_label", 4, 0, 0, 1280, 720);
		this.labelField.antiAliasType = "advanced";
		this.labelField.embedFonts = true;
		this.labelField.setTextFormat(this.labelFormat);

		this.mc.pb_trough._alpha = 0;
		this.mc.pb_progress._alpha = 0;
		this.mc.pb_label._alpha = 0;
	}

	function SET_POSITION(x:Number, y:Number):Void
	{
		this.mc._x = x;
		this.mc._y = y;
	}

	function SET_VISIBLE(visible:Boolean):Void
	{
		this.mc._visible = visible;
	}

	function SET_BACKGROUND_RGBA(r:Number, g:Number, b:Number, a:Number):Void
	{
		new Color(this.mc.pb_trough).setRGB(com.rockstargames.ui.utils.Colour.RGBToHex(r, g, b));
		this.backgroundAlpha = (a / 255) * 100;
	}
	function SET_BAR_RGBA(r:Number, g:Number, b:Number, a:Number):Void
	{
		new Color(this.mc.pb_progress).setRGB(com.rockstargames.ui.utils.Colour.RGBToHex(r, g, b));
		this.foregroundAlpha = (a / 255) * 100;
	}
	function SET_LABEL_RGBA(r:Number, g:Number, b:Number, a:Number):Void
	{
		if (this.labelFormat != undefined)
		{
			this.labelField.textColor = com.rockstargames.ui.utils.Colour.RGBToHex(r, g, b);
			this.labelAlpha = (a / 255) * 100;

			return;
		}
	}
	function SET_GLOW_RGBA(r:Number, g:Number, b:Number, a:Number):Void
	{
		if (this.mc.pb_label.filters.length > 0)
		{
			this.mc.pb_label.filters = [];
		}

		if (a == 0.0)
		{
			return;
		}

		this.mc.pb_label.filters = [new GlowFilter(com.rockstargames.ui.utils.Colour.RGBToHex(r, g, b), (a / 255), 6, 6)];
	}
	function adjustBarLabel():Void
	{
		this.labelField._x = this.mc.pb_trough._x + (this.mc.pb_trough._width / 2) - (this.labelField.textWidth / 2);
		this.labelField._y = this.mc.pb_trough._y - (this.labelField.textHeight * 1.2);
	}
	function SET_LABEL_TEXT(label:String):Void
	{
		if (this.labelField != undefined)
		{
			this.labelField.text = label;
			this.labelField.setTextFormat(this.labelFormat);

			return;
		}
	}

	function SET_BAR_INITAL_PROGRESS(percent:Number):Void
	{
		this.barStartWidth = (this.barEndWidth * (percent / 100));
	}

	function SET_BACKGROUND_DIMENSIONS(width:Number, height:Number, top:Number, left:Number):Void
	{
		this.mc.pb_trough._width = width;
		this.mc.pb_trough._height = height;

		this.left = left;
		this.top = top;

		this.mc.pb_progress._height = height - (this.top * 2);
		this.mc.pb_progress._x = this.mc.pb_trough._x + this.left;
		this.mc.pb_progress._y = this.mc.pb_trough._y + this.top;

		this.barEndWidth = this.mc.pb_trough._width - (left * 2);
	}

	function SET_COMPONENT_ANIMS(fade:String, bar:String)
	{
		if (fade != undefined)
		{
			this.fadeAnim = (com.rockstargames.ui.tweenStar.Ease[fade] || com.rockstargames.ui.tweenStar.Ease.LINEAR);
		}

		if (bar != undefined)
		{
			this.barAnim = (com.rockstargames.ui.tweenStar.Ease[bar] || com.rockstargames.ui.tweenStar.Ease.LINEAR);
		}
	}

	function STOP(fadeDuration:Number):Void
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_trough,fadeDuration,{_alpha:0, ease:this.fadeAnim});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_label,fadeDuration,{_alpha:0, ease:this.fadeAnim});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_progress,fadeDuration,{_alpha:0, ease:this.fadeAnim});
	}

	function _startBar(fadeDuration:Number, barDuration:Number):Void
	{
		this.tween = com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_progress, barDuration, {_width:this.barEndWidth, ease:this.barAnim, onComplete:STOP, onCompleteScope:this, onCompleteArgs:[fadeDuration]});
	}

	function START(fadeDuration:Number, barDuration:Number):Void
	{
		adjustBarLabel();

		this.mc.pb_progress._width = this.barStartWidth;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_trough,fadeDuration,{_alpha:this.backgroundAlpha, ease:this.fadeAnim});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_label,fadeDuration,{_alpha:this.labelAlpha, ease:this.fadeAnim});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.mc.pb_progress,fadeDuration,{_alpha:this.foregroundAlpha, ease:this.fadeAnim, onComplete:_startBar, onCompleteScope:this, onCompleteArgs:[fadeDuration, barDuration]});
	}
}