package org.foomo.mx.utils
{
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;

	import org.foomo.utils.ClassUtil;

	/**
	 * For a better debugging and application checks
	 */
	public class LogUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Holds all TraceTargets by dictionary
		 */
		private static var _traceTargets:Dictionary = new Dictionary;
		/**
		 * Holds all aliasName all all requested Loggers during runtime
		 */
		[Bindable] private static var _loggerAliases:ArrayCollection = new ArrayCollection

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param id			TraceTarget identifier
		 * @param level			default ist LogEventLevel.ALL
		 * @param filters		default ist ["*"]
		 * @param traceTarget	default ist mx.logging.targets.TraceTarget
		 */
		public static function addLoggingTarget(id:Object, level:int=0, filters:Array=null, traceTarget:ILoggingTarget=null):void
		{
			traceTarget						= (traceTarget == null) ? new TraceTarget() : traceTarget;
			traceTarget.level 				= level;
			LogUtil._traceTargets[id] 		= traceTarget;
			Log.addTarget(traceTarget);
			traceTarget.filters 			= (filters == null) ? ["*"] : filters;
		}

		/**
		 * Returns a ILoggingTarget for the given id
		 *
		 * @param id			TraceTarget identifier
		 */
		public static function getLoggingTarget(id:Object):ILoggingTarget
		{
			return LogUtil._traceTargets[id] as ILoggingTarget;
		}

		/**
		 * Removes the TraceTarget for the given id
		 *
		 * @param id			TraceTarget identifier
		 */
		public static function removeLoggingTarget(id:Object):void
		{
			if (LogUtil._traceTargets[id] is ILoggingTarget) {
				var traceTarget:ILoggingTarget = ILoggingTarget(LogUtil._traceTargets[id]);
				Log.removeTarget(traceTarget);
				delete LogUtil._traceTargets[id];
			}
		}

		/**
		 * Get the corresponding logger
		 *
		 * @param instance		Instance or Class
		 */
		public static function getLogger(instance:Object):ILogger
		{
			var aliasName:String = ClassUtil.getQualifiedName(instance);
			if (!LogUtil._loggerAliases.contains(aliasName)) LogUtil._loggerAliases.addItem(aliasName);
			return Log.getLogger(aliasName);
		}

		/**
		 * Returns all aliasName all all requested Loggers during runtime
		 */
		public static function get loggerAliases():ArrayCollection
		{
			return LogUtil._loggerAliases;
		}
	}
}