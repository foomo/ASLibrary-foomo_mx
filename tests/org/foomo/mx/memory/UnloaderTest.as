package org.foomo.mx.memory
{
	import flexunit.framework.Assert;

	import mx.controls.Image;
	import mx.controls.SWFLoader;
	import mx.core.UIComponent;

	import org.foomo.managers.MemoryMananager;

	public class UnloaderTest
	{
		//-----------------------------------------------------------------------------------------
		// ~ Initialization
		//-----------------------------------------------------------------------------------------

		[Before]
		public function setUp():void
		{
			Unloader.addAll();
		}

		[After]
		public function tearDown():void
		{
		}

		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}

		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Test methods
		//-----------------------------------------------------------------------------------------

		[Test]
		public function testImageUnloader():void
		{
			var obj:Image = new Image;
			MemoryMananager.unload(obj);
			Assert.assertTrue(true);
		}

		[Test]
		public function testSWFLoaderUnloader():void
		{
			var obj:SWFLoader = new SWFLoader;
			MemoryMananager.unload(obj);
			Assert.assertTrue(true);
		}

		[Test]
		public function testUIComponentUnloader():void
		{
			var obj:UIComponent = new UIComponent;
			MemoryMananager.unload(obj);
			Assert.assertTrue(true);
		}

		[Test]
		public function testImageUnloader2():void
		{
			var obj:Image = new Image;
			MemoryMananager.unload(obj);
			Assert.assertTrue(true);
		}

		[Test]
		public function testSWFLoaderUnloader2():void
		{
			var obj:SWFLoader = new SWFLoader;
			MemoryMananager.unload(obj);
			Assert.assertTrue(true);
		}

		[Test]
		public function testUIComponentUnloader2():void
		{
			var obj:UIComponent = new UIComponent;
			MemoryMananager.unload(obj);
			Assert.assertTrue(true);
		}
	}
}