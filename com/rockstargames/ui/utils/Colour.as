﻿class com.rockstargames.ui.utils.Colour
{
	function Colour()
	{
	}
	static function Colourise(movieClip, r, g, b, a)
	{
		r = (255 - r) * -1;
		g = (255 - g) * -1;
		b = (255 - b) * -1;
		var _loc1_ = new flash.geom.Transform(movieClip);
		var _loc4_ = new flash.geom.ColorTransform(1, 1, 1, 1, r, g, b, 0);
		_loc1_.colorTransform = _loc4_;
		movieClip._alpha = a;
	}

	static function ColouriseB(my_mc, r, g, b, a)
	{
		var _loc1_ = new Color(my_mc);
		var _loc2_ = {ra:100, rb:r, ga:100, gb:g, ba:100, bb:b, aa:100, ab:100};
		_loc1_.setTransform(_loc2_);
	}

	public static function rgb2hex(r, g, b, a)
	{
		return (a << 24) | (r << 16) | (g << 8) | b;
	}
	static function RGBToHex(r, g, b)
	{
		var _loc2_ = r.toString(16);
		var _loc1_ = g.toString(16);
		var _loc3_ = b.toString(16);
		if (_loc2_ == "0")
		{
			_loc2_ = "00";
		}
		if (_loc1_ == "0")
		{
			_loc1_ = "00";
		}
		if (_loc3_ == "0")
		{
			_loc3_ = "00";
		}
		var _loc4_ = "0x" + _loc2_ + _loc1_ + _loc3_;
		return Number(_loc4_);
	}
	static function HexToRGB(hex)
	{
		var _loc1_ = hex >> 16;
		var _loc2_ = hex - (_loc1_ << 16);
		var _loc3_ = _loc2_ >> 8;
		var _loc4_ = _loc2_ - (_loc3_ << 8);
		return {r:_loc1_, g:_loc3_, b:_loc4_};
	}
	static function ARGBtoHEX(argb)
	{
		return argb.a << 24 | argb.r << 16 | argb.g << 8 | argb.b;
	}

	static function HexToARGB(hex)
	{
		var col = {};
		col.a = (hex >> 24) & 0xFF;
		col.r = (hex >> 16) & 0xFF;
		col.g = (hex >> 8) & 0xFF;
		col.b = hex & 0xFF;
		return col;
	}
	static function StringToColour(string)
	{
		var s = string.split(",");
		return {a:s[0], r:s[1], g:s[2], b:s[3]};
	}
}