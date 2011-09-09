package org.foomo.mx.controls.menuClasses
{
	public class MenuItem
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const TYPE_CHECK:String 		= 'check';
		public static const TYPE_RADIO:String 		= 'radio';
		public static const TYPE_NORMAL:String 		= 'normal';
		public static const TYPE_SEPARATOR:String 	= 'separator';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _children:Array = [];
		private var _enabled:Boolean = true;
		private var _groupName:String = "";
		private var _icon:Class;
		private var _label:String = "";
		private var _toggled:Boolean = true;
		private var _type:String = "";

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function MenuItem(label:String="", enabled:Boolean=true, type:String="normal", toggled:Boolean=true, groupName:String="", icon:Class=null)
		{
			this._enabled = enabled;
			this._groupName = groupName;
			this._icon = icon;
			this._label = label;
			this._toggled = toggled;
			this._type = type;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function set enabled(value:Boolean):void
		{
			this._enabled = value;
		}
		public function get enabled():Boolean
		{
			return this._enabled;
		}

		public function set groupName(value:String):void
		{
			this._groupName = value;
		}
		public function get groupName():String
		{
			return this._groupName;
		}

		public function set icon( value:Class ):void
		{
			this._icon = value;
		}
		public function get icon():Class
		{
			return this._icon;
		}

		public function set label(value:String):void
		{
			this._label = value;
		}
		public function get label():String
		{
			return this._label;
		}

		public function set toggled(value:Boolean):void
		{
			this._toggled = value;
		}
		public function get toggled():Boolean
		{
			return this._toggled;
		}

		[Inspectable(enumeration="separator,check,radio,normal")]
		public function set type( value:String ):void
		{
			this._type = value;
		}
		public function get type():String
		{
			return this._type;
		}
	}
}