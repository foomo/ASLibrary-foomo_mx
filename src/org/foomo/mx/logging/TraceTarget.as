package org.foomo.mx.logging
{
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.LogEvent;
	import mx.logging.targets.LineFormattedTarget;

	import org.foomo.mx.utils.DebugUtils;

	use namespace mx_internal;

	/**
	 * Trace Target supporting location output PHP Style
	 */
	public class TraceTarget extends LineFormattedTarget
	{
		[Inspectable(category="General", defaultValue="false")]

		public var includeLocation:Boolean;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function TraceTarget()
		{
			super();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overridden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function logEvent(event:LogEvent):void
		{
			var date:String = ""
			if (includeDate || includeTime) {
				var d:Date = new Date();
				if (includeDate) {
					date = Number(d.getMonth() + 1).toString() + "/" +
						d.getDate().toString() + "/" +
						d.getFullYear() + fieldSeparator;
				}
				if (includeTime) {
					date += padTime(d.getHours()) + ":" +
							padTime(d.getMinutes()) + ":" +
							padTime(d.getSeconds()) + "." +
							padTime(d.getMilliseconds(), true) + fieldSeparator;
				}
			}

			var level:String = "";
			if (includeLevel) {
				level = "[" + LogEvent.getLevelString(event.level) +
						"]" + fieldSeparator;
			}

			var category:String = includeCategory ? ILogger(event.target).category + fieldSeparator : "";

			var location:String = "";
			if (this.includeLocation) {
				var stackLine:String 	= DebugUtils.getStackTrace(8, 9);
				var locationSplit:int 	= stackLine.indexOf('[');
				var locationIn:String	= stackLine.substring(locationSplit);
				location = ' in ' + locationIn.substring(locationIn.indexOf('/src'), (locationIn.length - 2));
			}

			internalLog(date + level + category + event.message + location);
		}

		/**
		 *  @inherit
		 */
		override mx_internal function internalLog(message:String):void
		{
			trace(message);
		}

		/**
		 *  @private
		 */
		private function padTime(num:Number, millis:Boolean=false):String
		{
			if (millis) {
				if (num < 10) {
					return "00" + num.toString();
				} else if (num < 100) {
					return "0" + num.toString();
				} else {
					return num.toString();
				}
			} else {
				return (num > 9) ? num.toString() : "0" + num.toString();
			}
		}
	}
}