package org.foomo.mx.utils
{
	import flash.utils.getQualifiedClassName;

	import mx.utils.ObjectUtil;

	import org.foomo.flash.utils.ClassUtil;
	import org.foomo.flash.utils.StringUtil;

	public class DebugUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns a human readable object description
		 */
		public static function export(obj:Object):String
		{
			return DebugUtils.recursiveExport(obj);
		}

		/**
		 * Returns lines of the stack trace
		 * Note: Works only for the debug player
		 */
		public static function getStackTrace(startIndex:int=0, endIndex:int=-1):String
		{
			var stackTrace:String	= '';
			var stackData:Array		= DebugUtils.getStackTraceData(startIndex, endIndex);
			while (stackData.length > 0) {
				stackTrace += stackData.shift() + '\n';
			}
			return stackTrace;
		}

		/**
		 * Returns data of the stack trace
		 * Note: Works only for the debug player
		 */
		public static function getStackTraceData(startIndex:int=0, endIndex:int=-1):Array
		{
			var stack:Array = new Array;
			try {
				throw new Error();
			} catch (error: Error) {
				var stackTrace:String 	= error.getStackTrace();
				var stackData:Array		= stackTrace.split('\n');
				stack 					= stackData.slice(startIndex, endIndex);
			}
			return stack;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function recursiveExport(obj:Object, level:int=0):String
		{
			var export:String = '';
			var type:String = typeof(obj);
			var className:String = ClassUtil.getQualifiedName(obj);

			// starting from here we create the dump string

			//export += StringUtil.prepend(className, '\t', level);


			switch (className) {
				case 'object':
					break;
				case 'Array':
					break;
				case 'String':
					export += StringUtil.prepend(type + " '" + obj + "'", '\t', level);
					break;
				default:
					trace('Unhandled type:', type);
					break;
			}

			return export;
			/*
			if (type == "object") {
				var i:Object;
				if (className == 'Array' || className == 'Object') {
					_dumpString += " (" + getLength(obj) + ")";
					_dumpString += " {\n";
					_dumpIndent += "    ";
					for (i in obj) {
						_dumpString += _dumpIndent + "[" +i+ "] => \n";
						recursiveExport(obj[i]);
					}
				} else {
					var info:Object = ObjectUtil.getClassInfo(obj);

					_dumpString += " (" + info.properties.length + ")";
					_dumpString += " {\n";
					_dumpIndent += "    ";
					for (i in info.metadata) {
						_dumpString += _dumpIndent + "[" +i+ "] => \n";
						recursiveExport(obj[i.toString()]);
					}
				}
				_dumpIndent = _dumpIndent.substring(0,_dumpIndent.length-4);
				_dumpString += _dumpIndent + "}\n";
			} else {
				if (type == "string")
					_dumpString += " (" + obj.length + ") = \"" + obj + "\"\n";
				else
					_dumpString += "(" + obj + ")\n";
			}
			// returning the dump string
			return _dumpString;
			*/
		}

		/**
		 * @private
		 * Internal function to get the number of children from the object - getting only the first level
		 */
		private static function getLength(o:Object):uint
		{
			var len:uint = 0;
			for (var item:* in o)
				len++;
			return len;
		}
	}
}