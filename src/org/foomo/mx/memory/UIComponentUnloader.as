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
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	import org.foomo.flash.memory.IUnloader;

	use namespace mx_internal;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class UIComponentUnloader implements IUnloader
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * TODO: this is experimental
		 */
		public function unload(object:Object):void
		{
			var child:UIComponent = UIComponent(object);
			child.invalidateDisplayListFlag = false;
			child.invalidatePropertiesFlag= false;
			child.invalidateSizeFlag = false;
			child._documentDescriptor = null;
			child._descriptor = null;
			child._document = null;
		}
	}
}