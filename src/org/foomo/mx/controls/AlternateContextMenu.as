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
package org.foomo.mx.controls
{
	import flash.display.Stage;
	import flash.events.MouseEvent;

	import mx.controls.Menu;
	import mx.events.MenuEvent;

	import org.foomo.foomo_internal;
	import org.foomo.mx.controls.menuClasses.MenuItem;
	import org.foomo.utils.EventHandlerUtil;

	use namespace foomo_internal;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @needs 	MouseEvent.RightMouseClick
	 *
	 * Call once: AlternateContextMenu.init(this.stage);
	 * Create a menuItem once: var myMenuItem:MenuItem = new MenuItem('My Menu Item');
	 * Add to menu on rightClick: AlternateContextMenu.addMenuItem(myMenuItem, this.mySelectCallbackFunction, arg1, arg2, ...);
	 */
	public class AlternateContextMenu
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private static var _stage:Stage;
		/**
		 *
		 */
		private static var _menuItems:Array = [];
		/**
		 *
		 */
		private static var _menuCallbacks:Array = [];
		/**
		 *
		 */
		private static var _menu:Menu;
		/**
		 *
		 */
		private static var _collecting:Boolean = false;

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function init(stage:Stage, showRoot:Boolean=false):void
		{
			AlternateContextMenu._menu = Menu.createMenu(stage, [], showRoot);
			AlternateContextMenu._stage = stage;
			AlternateContextMenu._stage.addEventListener('rightClick', AlternateContextMenu.stage_rightClickHandler);
		}

		public static function get menu():Menu
		{
			_menu.parent
			return AlternateContextMenu._menu;
		}

		/**
		 * @param item the menu item to add
		 * @param callback the method to call if selected
		 * @param args the arguements to pass to that callback
		 * @return the actual eventlistener function
		 */
		public static function addMenuItem(item:MenuItem, callback:Function=null, ... args):Function
		{
			AlternateContextMenu.checkCollecting();
			AlternateContextMenu._menuItems.push(item);
			return AlternateContextMenu.addChangeCallback(item, callback, args);

		}

		/**
		 * @param item the menu item to add
		 * @param callback the method to call if selected
		 * @param args the arguements to pass to that callback
		 * @return the actual eventlistener function
		 */
		public static function addMenuItemCallback(item:MenuItem, callback:Function=null, ... args):Function
		{
			checkCollecting();
			return addChangeCallback(item, callback, args);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Internal methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Stop collecting and show the menu
		 */
		foomo_internal static function show():void
		{
			if (AlternateContextMenu._menuItems.length == 0) return;
			AlternateContextMenu._menu.labelField = "label";
			AlternateContextMenu._menu.dataProvider = _menuItems;
			if (AlternateContextMenu._menu.isPopUp) {
				AlternateContextMenu._menu.move(_stage.mouseX, _stage.mouseY);
			} else {
				AlternateContextMenu._menu.show(_stage.mouseX, _stage.mouseY);
			}
			AlternateContextMenu._collecting = false;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		private static function checkCollecting():void
		{
			if (AlternateContextMenu._collecting) return;
			for each (var cf:Function in _menuCallbacks) AlternateContextMenu._menu.removeEventListener(MenuEvent.CHANGE, cf);
			AlternateContextMenu._menuCallbacks = [];
			AlternateContextMenu._menuItems = [];
			AlternateContextMenu._collecting = true;
		}

		private static function addChangeCallback(item:MenuItem, callback:Function=null, args:Array=null):Function
		{
			if (callback == null) return null;
			if (args == null) args = [];
			var listener:Function = EventHandlerUtil.addCallback(AlternateContextMenu.menu_changeHandler, ['item'], item, callback, args);
			AlternateContextMenu._menuCallbacks.push(listener)
			AlternateContextMenu._menu.addEventListener(MenuEvent.CHANGE, listener);
			return listener;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static eventhandler
		//-----------------------------------------------------------------------------------------

		private static function menu_changeHandler(relatedObject:Object, item:MenuItem, callback:Function, args:Array):void
		{
			if (relatedObject == item) callback.apply(null, args);
		}

		/**
		 * If the stage receives the right click we are at the bottom and can show the menu
		 */
		private static function stage_rightClickHandler(event:MouseEvent):void
		{
			AlternateContextMenu.show();
		}
	}
}