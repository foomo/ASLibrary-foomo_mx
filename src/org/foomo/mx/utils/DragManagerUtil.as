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
package org.foomo.mx.utils
{
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.DragManager;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManagerGlobals;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class DragManagerUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Simple way to cancel a flex drag.
		 * i.e. call on ESC keyDown event
		 */
		public static function cancelDrag():void
		{
			if (!DragManager.isDragging) return;
			DragManager.mx_internal::dragProxy.action = DragManager.NONE;
			if (DragManager.mx_internal::dragProxy.target) DragManager.mx_internal::dragProxy.target.dispatchEvent(new DragEvent(DragEvent.DRAG_EXIT));
			DragManager.acceptDragDrop(null);
			ISystemManager(SystemManagerGlobals.topLevelSystemManagers[0]).getSandboxRoot().dispatchEvent(new SandboxMouseEvent(SandboxMouseEvent.MOUSE_UP_SOMEWHERE));
		}
	}
}