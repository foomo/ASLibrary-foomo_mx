package org.foomo.mx.controls.menuClasses
{
	public class MenuBranch extends MenuItem
	{

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _children:Array = [];

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function MenuBranch(label:String="", enabled:Boolean=true, type:String="normal", toggled:Boolean=true, groupName:String="", icon:Class=null)
		{
			super(label, enabled, type, toggled, groupName, icon);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function set children(value:Array):void
		{
			this._children = value;
		}
		public function get children():Array
		{
			return this._children;
		}
	}
}