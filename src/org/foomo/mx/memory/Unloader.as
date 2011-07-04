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
package org.foomo.mx.memory
{
	import org.foomo.flash.managers.MemoryMananager;

	/**
	 * This offers a shortcut to add all common unloader
	 * NOTE: I am not using the actual classes as I don't wont to link them into
	 * the swf if they are not needed
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class Unloader
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Shortcut to include all basic unloader
		 */
		public static function addAll():void
		{
			MemoryMananager.addUnloader('mx.controls::Image', new ImageUnloader);
			MemoryMananager.addUnloader('mx.controls::SWFLoader', new SWFLoaderUnloader);
			MemoryMananager.addUnloader('mx.core::UIComponent', new UIComponentUnloader);
		}

		/**
		 * Shortcut to remove all basic unloader
		 */
		public static function removeAll():void
		{
			MemoryMananager.removeUnloader('mx.controls::Image');
			MemoryMananager.removeUnloader('mx.controls::SWFLoader');
			MemoryMananager.removeUnloader('mx.core::UIComponent');
		}
	}
}