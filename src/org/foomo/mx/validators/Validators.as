/*
* This file is part of the foomo Opensource Framework.
*
* The foomo Opensource Framework is free software: you can redistribute it
* and/or modify it under the terms of the GNU Lesser General Public License as
* published  by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* The foomo Opensource Framework is distributed in the hope that it will
* be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
* of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License along with
* the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
*/
package org.foomo.mx.validators
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import mx.collections.ArrayCollection;
	import mx.controls.Label;
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;

	[Event(name="valid", type="mx.events.ValidationResultEvent")]
	[Event(name="invalid", type="mx.events.ValidationResultEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public dynamic class Validators extends ArrayCollection
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _listener:Object;

		private var _errorString:String;

		private var _valid:Boolean = true;

		private var _trigger:IEventDispatcher;

		private var _triggerEvent:String = FlexEvent.VALUE_COMMIT;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Validators(source:Array=null)
		{
			super(source);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function set triggerEvent(value:String):void
		{
			if (this._triggerEvent == value) return;
			this.removeTriggerHandler();
			this._triggerEvent = value;
			this.addTriggerHandler();
		}
		public function get triggerEvent():String
		{
			return this._triggerEvent;
		}

		public function set trigger(value:IEventDispatcher):void
		{
			this.removeTriggerHandler();
			this._trigger = value;
			this.addTriggerHandler();
		}
		public function get trigger():IEventDispatcher
		{
			return this._trigger;
		}

		public function set listener(value:Object):void
		{
			this._listener = value;
		}
		public function get listener():Object
		{
			return this._listener;
		}

		public function set errorString(value:String):void
		{
			this._errorString = value;
			if (this._listener) this._listener.errorString = value;
		}
		public function get errorString():String
		{
			return this._errorString;
		}

		public function get valid():Boolean
		{
			return this._valid;
		}

		public function validate():Boolean
		{
			var invalidEvent:ValidationResultEvent;

			for (var i:int=0;i<this.length;i++) {
				var validator:Validator = Validator(this.getItemAt(i));
				var result:ValidationResultEvent = validator.validate();
				if (!invalidEvent && result.type == ValidationResultEvent.INVALID) invalidEvent = result;
			}

			if (invalidEvent != null) {
				this.errorString = invalidEvent.message;
				this._valid = false;
				this.dispatchEvent(invalidEvent);
			} else {
				this.errorString = '';
				this._valid = true;
				this.dispatchEvent(new ValidationResultEvent(ValidationResultEvent.VALID));
			}

			return this.valid;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		private function addTriggerHandler():void
		{
			if (this._trigger) this._trigger.addEventListener(this._triggerEvent, this.triggerEventHandler);
		}

		private function removeTriggerHandler():void
		{
			if (this._trigger) this._trigger.removeEventListener(this._triggerEvent, this.triggerEventHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		private function triggerEventHandler(event:Event):void
		{
			this.validate();
		}
	}
}