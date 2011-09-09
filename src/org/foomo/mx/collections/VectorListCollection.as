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
package org.foomo.mx.collections
{

	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	import mx.collections.ICollectionView;
	import mx.collections.ListCollectionView;
	import mx.core.mx_internal;

	use namespace mx_internal;

	[DefaultProperty("source")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @see 	http://www.digitalprimates.net/author/codeslinger/2010/05/18/vectorcollection/
	 */
	public class VectorListCollection extends ListCollectionView implements ICollectionView, IExternalizable
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *  Constructor.
		 *
		 *  <p>Creates a new ArrayCollection using the specified source array.
		 *  If no array is specified an empty array will be used.</p>
		 */
		public function VectorListCollection(source:* = null)
		{
			super();
			this.source = source;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public accessor methods
		//-----------------------------------------------------------------------------------------

		/**
		 *  The source of data in the ArrayCollection.
		 *  The ArrayCollection object does not represent any changes that you make
		 *  directly to the source array. Always use
		 *  the ICollectionView or IList methods to modify the collection.
		 */
		[Bindable("listChange")]
		[Inspectable(category="Common", arrayType="Object")]
		public function get source():*
		{
			if (this.list && (this.list is VectorList)) return VectorList(this.list).source;
			return null;
		}
		/**
		 *  @private
		 */
		public function set source(s:*):void
		{
			this.list = new VectorList(s);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 *  Ensures that only the source property is serialized.
		 */
		public function readExternal(input:IDataInput):void
		{
			if (list is IExternalizable) {
				IExternalizable(this.list).readExternal(input);
			} else {
				this.source = input.readObject() as Array;
			}
		}

		/**
		 *  @private
		 *  Ensures that only the source property is serialized.
		 */
		public function writeExternal(output:IDataOutput):void
		{
			if (list is IExternalizable) {
				IExternalizable(list).writeExternal(output);
			} else {
				output.writeObject(source);
			}
		}
	}
}