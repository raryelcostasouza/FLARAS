package flaras.view.scene 
{
	import flaras.model.*;
	import flaras.model.scene.*;
	import flash.errors.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	
	public class ViewFlarasScene 
	{
		private var _viewAudio:ViewAudioScene;
		private var _viewAnimation:ViewAnimationScene;
		
		protected var _obj3D:DisplayObject3D;
		private var _baseFlarasScene:FlarasScene;
		
		public function ViewFlarasScene(selfReference:ViewFlarasScene, baseFlarasScene:FlarasScene) 
		{
			if (this != selfReference)
			{
				throw new IllegalOperationError("Abstract class did not receive reference to itself. ViewFlarasScene class cannot be instantiated directly");
			}
			else
			{
				_baseFlarasScene = baseFlarasScene;
			}
		}
		
		public function getObj3D():DisplayObject3D
		{
			return _obj3D;
		}
		
		public function getViewAudio():ViewAudioScene
		{
			return _viewAudio;
		}
		
		public function getViewAnimation():ViewAnimationScene
		{
			return _viewAnimation;
		}
		
		public function getBaseFlarasScene():FlarasScene
		{
			return _baseFlarasScene;
		}
		
		public function setViewAnimation(viewAnimation:ViewAnimationScene):void
		{
			_viewAnimation = viewAnimation;
		}
		
		public function setViewAudio(viewAudio:ViewAudioScene):void
		{
			_viewAudio = viewAudio;
		}
		
		public function showScene(playAudio:Boolean):void
		{
			if (_viewAudio && playAudio)
			{
				_viewAudio.showScene();
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.showScene();
			}			
		}
		
		public function hideScene():void
		{			
			if (_viewAudio)
			{
				_viewAudio.hideScene();
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.hideScene();
			}
		}
		
		protected function setObj3DProperties(flarasScene:FlarasScene, obj3D:DisplayObject3D):void
		{
			var rotation:Number3D;
			var scale:Number3D;
			
			obj3D.position = Number3D.add(flarasScene.getTranslation(), flarasScene.getParentPoint().getPosition());
			
			rotation = flarasScene.getRotation();
			obj3D.rotationX = rotation.x;
			obj3D.rotationY = rotation.y;
			obj3D.rotationZ = rotation.z;
			
			scale = flarasScene.getScale();
			obj3D.scaleX = scale.x;
			obj3D.scaleY = scale.y;
			obj3D.scaleZ = scale.z;			
		}
		
		public function setTranslation(translation:Number3D):void
		{
			if (_obj3D)
			{
				_obj3D.position = Number3D.add(translation, _baseFlarasScene.getParentPoint().getPosition());
			}			
		}
		
		public function reloadPointPosition():void
		{
			if (_obj3D)
			{
				_obj3D.position = Number3D.add(_baseFlarasScene.getTranslation(), _baseFlarasScene.getParentPoint().getPosition());
			}			
		}
		
		public function setRotation(rotation:Number3D):void
		{
			if (_obj3D)
			{
				_obj3D.rotationX = rotation.x;
				_obj3D.rotationY = rotation.y;
				_obj3D.rotationZ = rotation.z;				
			}
		}
		
		public function setScale(scale:Number3D):void
		{
			if (_obj3D)
			{
				_obj3D.scaleX = scale.x;
				_obj3D.scaleY = scale.y;
				_obj3D.scaleZ = scale.z;				
			}
		}
		
		public function setMirrorScaleFactor(mirrorScaleFactor:int):void
		{
			if (_obj3D)
			{
				_obj3D.scaleX *= mirrorScaleFactor;
			}
		}
		
		public function toggleMirror():void
		{
			_obj3D.scaleX *= -1;
		}
		
		public function unLoad():void
		{
			if (_viewAudio)
			{
				_viewAudio.unLoad();
			}
			
			if (_viewAnimation)
			{
				_viewAnimation.unLoad();
			}
		}
		
		public function destroyAudio():void
		{
			if (_viewAudio)
			{
				_viewAudio.unLoad();
				setViewAudio(null);
			}
		}
		
		public function unLoadAudio():void
		{
			_viewAudio.unLoad();
		}
	}
}